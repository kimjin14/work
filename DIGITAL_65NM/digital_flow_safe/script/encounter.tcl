variable design
variable verilog

set design
set verilog

#initialize
loadConfig

#floor plan 85% core utilization and h/w ratio of 1
floorPlan -site core -r 1 0.85 5 5 5 5
fit

#power ring
addRing -spacing_bottom 1 -width_left 1 -width_bottom 1 -width_top 1 -spacing_top 1 -layer_bottom M1 -center 1 -stacked_via_top_layer AP -width_right 1 -around core -jog_distance 0.1 -offset_bottom 0.1 -layer_top M1 -threshold 0.1 -offset_left 0.1 -spacing_right 1 -spacing_left 1 -offset_right 0.1 -offset_top 0.1 -layer_right M2 -nets {VSS VDD } -stacked_via_bottom_layer M1 -layer_left M2

#place standard cells
setPlaceMode -fp false
placeDesign -prePlaceOpt
checkPlace "$design.checkPlace"

#connect VDD and VSS to all pins and tie it high/low
clearGlobalNets
globalNetConnect VSS -type pgpin -pin VSS -inst {}
globalNetConnect VDD -type pgpin -pin VDD -inst {}
globalNetConnect VSS -type net -net VSS
globalNetConnect VDD -type net -net VDD
globalNetConnect VDD -type pgpin -pin VDD -inst *
globalNetConnect VSS -type pgpin -pin VSS -inst *
globalNetConnect VDD -type tiehi -inst *
globalNetConnect VSS -type tielo -inst *

#route VDD and VSS first
sroute -connect { blockPin padPin padRing corePin floatingStripe } -layerChangeRange { M1 AP } -blockPinTarget { nearestRingStripe nearestTarget } -padPinPortConnect { allPort oneGeom } -checkAlignedSecondaryPin 1 -blockPin useLef -allowJogging 1 -crossoverViaBottomLayer M1 -allowLayerChange 1 -targetViaTopLayer AP -crossoverViaTopLayer AP -targetViaBottomLayer M1 -nets { VSS VDD }

#route everything
setNanoRouteMode -quiet -routeWithTimingDriven 1
setNanoRouteMode -quiet -routeTdrEffort 10
setNanoRouteMode -quiet -drouteStartIteration default
setNanoRouteMode -quiet -routeTopRoutingLayer default
setNanoRouteMode -quiet -routeBottomRoutingLayer default
setNanoRouteMode -quiet -drouteEndIteration default
setNanoRouteMode -quiet -routeWithTimingDriven true
setNanoRouteMode -quiet -routeWithSiDriven false
routeDesign -globalDetail

#check design
verifyGeometry
verifyConnectivity -type all -error 1000 -warning 50

#report area
summaryReport -noHtml -outFile report.txt


#save design
saveNetlist "${design}_golden.v"
saveDesign "${design}.enc"
streamOut "${design}.gds" -mapFile streamOut.map -libName DesignLib -outputMacros -units 1000 -mode ALL
rcOut -spef "${design}.spef"
write_sdf -ideal_clock_network "${design}.sdf"

exit

