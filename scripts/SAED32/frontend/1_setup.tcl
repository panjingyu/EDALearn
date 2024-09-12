#------------------------------------------------------------------------------
# Tool Setup
#------------------------------------------------------------------------------

set FINAL_VERILOG_OUTPUT_FILE "${TOP_NAME}.mapped.v"
set FINAL_SDC_OUTPUT_FILE     "${TOP_NAME}.mapped.sdc"
set FINAL_PARSITICS_OUTPUT_FILE "${TOP_NAME}.spef.gz"

set REPORTS_DIR "reports"
set RESULTS_DIR "results"

file mkdir ${REPORTS_DIR}
file mkdir ${RESULTS_DIR}

set_app_var disable_multicore_resource_checks true
set_host_options -max_cores 8
set_app_var html_log_enable true


# Optimize constant registers 
# NOTE: Ensure any ID registers or other constant registers that should remain
#       in the design are suitibly don't touched!.
set_app_var compile_seqmap_propagate_constants true
# Identify architecturally instantiated clock gates
set_app_var power_cg_auto_identify true ;# Must be set before RTL is read
# Check for latches in RTL
set_app_var hdlin_check_no_latch true
# Default to read Verilog as standard version 2001 (not 2005)
set_app_var hdlin_vrlg_std 2001