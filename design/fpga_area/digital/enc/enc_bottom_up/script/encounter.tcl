variable design fpga_top
variable verilog fpga_top.v
variable w 202.6

set design
set verilog

#initialize
loadConfig encounter.conf
setMultiCpuUsage -localCpu 2 -cpuPerRemoteHost 1 -remoteHost 0 -keepLicense true

#floor plan 75% core utilization and h/w ratio of 1
floorPlan -site core -r 1 0.85 20 20 20 20
source script/floorplan.txt
saveDesign "${design}_floorplan.enc"

#power ring
addRing -spacing_bottom 5 -width_left 2 -width_bottom 2 -width_top 2 -spacing_top 5 -layer_bottom M1 -center 1 -stacked_via_top_layer AP -width_right 2 -around core -jog_distance 0.1 -offset_bottom 0.1 -layer_top M1 -threshold 0.1 -offset_left 0.1 -spacing_right 5 -spacing_left 5 -offset_right 0.1 -offset_top 0.1 -layer_right M2 -nets {VSS VDD } -stacked_via_bottom_layer M1 -layer_left M2
saveDesign "${design}_power_ring.enc"

#place standard cells
setPlaceMode -fp false
placeDesign -inPlaceOpt -noPrePlaceOpt
saveDesign "${design}_placed.enc"

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
setNanoRouteMode -quiet -drouteStartIteration default
setNanoRouteMode -quiet -routeTopRoutingLayer default
setNanoRouteMode -quiet -routeBottomRoutingLayer default
setNanoRouteMode -quiet -drouteEndIteration default
setNanoRouteMode -quiet -routeWithTimingDriven false
setNanoRouteMode -quiet -routeWithSiDriven false
routeDesign -globalDetail
saveDesign "${design}_routed.enc"

#check design
verifyGeometry -reportfile geometry.rpt
verifyConnectivity -type all -error 1000 -warning 50

#report area
summaryReport -noHtml -outFile report.txt

#save design
saveNetlist "${design}_golden.v"
saveDesign "${design}.enc"
extractRC -outfile fpga_top.cap
rcOut -spef "${design}.spef"

exit

