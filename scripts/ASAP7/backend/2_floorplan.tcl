# Floorplan parameters
set ASPECT_RATIO 1
set TARGET_UTIL $env(target_util)

setDrawView fplan
floorPlan -site asap7sc6t -r ${ASPECT_RATIO} ${TARGET_UTIL}


#pinAlignment -newLayer M6 \
#             -pinNames [get_attribute [get_ports -filter "is_clock_used_as_clock==false"] full_name] \
#             -ptnInst ${top_module} \
#             -refObj {} \
#             -legalizePin

#pinAlignment -newLayer M6 \
#             -pinNames [get_attribute [get_ports -filter "is_clock_used_as_clock==true"]  full_name] \
#             -ptnInst ${top_module} \
#             -refObj {} \
#   	     -legalizePin

setPinAssignMode -pinEditInBatch true

# Input pins are located on the left side of the die
editPin -fixOverlap 1 -spreadDirection clockwise -layer M2 -spreadType side -side LEFT \
        -pin [get_attribute [get_ports -filter "is_clock_used_as_clock==false && direction==in"] full_name]

# Output pins are located on the right side of the die
editPin -fixOverlap 1 -spreadDirection clockwise -layer M2 -spreadType side -side RIGHT \
        -pin [get_attribute [get_ports -filter "is_clock_used_as_clock==false && direction==out"] full_name]

# Clock pins are located on top of the die
editPin -fixOverlap 1 -spreadDirection clockwise -layer M3 -spreadType CENTER -side TOP \
        -pin [get_attribute [get_ports -filter "is_clock_used_as_clock==true"] full_name] \
        -use CLOCK

setPinAssignMode -pinEditInBatch false

###########

planDesign

checkFPlan > pnr_reports/init_check.rpt
defOut pnr_out/init.def
saveDesign pnr_save/floorplan.enc
summaryReport -outfile pnr_reports/floorplan_summary.rpt
exec gzip pnr_reports/floorplan_summary.rpt &
