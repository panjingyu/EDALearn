clearGlobalNets
globalNetConnect VDD -type pgpin -pin vdd -inst * -module {}
globalNetConnect VSS -type pgpin -pin vss -inst * -module {}
globalNetConnect VDD -type pgpin -pin VDD -inst * -module {}
globalNetConnect VSS -type pgpin -pin VSS -inst * -module {}

addWellTap -cell TAPCELL_ASAP7_75t_L -cellInterval 50 -inRowOffset 10.564

setAddStripeMode -stacked_via_bottom_layer M1 \
    -stacked_via_top_layer M2

sroute -connect { blockPin padPin padRing corePin floatingStripe } \
    -layerChangeRange { M1 Pad } \
    -blockPinTarget { nearestTarget } \
    -padPinPortConnect { allPort oneGeom } \
    -padPinTarget { nearestTarget } \
    -corePinTarget { firstAfterRowEnd } \
    -floatingStripeTarget { blockring padring ring stripe ringpin blockpin followpin } \
    -allowJogging 1 \
    -crossoverViaLayerRange { M1 Pad } \
    -nets { VDD VSS } \
    -allowLayerChange 1 \
    -blockPin useLef \
    -targetViaLayerRange { M1 }

### Intervene Here. Manually fix the Top M1 Follow Rail

# setViaGenMode -viarule_preference { M2_M1p }
# source "m2followRail.tcl"
m2followRail

setViaGenMode -viarule_preference { M6_M5widePWR1p152 M5_M4widePWR0p864 M4_M3widePWR0p864 M3_M2widePWR0p648 }

# ! VALUES BELOW MAY NEED TO BE ADJUSTED FOR HOW innovus INTERPRETS YOUR FLOORPLAN

# has to be 5, 9, 13, ... change the 8 to widen by 4 min widths

set m3pwrwidth [expr 0.072 * (5 + (4 * 2))]
set m3pwrset2settracks  220
set m3pwrset2setdist    [expr $m3pwrset2settracks * 0.144]
print "M3 PWR width, temp and set to set distance: $m3pwrwidth $m3pwrset2settracks $m3pwrset2setdist"

# must be odd multiple of width and space so we get an even number of intervening tracks and stay on grid

set m3pwrspacing [expr 0.072 * 21]

# the xoffset specifies the left edge of the 1st wire.
# since the 1st track is wire (not 1/2 space) now we need an even number (width + space) for xoffset

set m3pwrxoffset [expr (0.072 * 26) + 0.036]
print "M3 PWR spacing and offset: $m3pwrspacing $m3pwrxoffset"

addStripe -extend_to design_boundary \
    -skip_via_on_wire_shape Noshape \
    -max_same_layer_jog_length 0.32 \
    -set_to_set_distance $m3pwrset2setdist \
    -skip_via_on_pin Standardcell \
    -stacked_via_top_layer Pad \
    -spacing $m3pwrspacing \
    -xleft_offset $m3pwrxoffset \
    -merge_stripes_value 0.16 \
    -layer M3 \
    -width $m3pwrwidth \
    -nets {VDD VSS} \
    -stacked_via_bottom_layer M2

set m4pwrwidth [expr 0.096 * (5 + (4 * 1))]
set m4pwrset2settracks  320
set m4pwrset2setdist    [expr $m4pwrset2settracks * 0.192]
print "M4 PWR width, temp and set to set distance: $m4pwrwidth $m4pwrset2settracks $m4pwrset2setdist"

# must be odd multiple of width and space so we get an even number of intervening tracks and stay on grid

set m4pwrspacing [expr 0.096 * 21]

# the xoffset specifies the left edge of the 1st wire.
# since the 1st track is wire (not 1/2 space) now we need an even number (width + space) for xoffset

set m4pwrxoffset [expr (0.096 * 26) - 0.036]
print "M4 PWR spacing and offset: $m4pwrspacing $m4pwrxoffset"

setAddStripeMode \
    -max_via_size { Stripe 100 100 100 } \
    -via_using_exact_crossover_size true \
    -stacked_via_bottom_layer M3 \
    -stacked_via_top_layer M4

addStripe -extend_to design_boundary \
    -direction horizontal \
    -skip_via_on_wire_shape Noshape \
    -max_same_layer_jog_length 0.32 \
    -set_to_set_distance $m4pwrset2setdist \
    -skip_via_on_pin Standardcell \
    -spacing $m4pwrspacing \
    -start_offset $m4pwrxoffset \
    -merge_stripes_value 0.16 \
    -layer M4 \
    -width $m4pwrwidth \
    -nets {VDD VSS}

set m5pwrwidth [expr 0.096 * (5 + (4 * 1))]
set m5pwrset2settracks  320
set m5pwrset2setdist    [expr $m5pwrset2settracks * 0.192]
print "M5 PWR width, temp and set to set distance: $m5pwrwidth $m5pwrset2settracks $m5pwrset2setdist"

# must be odd multiple of width and space so we get an even number of intervening tracks and stay on grid

set m5pwrspacing [expr 0.096 * 21]

# the xoffset specifies the left edge of the 1st wire.
# since the 1st track is wire (not 1/2 space) now we need an even number (width + space) for xoffset

set m5pwrxoffset [expr (0.096 * 70) + 0.024 ]
print "M5 PWR spacing and offset: $m5pwrspacing $m5pwrxoffset"

setAddStripeMode -stacked_via_bottom_layer M4 \
    -stacked_via_top_layer M5

setViaGenMode -bar_cut_orientation horizontal

addStripe -extend_to design_boundary \
    -direction vertical \
    -skip_via_on_wire_shape Noshape \
    -max_same_layer_jog_length 0.32 \
    -set_to_set_distance $m5pwrset2setdist \
    -skip_via_on_pin Standardcell \
    -spacing $m5pwrspacing \
    -start_offset $m5pwrxoffset \
    -merge_stripes_value 0.16 \
    -layer M5 \
    -width $m5pwrwidth \
    -nets {VDD VSS}

set m6pwrwidth [expr 0.128 * (5 + (4 * 1))]
set m6pwrset2settracks  220
set m6pwrset2setdist    [expr $m6pwrset2settracks * 0.256]
print "M6 PWR width, temp and set to set distance: $m6pwrwidth $m6pwrset2settracks $m6pwrset2setdist"

# must be odd multiple of width and space so we get an even number of intervening tracks and stay on grid

set m6pwrspacing [expr 0.128 * 21]

# the xoffset specifies the left edge of the 1st wire.
# since the 1st track is wire (not 1/2 space) now we need an even number (width + space) for xoffset

set m6pwrxoffset [expr (0.128 * 50) + 0.008 ]
print "M6 PWR spacing and offset: $m6pwrspacing $m6pwrxoffset"

setAddStripeMode -stacked_via_bottom_layer M5 \
    -stacked_via_top_layer M6

setViaGenMode -bar_cut_orientation vertical

addStripe -extend_to design_boundary \
    -direction horizontal \
    -skip_via_on_wire_shape Noshape \
    -max_same_layer_jog_length 0.32 \
    -set_to_set_distance $m6pwrset2setdist \
    -skip_via_on_pin Standardcell \
    -spacing $m6pwrspacing \
    -start_offset $m6pwrxoffset \
    -merge_stripes_value 0.16 \
    -layer M6 \
    -width $m6pwrwidth \
    -nets {VDD VSS}
