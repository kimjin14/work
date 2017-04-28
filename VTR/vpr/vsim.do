vlib work
vlog -work work FPGA/fpga_top.v FPGA/fpga_modules.v FPGA/fpga_mux.v FPGA/fpga_top_tb.v FPGA/primitives.v benchmarks/fsm.v
vsim -L work -novopt fpga_top_tb
run -all
