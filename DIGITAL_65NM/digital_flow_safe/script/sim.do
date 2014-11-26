variable design
variable lib
variable sdf

set design
set lib
set sdf

vlib work
vlog -work work "${design}_tb.v"
vlog -work work "src/${design}_golden.v"
vsim -L work -L "$lib" -sdfmax "${design}_tb/dut=$sdf" "${design}_tb"
vcd file dump.vcd
vcd add -r "${design}_tb/*"
run -all

quit
