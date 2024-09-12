# CTS

setNanoRouteMode -drouteMinimizeLithoEffectOnLayer {f t t t t t t t t t} \
    -routeTopRoutingLayer 5 -routeBottomRoutingLayer 2 \
    -routeWithViaInPin true 

# set desired clock cells here...

set_ccopt_property target_skew 5ps 
set_ccopt_property target_max_trans 30ps
setNanoRouteMode -routeTopRoutingLayer 5 -routeBottomRoutingLayer 2
create_route_type -name ccopt_route_group -bottom_preferred_layer 4 -top_preferred_layer 5
create_ccopt_clock_tree_spec
ccopt_design -cts

# report on clocks and check results
