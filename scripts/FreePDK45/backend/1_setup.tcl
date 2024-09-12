#-------------------------------------------------------------------------------
# Setting Design name and effort level for various stages
#-------------------------------------------------------------------------------
set VERILOG_FILE "${NETLIST_DIR}/${TOP_NAME}.mapped.v"
set SDC_FILE     "${NETLIST_DIR}/${TOP_NAME}.mapped.sdc"


set top_module    ${TOP_NAME}   ;# Top design name

# set DATE [clock format [clock seconds] -format "%b%d-%T"] 

set start_time [clock seconds]

#-------------------------------------------------------------------------------
# Creating the directory for logs, reports and outputs 
#-------------------------------------------------------------------------------
if {![file exists pnr_logs]} {
    file delete -force pnr_logs
}
if {![file exists pnr_out]} {
    file delete -force pnr_out
}
if {![file exists pnr_reports]} {
    file delete -force pnr_reports
}

puts "Creating directories: pnr_logs, pnr_out, pnr_reports, pnr_save"
file mkdir pnr_logs
file mkdir pnr_out
file mkdir pnr_reports
file mkdir pnr_save

setMultiCpuUsage -localCpu 8
setLibraryUnit -cap 1pf -time 1ns

#-------------------------------------------------------------------------------
# Import the design
#-------------------------------------------------------------------------------

proc prefix_lib {lib_list prefix} {
    set new_list {}
    foreach lib $lib_list {
        lappend new_list "${prefix}/${lib}"
    }
    return $new_list
}

create_library_set -name slow -timing [list $slow_lib [prefix_lib $openram_lib(slow) $OPENRAM_MACRO_LIB_DIR]]
create_library_set -name typical -timing [list $typical_lib [prefix_lib $openram_lib(typical) $OPENRAM_MACRO_LIB_DIR]]
create_library_set -name fast -timing [list $fast_lib [prefix_lib $openram_lib(fast) $OPENRAM_MACRO_LIB_DIR]]

create_rc_corner -name default -cap_table $cap_tbl_file -T 25

create_delay_corner -name slow -library_set slow -rc_corner default
create_delay_corner -name typical -library_set typical -rc_corner default
create_delay_corner -name fast -library_set fast -rc_corner default

create_constraint_mode -name default -sdc_files ${SDC_FILE}
create_analysis_view -name best -constraint_mode default -delay_corner fast
create_analysis_view -name worst -constraint_mode default -delay_corner slow
create_analysis_view -name normal -constraint_mode default -delay_corner typical 

set init_lef_file $lef_files
set init_verilog ${VERILOG_FILE}
set init_design_set_top 0

set init_pwr_net {VDD}
set init_gnd_net {VSS}

init_design -setup worst -hold best
setDesignMode -flowEffort $env(design_flow_effort) -powerEffort $env(design_power_effort) -process 45

report_analysis_views > pnr_reports/analysis_views.rpt

#-------------------------------------------------------------------------------
# Logging functions
#-------------------------------------------------------------------------------

proc getCellInfo { fd } {
    puts $fd "NumOfCells: [sizeof_collection [get_cells  * -hierarchical]]\n"
    
    foreach_in_collection cell [get_cells -hierarchical] {
        puts $fd "cell name : [get_object_name $cell]"
        #puts $fd "area : [get_property $cell area]"
        #puts $fd "modelType: [get_property $cell instance_model]"
        puts $fd "position : [get_property $cell x_coordinate_min] [get_property $cell y_coordinate_min] [get_property $cell x_coordinate_max] [get_property $cell y_coordinate_max]"
        puts $fd "type: [get_property $cell ref_lib_cell_name]"
        
        set pins [all_fanin -to [get_property $cell ref_lib_cell_name]]
        set libCell [get_lib_cells -of_objects $cell]

        puts -nonewline $fd "fanin pins: "
        #puts -nonewline "fanin pins: "
        foreach_in_collection libPin [get_lib_pins -of_objects $libCell] {
            if {[get_property $libPin direction] == "in"} {
                puts -nonewline $fd "[get_property $libPin name] "
                #puts -nonewline "[get_property $libPin name] "
            }
        }
        puts $fd ""
        #puts ""
        puts -nonewline $fd "fanout pins: "
        #puts -nonewline "fanout pins: "
        foreach_in_collection libPin [get_lib_pins -of_objects $libCell] {
            if {[get_property $libPin direction] == "out"} {
                puts -nonewline $fd "[get_property $libPin name] "
                #puts -nonewline "[get_property $libPin name] "
            }
        }
        puts $fd ""
        #set libPins [get_lib_pins -of_objects $libCell]
        #puts "libCell: [get_property $libCell object_type]"
        
        #puts $fd "    Pins:"
        if { [expr [sizeof_collection [get_pins -of_objects cell] ] == 0] } {
            
        }
        foreach_in_collection pin [get_pins -of_objects cell] {
            #puts $fd "    name: [get_object_name $pin], load: [get_property $pin fanout_load],  [get_property $pin x_coordinate] [get_property $pin y_coordinate]"
        }
        puts $fd ""
    }
}

