timeDesign -prePlace

createBasicPathGroups

setMaxRouteLayer 6
set_interactive_constraint_modes common
create_clock -name clk  -period 200 -waveform {0 100} [get_ports clk]
report_clocks
setOptMode -usefulSkew false \
    -allEndPoints true \
    -fixHoldAllowSetupTnsDegrade false 

# placement pre-clock cts goes here...

