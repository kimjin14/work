#!/bin/bash

seed_val=( 1 2 3 4 5 )
arch_files=( simple_arch depopulated_xbar_arch depopulated_xbar_frac_arch depopulated_xbar_frac_fc_arch depopulated_xbar_frac_io_arch depopulated_xbar_frac_subset_arch )
#verilog_files=( fsm bigkey elliptic s38417 addshift16 ch_intrinsics ex1010 misex3 alu4 clma ex5p multaccum32 seq_mcnc apex2 des pdc spla apex4 diffeq frisc s298 tseng )
verilog_files=( multaccum32 )


for verilog in "${verilog_files[@]}"
do
	for arch in "${arch_files[@]}"
	do
		for seed in "${seed_val[@]}"
		do
			success_count=$(perl testbench_gen.pl benchmarks/$verilog.v arch/$arch.xml $seed | grep -Po 'success')
			
			mkdir -p design/$verilog/$arch/$seed

			mv $verilog.pre-vpr.blif design/$verilog/$arch/$seed
			mv fpga_top.v design/$verilog/$arch/$seed
			mv fpga_mux.v design/$verilog/$arch/$seed
			mv fpga_modules.v design/$verilog/$arch/$seed
			mv fpga_top_tb.v design/$verilog/$arch/$seed
			mv vpr_out.txt design/$verilog/$arch/$seed
			mv vsim_out.txt design/$verilog/$arch/$seed
			
			echo -e $arch '\t' $verilog '\t' $seed '\t' $success_count >> verilog_verification.txt
		done
	done
done
