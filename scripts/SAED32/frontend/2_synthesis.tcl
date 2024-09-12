#------------------------------------------------------------------------------
# Setup the libraries
#------------------------------------------------------------------------------

set synthesis_start_time [clock seconds]

# set_app_var search_path [list $OPENRAM_MACRO_DB_DIR $OPENRAM_MACRO_LIB_DIR]
set_app_var target_library [concat $slow_db]
set_app_var link_library [concat $slow_db]

# -----------------------------------------------------------------------------
# Associate libraries with min libraries
# -----------------------------------------------------------------------------

foreach max_lib [concat $slow_db ] \
        min_lib [concat $fast_db ] \
    {
        echo "set_min_library $max_lib -min_version $min_lib"
        set_min_library $max_lib -min_version $min_lib
    }

check_library

# -----------------------------------------------------------------------------
# Setup for Formality verification
# -----------------------------------------------------------------------------

set_svf ../data/${TOP_NAME}.synthesis.svf

# -----------------------------------------------------------------------------
# Setup for SAIF name mapping database
# -----------------------------------------------------------------------------

saif_map -start

#------------------------------------------------------------------------------
# Read design
#------------------------------------------------------------------------------

# Set to enable full range of flops for synthesis consideration
set compile_filter_prune_seq_cells false
set_app_var compile_seqmap_identify_shift_registers true
set_app_var compile_seqmap_identify_shift_registers_with_synchronous_logic false
set_app_var compile_enable_register_merging true
set_app_var compile_seqmap_identify_shift_registers true
set_app_var compile_seqmap_identify_shift_registers_with_synchronous_logic false
set_app_var compile_enable_register_merging true
set_app_var compile_seqmap_identify_shift_registers false
set hdlin_infer_multibit default_all

# Optimize constant registers 
# NOTE: Ensure any ID registers or other constant registers that should remain
#       in the design are suitibly don't touched!.
set_app_var compile_seqmap_propagate_constants true

# Identify architecturally instantiated clock gates
set_app_var power_cg_auto_identify true ;# Must be set before RTL is read

# Check for latches in RTL
set_app_var hdlin_check_no_latch true

define_design_lib WORK -path ./WORK
redirect -tee analyze.log {
    analyze -format ${FILE_FORMAT} -recursive -autoread $RTL_DIR -top ${TOP_NAME}
}
redirect -tee elaborate.log {
    elaborate ${TOP_NAME}
}
current_design ${TOP_NAME}
link

# -----------------------------------------------------------------------------
# Source clocks
# -----------------------------------------------------------------------------

create_clock -name $CLOCK_NAME -period $env(clk_period) [get_ports $CLOCK_NAME ]

# -----------------------------------------------------------------------------
# Generated clocks
# -----------------------------------------------------------------------------

## Create clock startpoints in DC to enable hierarchy reporting by clock group
if {[info exists EXTRA_CLOCK_NAMES]} {
    foreach clk_ $EXTRA_CLOCK_NAMES {
        create_clock -name $clk_ -period $env(clk_period) [get_ports $clk_]
    }
}

#------------------------------------------------------------------------------
# Check for design errors
#------------------------------------------------------------------------------
# Prevent assignment statements in the Verilog netlist.
set_fix_multiple_port_nets -all -buffer_constants -feedthroughs [all_designs]

check_design -summary
check_design > ${REPORTS_DIR}/check_design.rpt
check_timing > ${REPORTS_DIR}/check_timing.rpt

#------------------------------------------------------------------------------
# Set DRC constraints
#------------------------------------------------------------------------------


set_max_fanout      $env(DRC_max_fanout)         $TOP_NAME
set_max_transition  $env(DRC_max_transition)     $TOP_NAME
set_max_capacitance $env(DRC_max_capacitance)    $TOP_NAME
set high_fanout_net_threshold $env(DRC_high_fanout_net_threshold)
set high_fanout_net_pin_capacitance $env(DRC_high_fanout_pin_capacitance)

#-----------------------------------------------------------------------------
# Compile the design
#-----------------------------------------------------------------------------


set_dynamic_optimization $env(set_dyn_opt)
set_leakage_optimization $env(set_lea_opt)

set compile_cmd ""
if {$env(compile_cmd) eq "compile"} {
    set compile_cmd "compile -map_effort $env(map_effort) -power_effort $env(power_effort) -area_effort $env(area_effort)"
} else {
    set compile_cmd "compile_ultra"
}

echo $compile_cmd
eval $compile_cmd

# -----------------------------------------------------------------------------
# Change names before output
# -----------------------------------------------------------------------------

#ungroup -all -flatten
# change_names -rules verilog -hierarchy


# If this will be a sub-block in a hierarchical design, uniquify with block unique names
# to avoid name collisions when integrating the design at the top level
set_app_var uniquify_naming_style "${TOP_NAME}_%s_%d"
uniquify -force

define_name_rules verilog -case_insensitive
change_names -rules verilog -hierarchy -verbose > ./change_names

#--------------------------------------------------------------------------------
# Generate final reports
#--------------------------------------------------------------------------------

report_qor > ${REPORTS_DIR}/qor.rpt
report_timing -max_paths 15 -transition_time -nets -attributes -nosplit > ${REPORTS_DIR}/timing.rpt
report_area -nosplit > ${REPORTS_DIR}/area.rpt
report_power -nosplit > ${REPORTS_DIR}/power.rpt
report_clock_gating -nosplit > ${REPORTS_DIR}/cg.rpt
report_reference -nosplit > ${REPORTS_DIR}/ref.rpt
list_libs > ${REPORTS_DIR}/lib.rpt
report_hierarchy > ${REPORTS_DIR}/hierarchy.rpt
report_clock > ${REPORTS_DIR}/clock.rpt

#--------------------------------------------------------------------------------
# Save the design
#--------------------------------------------------------------------------------
write -format verilog -hierarchy -output ${RESULTS_DIR}/${FINAL_VERILOG_OUTPUT_FILE}
write_sdc -nosplit ${RESULTS_DIR}/${FINAL_SDC_OUTPUT_FILE}
write_parasitics -output ${RESULTS_DIR}/${FINAL_PARSITICS_OUTPUT_FILE}
write -format ddc -hierarchy -output ${RESULTS_DIR}/${TOP_NAME}.ddc
write -format verilog -output ${RESULTS_DIR}/${FINAL_VERILOG_OUTPUT_FILE}.flatten.v
write_sdc -nosplit ${RESULTS_DIR}/${FINAL_SDC_OUTPUT_FILE}
write_parasitics -output ${RESULTS_DIR}/${FINAL_PARSITICS_OUTPUT_FILE}
saif_map -type primepower -write_map ${RESULTS_DIR}/${TOP_NAME}.pwr.saif_map
saif_map -write_map ${RESULTS_DIR}/${TOP_NAME}.saif_map

# -----------------------------------------------------------------------------
# Report message summary and quit
# -----------------------------------------------------------------------------

print_message_info

puts "\[Info\] The total duration is [expr [clock seconds] - $synthesis_start_time] sec"

exec touch _Finished_

exit