proc getNetInfo { fd } {
    foreach_in_collection net  [get_nets  * -hierarchical]  {
        puts $fd "net name : [get_object_name $net]"
        set cells [get_cells -of_objects $net]
        #puts $fd "cells : [get_object_name $cells]"
        set pins [get_pins -of_objects $net]

        set pins_load [get_property $net load_pins]
        set pins_driver [get_property $net driver_pins]

        puts $fd "cell/pin : [get_object_name $pins_driver] [get_object_name $pins_load]"
        set allPins [add_to_collection $pins_driver $pins_load]
        puts -nonewline $fd "in/out:"
        for {set i 0} \
            {$i < [sizeof_collection $allPins]} \
            {incr i} {
                #puts $i
                if {$i < [sizeof_collection $pins_driver]} {
                    puts -nonewline $fd " in"
                } else {
                    puts -nonewline $fd " out"
                }
                
        }
        puts $fd ""

        #puts $fd "pins_driver : [get_object_name $pins_driver]"
        #puts $fd "cell/pin : [get_object_name $pins]"

        puts -nonewline $fd "X:"
        foreach_in_collection pin $allPins {
            set port [get_ports -quiet [get_object_name $pin]]
            if {[expr [sizeof_collection $port] > 0]} {
                puts -nonewline $fd " [get_property $port x_coordinate]"
            } else {
                puts -nonewline $fd " [get_property $pin x_coordinate]"
            }
        }
        puts $fd ""
        puts -nonewline $fd "Y:"
        foreach_in_collection pin $allPins {
            set port [get_ports -quiet [get_object_name $pin]]
            if {[expr [sizeof_collection $port] > 0]} {
                puts -nonewline $fd " [get_property $port y_coordinate]"
            } else {
                puts -nonewline $fd " [get_property $pin y_coordinate]"
            }
        }
        puts $fd ""
        #puts $fd "X: [get_property $pins x_coordinate]"
        #puts $fd "Y: [get_property $pins y_coordinate]"
        puts $fd "load: [get_property $pins fanout_load]"
        puts $fd ""
    }
}

proc getCellRelation2 { fd } {
    foreach_in_collection net  [get_nets  * -hierarchical]  {
        puts $fd "net name : [get_object_name $net]"
        set cells [get_cells -of_objects $net]
        foreach_in_collection cell [get_cells -of_objects $net] {
            puts $fd "cell : [get_object_name $cell], [get_property $cell x_coordinate_min] [get_property $cell y_coordinate_min] [get_property $cell x_coordinate_max] [get_property $cell y_coordinate_max]"    
        }
        puts $fd "\n"
    }
}

proc netSize { net } {
    return [sizeof_collection [get_cells -of_objects $net -hierarchical]]
}

proc checkNets { fd } {
    foreach_in_collection net  [get_nets  * -hierarchical]  {
        if {[netSize $net] > 15} {
            puts $fd "LargeFan"
        }
        if {[netSize $net] > 50} {
            puts $fd "VeryLargeFan"
        }
        puts $fd "fanout: [expr [netSize $net] - 1]"
        puts $fd "net name: [get_object_name $net]"

        #set dri [get_cells -of_objects [get_property $net driver_pins]]
        set dri [get_pins -quiet [get_property $net driver_pins]]
        set port [get_ports -quiet -of_objects $net]

        #set sinks [remove_from_collection [get_cells -of_objects $net -hierarchical -leaf] $dri]
        set sinks [remove_from_collection [get_pins -quiet -of_objects $net -hierarchical -leaf] $dri]

        if {[expr [sizeof_collection $dri] == 0]} {
            puts $fd "PortsIn!!!!"

            if {[expr [sizeof_collection $port] > 0] && [expr {[get_property $port direction] == "in"}]} {
                puts $fd "driver: [get_object_name $port] NangateOpenCellLibrary/inPort [get_property $port x_coordinate] [get_property $port y_coordinate]"
            } else {
                puts $fd "driver: NotFound NotFound NotFound NotFound"
            }
        } else  {
            puts $fd "driver: [get_object_name $dri] \
                              [get_object_name [get_lib_cells -of_objects [get_cells -of_objects $dri] ]] \
                              [get_property $dri x_coordinate] [get_property $dri y_coordinate]"
        }

        if {[expr [sizeof_collection $sinks] == 0] && [expr [sizeof_collection $port] > 0] && [expr {[get_property $port direction] == "out"}]} {
            puts $fd "PortsOut!!!!"
            puts $fd "sinks: [get_object_name $port]"
            puts $fd "sink libs: NangateOpenCellLibrary/inPort"
            puts $fd "X: [get_property $port x_coordinate]"
            puts $fd "Y: [get_property $port y_coordinate]"
        } elseif {[expr [sizeof_collection $sinks] > 0]} {
            puts $fd "sinks: [get_object_name $sinks ]"
            puts $fd "sink libs: [get_object_name [get_lib_cells -of_objects [get_cells -of_objects $sinks] ]]"
            puts $fd "X: [get_property $sinks x_coordinate ]"
            puts $fd "Y: [get_property $sinks y_coordinate ]"
        } else {
            puts $fd "sinks: NotFound"
            puts $fd "sink libs: NotFound"
            puts $fd "X: NotFound"
            puts $fd "Y: NotFound"
        }
        puts $fd "" 
    }
    puts $fd "\n End \n" 
}

proc check_text {log_file checked_text} {
    set file [open $log_file r]
    set found 0

    while {[gets $file line] >= 0} {
        if {[regexp $checked_text $line]} {
            set found 1
            break
        }
    }

    close $file
    return $found
}

proc do_power_analysis {report_folder} {
    set_default_switching_activity -input_activity 0.2 -seq_activity 0.1
    propagate_activity
    set_power_output_dir pnr_reports/$report_folder
    report_power -cap -pg_net -format=detailed -outfile design.rpt.gz
    report_power -clock_network all -outfile clock.rpt.gz
    # write_tcf pnr_reports/$report_folder/activity.tcf
}