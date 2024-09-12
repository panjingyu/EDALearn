set NETLIST_DIR "dbg_designs/pci/implementation/cpV1_clkP1_drcV1__VenU80_pV1_cV1/pnr_out"
set MACRO_DIR "libraries/FreePDK45/OpenRAM"

set power_enable_analysis TRUE
#set power_enable_timing_analysis TRUE
set_host_options -max_cores 16

set search_path [list $NETLIST_DIR $MACRO_DIR]
set link_library [list \
    "/home/jp502/PDK/NangateOpenCellLibrary_PDKv1_3_v2010_12/db/slow.db" \
    $NETLIST_DIR $MACRO_DIR ]
read_verilog pci_bridge32_pnr.v
link_design pci_bridge32
current_design pci_bridge32

exit

# read_sdc $NETLIST_DIR/DigitalTop.mapped.sdc
read_parasitics     RC.spef.gz

set_clock_transition 3 wb_clk_i 
#clock input transition is 0.1, equivalent to frequency

set power_analysis_mode averaged
set_power_analysis_options -static_leakage_only
check_power
update_power
report_power > ptpx_static_power.rpt

exit


reset_switching_activity
set power_analysis_mode time_based
set power_enable_delay_shifted_event_analysis true
set_power_delay_shifted_event_analysis_options -effort_level low -write_activity_file "shifted_act.fsdb"
# set_power_analysis_options -effort_level low


#Map rtl to gate
# source -echo -verbose DigitalTop.saif_map

#read_fsdb -strip_path TestDriver/testHarness/chiptop/system/tile_prci_domain/tile_reset_domain/tile/core ../chipyard/vlsi/output/chipyard.TestHarness.TinyRocketConfig/rv32ui-p-simple.fsdb -rtl
#read_vcd -strip_path TOP/TestHarness/chiptop/system /home/gz66/projects/SystemPPA/chipyard/sims/verilator/output/chipyard.TestHarness.SmallBoomConfig/rv64mi-p-access.vcd
read_vcd "/home/jp502/Projects/EDA_benchmark_v2/waveforms/SmallBoom/median.vpd" -strip_path "TestDriver/testHarness/chiptop/system" -rtl
# set_power_analysis_options -cycle_accurate_clock clock

check_power
update_power
report_power  > ptpx_timed_power.rpt

exit