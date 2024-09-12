#-------------------------------------------------------------------------------
# Placement
#-------------------------------------------------------------------------------

set place_start_time [clock seconds]

# TODO: verify there's no tapcell
# deleteFiller -cell $TAPCELL
# addEndCap -preCap $TAPCELL -postCap $TAPCELL -prefix ENDCAP

#addWellTap -cell $TAPCELL -cellInterval 100

set check_place_out pnr_reports/check_place.out

setPlaceMode -place_global_timing_effort $env(place_global_timing_effort) \
    -place_global_cong_effort $env(place_global_cong_effort) \
    -place_detail_wire_length_opt_effort $env(place_detail_wire_length_opt_effort) \
    -place_global_max_density $env(place_global_max_density) \
    -activity_power_driven $env(place_activity_power_driven)

# NOTE: add placement constraints here

# b14: lower left blockage
# pbV1
# createPlaceBlockage -name "block_1" -box {10 30 50 90} -type hard
# pbV2
# createPlaceBlockage -name "block_1" -box {10 30 50 90} -type soft -density 75

# sasc: upper right blockage
# pbV1
# createPlaceBlockage -name "block_1" -box {35 23 42 42} -type soft
# pbV2
# createPlaceBlockage -name "block_1" -box {35 23 42 42} -type soft -density 50
# pbV3 result almost no different than pbV2
# createPlaceBlockage -name "block_1" -box {35 23 42 42} -type soft -density 75
# pbV4
# createPlaceBlockage -name "block_1" -box {35 23 42 42} -type partial -density 75
# pbV5
# createPlaceBlockage -name "block_1" -box {35 23 42 42} -type partial -density 50
# pbV6
createPlaceBlockage -name "block_1" -box {26 20 42 42} -type partial -density 55
# pbV7
# createPlaceBlockage -name "block_1" -box {26 20 42 42} -type partial -density 65


placeDesign
refinePlace
#place_opt_design -incremental

#setAnalysisMode -analysisType onChipVariation
timeDesign -preCTS -outDir pnr_reports/place_time
report_timing -max_paths 100 > pnr_reports/place_timing.rpt.gz

checkPlace $check_place_out



#-------------------------------------------------------------------------------
# Pre-CTS timing optimization
#-------------------------------------------------------------------------------

setOptMode -maxDensity $env(prects_opt_max_density) \
    -powerEffort $env(prects_opt_power_effort) \
    -reclaimArea $env(prects_opt_reclaim_area) \
    -fixFanoutLoad $env(prects_fix_fanout_load)
optDesign -preCTS -outDir pnr_reports/place_opt
# set _REPORTS_PATH $REPORTS_PATH
report_timing -max_paths 100 > pnr_reports/place_opt_timing.rpt.gz


puts "\[Info\] The Placement stage duration is [expr [clock seconds] - $place_start_time] sec"
puts "\[Info\] The total duration is [expr [clock seconds] - $start_time] sec"

#-------------------------------------------------------------------------------
# Log info & save design
#-------------------------------------------------------------------------------

do_power_analysis place_opt_power

defOut pnr_out/place.def
saveDesign pnr_save/placement.enc
summaryReport -outfile pnr_reports/placement_summary.rpt

set netFile "pnr_reports/_net_info.txt"
set netFd [open $netFile w]
set cellFile "pnr_reports/_cell_info.txt"
set cellFd [open $cellFile w]

getNetInfo $netFd
getCellInfo $cellFd

close $netFd
close $cellFd

exec gzip $cellFile $netFile &
