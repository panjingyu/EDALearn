#-------------------------------------------------------------------------------
# Clock tree synthesis
#-------------------------------------------------------------------------------

set cts_start_time [clock seconds]

set_ccopt_property buffer_cells $CLKBUF_CELLS
# set_ccopt_property clock_gating_cells $CLKGT_CELLS
set_ccopt_property inverter_cells $INV_CELLS

set_ccopt_property cell_density $env(cts_cell_density)
set_ccopt_property clock_gate_buffering_location $env(cts_clock_gate_buffering_location)
set_ccopt_property clone_clock_gates $env(cts_clone_clock_gates)

setNanoRouteMode -routeWithTimingDriven false -routeDesignFixClockNets true
# set_ccopt_mode -cts_opt_type cluster
ccopt_design -cts
refinePlace
timeDesign -postCTS -outDir pnr_reports/cts_time

#-------------------------------------------------------------------------------
# Post-CTS timing optimization
#-------------------------------------------------------------------------------
setOptMode -maxDensity $env(postcts_opt_max_density) \
    -powerEffort $env(postcts_opt_power_effort) \
    -reclaimArea $env(postcts_opt_reclaim_area) \
    -fixFanoutLoad $env(postcts_fix_fanout_load)
optDesign -postCTS -outDir pnr_reports/cts_opt

set inp   [all_inputs -no_clocks]
set outp  [all_outputs]
set mems  [all_registers -macros ]
set icgs  [filter_collection [all_registers] "is_integrated_clock_gating_cell == true"]
set regs  [remove_from_collection [all_registers -edge_triggered] $icgs]
set allregs  [all_registers]
group_path   -name Reg2Reg      -from $regs -to $regs

report_timing -max_paths 100 -path_group Reg2Reg > pnr_reports/cts_opt_timing.rpt.gz

report_ccopt_clock_tree_structure -file pnr_reports/ccopt.txt
defOut pnr_out/clock.def

saveDesign pnr_save/cts.enc

puts "\[Info\] The CTS stage duration is [expr [clock seconds] - $cts_start_time] sec"
puts "\[Info\] The total duration is [expr [clock seconds] - $start_time] sec"
