#-------------------------------------------------------------------------------
# Routing
#-------------------------------------------------------------------------------

set routing_start_time [clock seconds]

setNanoRouteMode -routeWithTimingDriven false -routeDesignFixClockNets true

set gr_start_time [clock seconds]
globalRoute
puts "\[Info\] The global routing stage duration is [expr [clock seconds] - $gr_start_time] sec"

# dump congestion
dumpCongestArea -all pnr_reports/congestion.rpt

set dr_start_time [clock seconds]
detailRoute
puts "\[Info\] The detail routing stage duration is [expr [clock seconds] - $dr_start_time] sec"

puts "\[Info\] The Routing stage duration is [expr [clock seconds] - $routing_start_time] sec"
puts "\[Info\] The total duration is [expr [clock seconds] - $start_time] sec"
saveDesign pnr_save/global_route.enc

setAnalysisMode -analysisType onChipVariation
timeDesign -postRoute -outDir pnr_reports/postRoute_timing
report_timing -max_paths 100 -path_group Reg2Reg > pnr_reports/route_timing.rpt.gz


set drc_start_time [clock seconds]
verify_drc -limit 10000000 -report pnr_reports/postRoute_drc_max1M.rpt
puts "\[Info\] The post-routing DRC stage duration is [expr [clock seconds] - $drc_start_time] sec"
saveDesign pnr_save/detail_route.enc


setDelayCalMode -SIAware True
timeDesign -postRoute -outDir pnr_reports/route_SI_timing

set opt_start_time [clock seconds]
optDesign -postRoute -outDir pnr_reports/route_SI_opt.rpt
puts "\[Info\] The post-routing optimization stage duration is [expr [clock seconds] - $opt_start_time] sec"
puts "\[Info\] The total duration is [expr [clock seconds] - $start_time] sec"



set drc_start_time [clock seconds]
verify_drc -limit 10000000 -report pnr_reports/postOpt_drc_max1M.rpt
puts "\[Info\] The post-optimization DRC stage duration is [expr [clock seconds] - $drc_start_time] sec"
puts "\[Info\] The total duration is [expr [clock seconds] - $start_time] sec"

timeDesign -postRoute -reportOnly -outDir pnr_reports/route_opt_timing
report_timing -max_paths 100 -path_group Reg2Reg > pnr_reports/route_opt_timing.rpt.gz
defOut pnr_out/route.def -routing
exec gzip pnr_out/route.def
fit
createSnapshot -dir pnr_out -name pnr_result

# Post-routing power analysis

do_power_analysis route_opt_power

set_power_analysis_mode -method static -corner max -off_pg_nets $init_pwr_net \
    -create_binary_db true -write_static_currents true
report_power -cap -pg_net -format=detailed -outfile pnr_reports/route_opt_power/static_max.rpt

# extract RC
# -effortLevel with medium/high requries Quantus QRC tech files
setExtractRCMode -engine postRoute -effortLevel medium -coupled true -total_c_th 0.0
extractRC
rcOut -spef pnr_out/RC.spef.gz

summaryReport -outfile pnr_reports/route_summary.rpt

# Rail analysis

create_power_pads -net $init_pwr_net -auto_fetch -format xy -vsrc_file $init_pwr_net.pp
create_power_pads -net $init_gnd_net -auto_fetch -format xy -vsrc_file $init_gnd_net.pp

## static

set_pg_library_mode -extraction_tech_file $qrc_tech_file  -celltype techonly \
    -power_pins { $init_pwr_net 0.85 } -ground_pins { $init_gnd_net } \
    -temperature 0
set_pg_library_mode -celltype techonly -default_area_cap 0.5 -extraction_tech_file $qrc_tech_file \
    -power_pins { $init_pwr_net 0.85 } -ground_pins { $init_gnd_net }
generate_pg_library -output ./tech_pglib

set_power_analysis_mode -reset
set_power_analysis_mode -method static -analysis_view best -corner max -create_binary_db true \
    -write_static_currents true -honor_negative_energy true -ignore_control_signals true
set_power_output_dir -reset
set_power_output_dir ./static_power_max
set_default_switching_activity -reset
set_default_switching_activity -input_activity 0.2 -period 10.0 -seq_activity 0.1 -clock_gates_output 0.1
read_activity_file -reset
set_power -reset
set_powerup_analysis -reset
set_dynamic_power_simulation -reset
# read_activity_file -format tcf design.tcf     # don't have any activity file
# FIXME: double-check reset net name
# set_switching_activity -activity 0 -net reset
# set_power -type cell BUFX2MTL 0.010w
# suspend
report_power -rail_analysis_format VS -outfile design.rpt


# set_rail_analysis_mode -method static -accuracy hd -power_grid_library { tech_pglib/techonly.cl } \
#     -verbosity true -report_shorts true -temperature 0 -enable_rlrp_analysis true
set_rail_analysis_mode -method static -power_switch_eco false -accuracy xd -power_grid_library { tech_pglib/techonly.cl } \
    -analysis_view best -process_techgen_em_rules true -enable_rlrp_analysis true -extraction_tech_file $qrc_tech_file -vsrc_search_distance 50 \
    -ignore_shorts false -enable_manufacturing_effects false -report_via_current_direction false
set_pg_nets -net $init_pwr_net -voltage 0.85 -threshold 0.765
set_pg_nets -net $init_gnd_net -voltage 0.0 -threshold 0.10
set_power_pads -net $init_pwr_net -format xy -file $init_pwr_net.pp
set_power_pads -net $init_gnd_net -format xy -file $init_gnd_net.pp
set_power_data -format current -scale 1 \
    "static_power_max/static_$init_pwr_net.ptiavg static_power_max/static_$init_gnd_net.ptiavg"
set_rail_analysis_domain -name default -pwrnets $init_pwr_net -gndnets $init_gnd_net
analyze_rail -type domain -results_directory ./rail_max_static default

## dynamic (issue)

# set_power_analysis_mode -method dynamic_vectorless \
#     -power_grid_library { tech_pglib/techonly.cl }
# report_power -toggle_rate -outfile pnr_reports/dyn_power.rpt

# set_rail_analysis_mode -accuracy xd -method dynamic -power_grid_library { tech_pglib/techonly.cl } \
#     -verbosity true -report_shorts true -temperature 0 -enable_rlrp_analysis true
# set_pg_nets -net $init_pwr_net -voltage 0.85 -threshold 0.765
# set_pg_nets -net $init_gnd_net -voltage 0.0 -threshold 0.10
# set_power_pads -net $init_pwr_net -format xy -file $init_pwr_net.pp
# set_power_pads -net $init_gnd_net -format xy -file $init_gnd_net.pp
# set_power_data -format current \
#     {static_${init_pwr_net}.ptiavg static_${init_gnd_net}.ptiavg dynamic_${init_pwr_net}.ptiavg dynamic_${init_gnd_net}.ptiavg}
# analyze_rail -type net -output ./ $init_pwr_net

# # dump IR drop results
# read_power_rail_results -rail_directory ./${init_pwr_net}_0C_dynamic
# report_power_rail_results -plot ir -filename pnr_reports/IR_dynamic_CTS.rpt -limit 10000000

# # dump timing window file
# write_timing_windows -power_compatible cts.twf

saveDesign pnr_save/route_opt.enc