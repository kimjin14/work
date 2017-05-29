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
	set_max_area 0
	set_load 0.05 [all_outputs]
	compile
	set_dont_touch $block
}
foreach mux $all_mux {
	current_design $mux
	link
	set_max_area 0
	set_load 0.05 [all_outputs]
	compile
	set_dont_touch $mux
}

current_design buffer_wire
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
report_timing > pass1/timing.rpt
report_area > pass1/area.rpt

write_sdc "./${design}_default.sdc"
write_sdf "./${design}_default.sdf"

exit

##############################################################################
# COPY CONSTRAINTS
##############################################################################
source ${design}.con
characterize {clb* io*}

foreach block $all_blocks {
	current_design $block
	write_script > "pass2/${block}.wcon"
}

foreach mux $all_mux {
	current_design $mux
	write_script > "pass2/${mux}.wcon"
}

foreach mux $all_mux {
	current_design ${mux}_long
	write_script > "pass2/${mux}_long.wcon"
}

remove_design -all

##############################################################################
# SECOND PASS 
##############################################################################
read_file -format ddc "pass1/${design}_pass1.ddc"
foreach block $all_blocks {
	current_design $block
	link
	source "pass2/${block}.wcon"
	compile -map_effort high
	set_dont_touch $block
}

foreach mux $all_mux {
	current_design $mux
	link
	source "pass2/${mux}.wcon"
	compile -map_effort high
	set_dont_touch $mux
}

foreach mux $all_mux {
	current_design ${mux}_long
	link
	source "pass2/${mux}_long.wcon"
	compile -map_effort high
	set_dont_touch ${mux}_long
}
current_design $design
link

check_design -multiple_designs
write_file -format ddc -hierarchy -output "pass2/${design}_pass2.ddc"

change_names -hier -rule verilog
write_file -format verilog -hierarchy -output "pass1/${design}_pass1.v"
write_sdc "./${design}_default.sdc"
write_sdf "./${design}_default.sdf"

exit
