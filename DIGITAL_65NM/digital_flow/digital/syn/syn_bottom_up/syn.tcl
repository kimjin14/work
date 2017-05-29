variable design fpga_top
variable all_blocks {io mux2_inner lut4 fle mux37 clb}
variable all_mux {mux2 mux8 mux9 mux16 mux10 mux11 mux3 mux14 mux12 mux13 mux12 mux15}

#read in the design
read_file -format verilog {fpga_mux.v fpga_config.v fpga_top.v primitives.v define.vh fpga_modules.v}
current_design $design
write_file -format ddc -hierarchy -output "$design.ddc"

##############################################################################
# FIRST PASS 
##############################################################################
foreach block $all_blocks {
	current_design $block
	link
	source "cnstr/${block}.con"
	set_load 0.01 [all_outputs]
	set_drive 0.2 [all_inputs]
	compile
	set_dont_touch $block
}
foreach mux $all_mux {
	current_design $mux
	link
	source "cnstr/${mux}.con"
	set_load 0.01 [all_outputs]
	set_drive 0.2 [all_inputs]
	compile
	set_dont_touch $mux
}

current_design buffer_wire
insert_buffer in BUFFD3
set_dont_touch buffer_wire

current_design config_helper
compile
set_dont_touch config_helper

current_design $design
link

check_design -multiple_designs
write_file -format ddc -hierarchy -output "pass1/${design}_pass1.ddc"

change_names -hier -rule verilog
write_file -format verilog -hierarchy -output "pass1/${design}_pass1.v"

source ${design}.con
report_timing
report_area

exit
