# optimize design as desired

setNanoRouteMode -drouteMinimizeLithoEffectOnLayer {t t t t t t t t t t} 

# -routeWithViaInPin true -- so it does not extend the M1 pins in cells

setNanoRouteMode -routeWithViaInPin true \
    -routeDesignFixClockNets true \
    -routeTopRoutingLayer 6

# route and optimize as desired
