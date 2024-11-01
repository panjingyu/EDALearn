setLibraryUnit -time 1ps

source <your_global_init_files>.globals
init_design

# this is example tcl to make a flexible floorplan size

set cellheight [expr 0.270 * 4 ]
set cellhgrid  0.216

set fpxdim [expr $cellhgrid * 400 ]
set fpydim [expr $cellheight * 74 ]


proc m2followRail {} {
    set var(std_cell_overlay_rail_width) 0.072
    set var(std_cell_overlay_rail_layer) M2
    set var(insert_std_cell_rail_vias) 1
    # set var(std_cell_rail_via_step) 0.5
    set var(std_cell_rail_via_step) 1
    set var(row_height) [expr [dbSiteSizeY [dbGetDefaultTechSite]] * [dbgMicronPerDBU]]

    # Add the stripes over the existing followpin routing:

    setAddStripeMode -stacked_via_bottom_layer M1 \
        -stacked_via_top_layer M2 \
        -allow_nonpreferred_dir stripe \

    # part of the techLEF has M1 vertical enclosure. This is good for routing but not here

    setViaGenMode -ignore_viarule_enclosure false

    # order must be top down or via generation does not work

    addStripe \
    -direction horizontal \
    -set_to_set_distance [expr $var(row_height) * 2] \
    -spacing [expr $var(row_height) - $var(std_cell_overlay_rail_width)] \
    -ybottom_offset -[expr $var(std_cell_overlay_rail_width) * 0.5] \
    -ytop_offset -[expr $var(std_cell_overlay_rail_width) * 0.5] \
    -width $var(std_cell_overlay_rail_width) \
    -nets [list VDD VSS] \
    -layer M2

    addStripe \
    -direction horizontal \
    -set_to_set_distance [expr $var(row_height) * 2] \
    -spacing [expr $var(row_height) - $var(std_cell_overlay_rail_width)] \
    -ybottom_offset -[expr $var(std_cell_overlay_rail_width) * 0.5] \
    -ytop_offset -[expr $var(std_cell_overlay_rail_width) * 0.5] \
    -width $var(std_cell_overlay_rail_width) \
    -nets [list VDD VSS] \
    -layer M1

    return

    # This only made one via per stripe
    # Run editPowerVia to add the other vias between M2 and M1:
    #
    # change design mode just for this, then back
    setDesignMode -process 90

    # setViaGenMode -ignore_viarule_enclosure true \
    #    -use_clone_via 0
    
    # editPowerVia \
    #    -skip_via_on_pin {Pad Block Cover Standardcell} \
    #    -skip_via_on_wire_shape {Ring Blockring Corewire Blockwire Iowire Padring Fillwire Noshape} \
    #    -bottom_layer M1 \
    #    -add_vias 1 \
    #    -orthogonal_only 0 \
    #    -top_layer M2
    
    ####

    # Remove all of the vias
    editPowerVia -delete_vias 1 \
        -bottom_layer M1 \
        -top_layer M2

    # Delete every via on power because we're specifying the SAV ones we want to use.

    # Vias for M1-to-M2
    # setViaGenMode -viarule_preference V1_0_0_0_0_VxBAR_SAV -ignore_DRC true 
    # Force the tool to use the SAV one and ignore the CUT ENCLOSURE DRC violation (not a DRC error in Virtuoso when running DRC)
    # editPowerVia -skip_via_on_pin {Pad Block Cover Standardcell} -skip_via_on_wire_shape {Ring Blockring Followpin Corewire Blockwire \
    # 	     Iowire Padring Fillwire Noshape} -bottom_layer M1 -split_long_via {0.070 0.216 -1 -1} -add_vias 1 -orthogonal_only 0 -top_layer M2 

    # align properly
    # editPowerVia -skip_via_on_pin {Pad Block Cover Standardcell} \
    #              -skip_via_on_wire_shape {Ring Blockring Followpin Corewire Blockwire Iowire Padring Fillwire Noshape} \
    #              -bottom_layer M1 \
    #              -top_layer M2 \
    #              -split_long_via {0.070 0.216 0.216 -1} \
    #              -add_vias 1 \
    #              -orthogonal_only 0

    # skip every other and align properly
    editPowerVia -skip_via_on_pin {Pad Block Cover Standardcell} \
                -skip_via_on_wire_shape {Ring Blockring Followpin Corewire Blockwire Iowire Padring Fillwire Noshape} \
                -bottom_layer M1 \
                -top_layer M2 \
                -split_long_via {0.070 0.432 0.216 -1} \
                -add_vias 1 \
                -orthogonal_only 0

    setDesignMode -process 10

}