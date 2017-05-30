variable design fpga_top

set design

set sh_enable_page_mode true

######################################################
# Set search_path and link_path
######################################################

set search_path ". ./src /CMC/tools/synopsys/syn_vA-2007.12-SP5/libraries/syn /CMC/tools/synopsys/syn_vA-2007.12-SP5/dw/syn_ver /CMC/tools/synopsys/syn_vA-2007.12-SP5/dw/sim_ver /CMC/kits/tsmc_65nm_libs/tcbn65gplus/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tcbn65gplus_140b /CMC/kits/tsmc_65nm_libs/tpzn65gpgv2/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tpzn65gpgv2_140c"

set link_path "* tcbn65gpluswc.db tpzn65gpgv2wc.db"

######################################################
# Read and link a Design
######################################################

read_verilog "${design}_golden.v"
link_design "$design"

source "src/${design}.sdc"
set_false_path -from config_reset
set_max_delay -from io* -to io* 5
create_clock -name fpga_clk -period 2 fpga_clk

read_parasitics -increment "src/${design}.spef"
set_message_info -id RC-009 -limit 4000
report_constraint
report_timing -max_paths 3

######################################################
# Exiting PrimeTime
######################################################
quit
