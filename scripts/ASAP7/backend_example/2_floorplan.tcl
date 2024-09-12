floorPlan -site coreSite -s $fpxdim $fpydim 0 0 0 0
puts "Floorplan is $fpxdim by $fpydim"
puts "Total area is [expr $fpxdim * $fpydim ] square um"
puts "[expr $fpydim / $cellheight] standard cell rows tall"

# Innovus is not putting tracks on the bottom cell row. That causes problems
# since it won't route to them on proper tracks.

# This moves the core up one.
# Weirdly, it moves it up 1.008, but that seems to fix the track issue.
changeFloorplan -coreToBottom 1.08

add_tracks -honor_pitch 
