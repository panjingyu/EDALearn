globalNetConnect VSS -type pgpin -pin VSS -inst * 
globalNetConnect VDD -type pgpin -pin VDD -inst * 
globalNetConnect VSS -type tielo -inst * 
globalNetConnect VDD -type tiehi -inst * 


setAddStripeMode -use_exact_spacing 1 -extend_to_closest_target area_boundary -extend_to_first_ring 1


addStripe -nets VDD -layer M4 -direction vertical -width 1.8 -spacing 1.8 -set_to_set_distance 100 -start_from left -start_offset 2 -switch_layer_over_obs false -max_same_layer_jog_length 2 -padcore_ring_top_layer_limit M6 -padcore_ring_bottom_layer_limit M1 -block_ring_top_layer_limit M6 -block_ring_bottom_layer_limit M1 -use_wire_group 0 -snap_wire_center_to_grid None -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape }

addStripe -nets VSS -layer M4 -direction vertical -width 1.8 -spacing 1.8 -set_to_set_distance 100 -start_from right -start_offset 2 -switch_layer_over_obs false -max_same_layer_jog_length 2 -padcore_ring_top_layer_limit M6 -padcore_ring_bottom_layer_limit M1 -block_ring_top_layer_limit M6 -block_ring_bottom_layer_limit M1 -use_wire_group 0 -snap_wire_center_to_grid None -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape }


sroute -connect { corePin } -layerChangeRange { M1 M4 } -blockPinTarget { nearestTarget } -corePinTarget { firstAfterRowEnd } -allowJogging 1 -crossoverViaLayerRange { M1 M4 } -nets { VDD VSS} -allowLayerChange 1 -targetViaLayerRange { M1 M4 }

