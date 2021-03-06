variable design
variable spef

set design
set spef

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

source "src/${design}_default.sdc"

read_parasitics -increment "$spef"

report_constraint
report_constraint -all_violators
report_timing

######################################################
# Exiting PrimeTime
######################################################

quit
