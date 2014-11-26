variable design

set design

get_design_lib_path WORK

analyze -format verilog -lib WORK {"$verilog"}
elaborate "$design" -arch "verilog" -lib WORK -update
check_design -multiple_designs

set compile_seqmap_identify_shift_registers true
set compile_sequential_area_recovery true
write_file -format ddc -hierarchy -output "./$design.ddc"

remove_design -all

read_file -format ddc "./$design.ddc"
current_design .
source constraint.sdc
write_file -format ddc -hierarchy -output "./${design}_constrained.ddc"

remove_design -all

read_file -format ddc "./${design}_constrained.ddc"
current_design .
COMPILE OPTIONS
compile_ultra
write -format verilog -hierarchy -output "./${design}_test.v"
write_file -format ddc -hierarchy -output "./${design}_compiled.ddc"

remove_design -all

read_file -format ddc "./${design}_compiled.ddc"
compile -map_effort high -area_effort high -power_effort high
compile -incremental_map 
write -format ddc -hierarchy -output "./${design}_compiled_final.ddc"

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
