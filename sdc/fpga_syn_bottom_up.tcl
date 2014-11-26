variable design fpga_top fpga_top

get_design_lib_path WORK

# load design
analyze -format verilog -lib WORK {fpga_mux.v fpga_top.v primitives.v define.vh fpga_modules.v}
elaborate "$design" -arch "verilog" -lib WORK
check_design -multiple_designs
write_file -format ddc -hierarchy -output "./$design.ddc"

current_design fpga_top
link
current_design mux2
	
	
	compile -map_effort high -ungroup
	set_dont_touch mux2
	
#current_design ff
#	set_max_delay -from clk* -to Q 0.05
#	
	
#	compile -map_effort high -ungroup
#	set_dont_touch ff
	
current_design fle
	set_false_path -from config*
	
	ungroup {fracture_lut_in_4 fracture_lut_in_5 lut4_0 lut4_1 lut4_2 lut4_3 lut5_0_0 lut5_0_1 lut6 fracture_lut lut5_1}
	
	compile -map_effort high
	set_dont_touch fle

current_design mux37
	
	
	compile -map_effort high -ungroup
	set_dont_touch mux37

current_design clb
	set_false_path -from config_reset
	set_disable_timing fle_*/mux_bypass_*/in[0]
	
	#ungroup {mux_0 mux_6 mux_12 mux_18 mux_24 mux_30 mux_36 mux_42}
	#ungroup {mux_115 mux_121 mux_127 mux_133 mux_139 mux_145 mux_151 mux_157}
	#ungroup {mux_230 mux_236 mux_242 mux_248 mux_254 mux_260 mux_266 mux_272}
	#ungroup {mux_345 mux_351 mux_357 mux_363 mux_369 mux_375 mux_381 mux_387}
	#ungroup {mux_460 mux_466 mux_472 mux_478 mux_484 mux_490 mux_496 mux_502}
	#ungroup {mux_575 mux_581 mux_587 mux_593 mux_599 mux_605 mux_611 mux_617}
	#ungroup {mux_690 mux_696 mux_702 mux_708 mux_714 mux_720 mux_726 mux_732}
	#ungroup {mux_805 mux_811 mux_817 mux_823 mux_829 mux_835 mux_841 mux_847}
	#ungroup {mux_920 mux_926 mux_932 mux_938 mux_944 mux_950 mux_956 mux_962}
	#ungroup {mux_1035 mux_1041 mux_1047 mux_1053 mux_1059 mux_1065 mux_1071 mux_1077}

	compile -map_effort high
	set_dont_touch clb

current_design mux16
	
	
	compile -map_effort high -ungroup
	set_dont_touch mux16
	
current_design mux10
	
	
	compile -map_effort high -ungroup
	set_dont_touch mux10

current_design mux11
	
	
	compile -map_effort high -ungroup
	set_dont_touch mux11

#current_design mux6
#	set_max_delay -from in* -to out 0.1
#	
	
#	compile -map_effort high -ungroup
#	set_dont_touch mux6

#current_design mux4
#	set_max_delay -from in* -to out 0.1
#	
	
#	compile -map_effort high -ungroup
#	set_dont_touch mux4

current_design mux3
	
	
	compile -map_effort high -ungroup
	set_dont_touch mux3
	
current_design mux14
	
	
	compile -map_effort high -ungroup
	set_dont_touch mux14
	
current_design mux13
	
	
	compile -map_effort high -ungroup
	set_dont_touch mux13
	
current_design mux12
	
	
	compile -map_effort high -ungroup
	set_dont_touch mux12
	
current_design mux15
	
	
	compile -map_effort high -ungroup
	set_dont_touch mux15

current_design fpga_top
	#set_dont_touch_network fpga_clk
	set_false_path -from config_reset
	set_disable_timing clb*/fle_*/mux_bypass_*/in[0]
	set_disable_timing mux*/in*

report_timing -loop
write_file -format ddc -hierarchy -output "./${design}_constrained.ddc"
	
compile
write_file -format ddc -hierarchy -output "./${design}_compiled.ddc"

#remove_design -all

# compile design with incremental mapping
#read_file -format ddc "./${design}_compiled.ddc"
#current_design fpga_top
#compile -map_effort high -incremental_map 
#write -format ddc -hierarchy -output "./${design}_compiled_final.ddc"

report_area
report_constraints
report_timing -path full -delay max -max_paths 1 -nworst 1
check_design
change_names -hier -rule verilog
write -format verilog -hierarchy -output "./${design}_compiled.v"
write_sdc "./${design}_default.sdc"
write_sdf "./${design}_default.sdf"
remove_design -all

quit
