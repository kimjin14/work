####################################
# FPGA Simulation
####################################
use File::Basename;

$fpga_top_file = "FPGA/fpga_top.v";
$fpga_primitives_file = "FPGA/primitives.v";
$fpga_modules_file = "FPGA/fpga_modules.v";
$fpga_mux_file = "FPGA/fpga_mux.v";
$fpga_top_tb_file = "FPGA/fpga_top_tb.v";
$define_file = "FPGA/define.v";
$bitstream_file = "FPGA/bitgen_report.txt";
$do_file = "wave.do";
$vsim_file = "vsim.do";

$start_op = 0;
for $i (0 .. $#ARGV) {
	if (@ARGV[$i] =~ s/-v//g) { $verilog_file = @ARGV[$i+1]; $start_op = 0; }
	elsif (@ARGV[$i] =~ s/-a//g) { $arch_file = @ARGV[$i+1]; $start_op = 0; } 
	elsif (@ARGV[$i] =~ s/-op//g || $start_op == 1) {
		push(@vtr_options, @ARGV[$i+1]);
		$start_op = 1;
	}
}

$verilog_name = basename("$verilog_file", ".v");
$blif_file = "$verilog_name.pre-vpr.blif";

print "---------------------------------------------------\n";
print "Design to be synthesized is $verilog_name.\n";
print "- verilog file: $verilog_file\n";
print "- architecture file: $arch_file\n";
if ($verilog_file eq "" || $arch_file eq "") {
	print "Usage: gen_arch -v design_verilog -a architecture -op VPR options.\n";
	exit;
}

##########################################################
###                     Run VTR                        ###
##########################################################
print "\tstarting vtr to prevpr...";
system ("perl ../vtr_flow/scripts/run_vtr_flow.pl $verilog_file $arch_file -ending_stage prevpr >vtr_out.txt");
if ($? cmp 0) {exit;}

open (OUTPUT, "vtr_out.txt");
while (<OUTPUT>) {
	if ($_ =~ m/failed|error/) {
		print " fail.\n";
		exit;
	}
}
print " successful.\n";
close(OUTPUT);

system ("cp temp/$blif_file .");

print "\tstarting vpr...";
system ("./vpr $arch_file temp/$blif_file @vtr_options > vpr_out.txt");
if ($? cmp 0) {exit;}

open (OUTPUT, "vpr_out.txt");
while (<OUTPUT>) {
	if ($_ =~ m/error|ERROR/) {
		print " fail.\n";
		exit;
	}
}
print " successful.\n";
close(OUTPUT);

##########################################################
###            Parse placed I/O from bitstream         ###
##########################################################
open(BITSTREAM, $bitstream_file);
$last = 0;
$#in_type = -1;
$#out_type = -1;

while (<BITSTREAM>) {
	chomp;

	# anything in quotation is being used
	if ($_ =~ /\"(.*?)\"/) {
		if ($_ =~ s/\[(.*?)\]/ /g) {
			s/\[/\\\[/g;
			s/\]/\\\]/g;
			@bitgen_line = split(/\s+/, $_);
			if ($_ =~/.clb./) {
				push(@clb_name, @bitgen_line[1]);
				push(@clb_path, "@{bitgen_line[2]}_@{bitgen_line[3]}_@{bitgen_line[4]}");
			} else {
				if (@bitgen_line[1] =~ m/out:/) {
					push(@out_name, "@{bitgen_line[1]}");
					push(@out_type, "@{bitgen_line[2]}");
					push(@out_x, "@{bitgen_line[3]}");
					push(@out_y, "@{bitgen_line[4]}");
					push(@out_z, "@{bitgen_line[5]}");
				} else {
					push(@in_name, "@{bitgen_line[1]}");
					push(@in_type, "@{bitgen_line[2]}");
					push(@in_x, "@{bitgen_line[3]}");
					push(@in_y, "@{bitgen_line[4]}");
					push(@in_z, "@{bitgen_line[5]}");
				}
			}
		}
	}	
	
	# find the line "bitstream" which gives you the config range
	# then the next line is the last line, which gives u the config bits
	if ($_ =~ s/bitstream \[/\[/g) {
		$config_range = $_;
		$last = 1;
	} elsif ($last == 1) {
		$config_bits = $_;
	}
}
close (BITSTREAM);
$config_vector = $config_range;
$config_range =~ s/\[|\:\w+\]//g;
$config_range = $config_range + 1;

##########################################################
### Edit fpga_top.v to contain the correct config bits ###
###    bitstream gen won't have correct config range   ###
##########################################################
open(FPGA_TOP, "$fpga_top_file");
$last = 0;
while (<FPGA_TOP>) {
	s/\t|,|\s//g;
	chomp;
	if ($last == 0 ) {
		if ($_ =~ s/input//g) {
			push (@reg_fpga, $_); 
		} elsif ($_ =~ s/output//g) {
			push (@wire_fpga, $_); 
		} elsif ($_ =~ s/inout//g) {
			push (@inout_fpga, $_);
		} elsif ($_ =~ /;/) {
			$last = 1;
		}
	}
}
close(FPGA_TOP);

##########################################################
###        define.v includes the config size          ###
##########################################################
open(DEFINE, ">$define_file");
print DEFINE "`define CONFIG_SIZE $config_range\n";
close(DEFINE);

##########################################################
###               Create testbench                     ###
##########################################################
open(FPGA_TB,">$fpga_top_tb_file");
print FPGA_TB "//testbench for $fpga_top_file\n";
print FPGA_TB "`timescale 1 ns / 1 ps\n\n";

open(CNS_TOP, "$verilog_file");

############################################
# determine top level module
# if the module appears only once, then it is the top
while (<CNS_TOP>) {
	if (s/\/\///g) {}
	elsif (s/\bmodule\b//g) {
		@line = split(/\s+/, $_);
		push (@module_cns, @line[1]);
	} elsif ($_ =~ s/`define//g) {
		@temp = split (/\s+|\n/, $_);
		push (@define_name_cns, @temp[1]);
		push (@define_val_cns, @temp[2]);
	} 
}
for $i (0 .. $#module_cns) {
	@count[$i] = 0;
}
seek(CNS_TOP, 0, 0);
while (<CNS_TOP>) {
	for $i (0 .. $#module_cns) {
		if ($_ =~ m/\b@module_cns[$i]\b/) {
			@count[$i] += 1;
		}
	}
}
for $i (0 .. $#module_cns) {
	if (@count[$i] == 1) {
		$cns_module = @module_cns[$i];
	}
}

############################################
# copy consumer
seek(CNS_TOP, 0, 0);
$last = 1;
while (<CNS_TOP>) {
	#print FPGA_TB;
	chomp;
	if ($last == 0 || m/$cns_module/) {
		$last = 0;
		if ($_ =~ s/input//g) {
			push (@wire_cns, $_); 
		} elsif ($_ =~ s/output//g) {
			push (@reg_cns, $_); 
		} elsif ($_ =~ s/inout//g) {
			push (@inout_cns, $_);
		} elsif ($_ =~ /endmodule/) {
			$last = 1;
		}
	}
}
close(CNS_TOP);
print FPGA_TB "\n";

print FPGA_TB "module fpga_top_tb ();\n\n";
print FPGA_TB "localparam N_INPUTS = 1000;\n";
print FPGA_TB "localparam SEED = 32'hBAADF00D;\n";
print FPGA_TB "localparam CONFIG_BITS = \n";
print FPGA_TB "\t\t$config_range\'b$config_bits;\n\n";
print FPGA_TB "localparam CONFIG_SIZE = $config_range;\n";

############################################
# set bitstream
print FPGA_TB "\treg ${config_vector}bitstream = CONFIG_BITS;\n";


############################################
# declare wire/regs used to connect from dut to cns comparator
for $i (0 .. $#in_type) {
	@in_name[$i] =~ s/\"|\"//g;
	@in_name[$i] =~ s/\^|\~/_/g;
	print FPGA_TB "\treg @{in_name[$i]};\n";
}
print FPGA_TB "\n";
for $i (0 .. $#out_type) {
	@out_name[$i] =~ s/\"out:|\"//g;
	@out_name[$i] =~ s/\^|\~/_/g;
	print FPGA_TB "\twire @{out_name[$i]};\n";
}
print FPGA_TB "\n";

############################################
# declare wires/regs used to connect to dut
for $i (0 .. $#reg_fpga) {
	print FPGA_TB "\treg \t@reg_fpga[$i];\n";
	@reg_fpga[$i] =~ s/\[\w+\:\w+\]//g;
}
for $i (0 .. $#wire_fpga) {
	print FPGA_TB "\twire \t@wire_fpga[$i];\n";
	@wire_fpga[$i] =~ s/\[\w+\:\w+\]//g;
}
for $i (0 .. $#inout_fpga) {
	print FPGA_TB "\treg \t@{inout_fpga[$i]}_reg;\n";
	print FPGA_TB "\twire \t@inout_fpga[$i];\n";
	@inout_fpga[$i] =~ s/\[\w+\:\w+\]//g;
}
print FPGA_TB "\n";

############################################
# instantiate device under testing
print FPGA_TB "\tfpga_top dut (\n";
for $i (0 .. $#reg_fpga) {
	print FPGA_TB "\t\t.@reg_fpga[$i](@reg_fpga[$i]),\n";
}
for $i (0 .. $#wire_fpga) {
	print FPGA_TB "\t\t.@wire_fpga[$i](@wire_fpga[$i]),\n";
}
for $i (0 .. $#inout_fpga) {
	if ($i == $#inout_fpga) { print FPGA_TB "\t\t.@inout_fpga[$i](@inout_fpga[$i])\n\t);\n\n"; }
	else { print FPGA_TB "\t\t.@inout_fpga[$i](@inout_fpga[$i]),\n"; }
}

############################################
# assign only the inputs values (to avoid unknown states)
# assign output to names that the consumer can understand
for $i (0 .. $#in_type) {
	print FPGA_TB "\tassign @{in_type[$i]}_@{in_x[$i]}_@{in_y[$i]}_wire[@{in_z[$i]}] = @{in_type[$i]}_@{in_x[$i]}_@{in_y[$i]}_wire_reg[@{in_z[$i]}];\n";
}
print FPGA_TB "\n";
for $i (0 .. $#out_type) {
	print FPGA_TB "\tassign @{out_name[$i]} = @{out_type[$i]}_@{out_x[$i]}_@{out_y[$i]}_wire[@{out_z[$i]}];\n";
}

############################################
# generate clk
print FPGA_TB "\talways begin\n";
print FPGA_TB "\t\t#0.5\n";
print FPGA_TB "\t\tfpga_clk = ~fpga_clk;\n";
print FPGA_TB "\t\t\/\/config_clk = ~config_clk;\n";
print FPGA_TB "\tend\n\n";

############################################
# producer, actually tests the circuit
print FPGA_TB "\treg [31:0] prod_rand = SEED;\n";
print FPGA_TB "\treg start_cns;\n";
print FPGA_TB "\treg [31:0] count_ovalid;\n";
print FPGA_TB "\treg ovalid;\n";
print FPGA_TB "\tinteger prod_n;\n\n";

print FPGA_TB "\tinitial begin\n";
print FPGA_TB "\t\tstart_cns = 0;\n";
print FPGA_TB "\t\tconfig_rst = 1;\n";
print FPGA_TB "\t\tfpga_clk = 0;\n";
print FPGA_TB "\t\tfpga_rst = 0;\n";
print FPGA_TB "\t\tconfig_clk = 0;\n";
print FPGA_TB "\t\tcount_ovalid = 32'd0;\n";
print FPGA_TB "\t\t#10;\n\n";

print FPGA_TB "\t\tconfig_rst = 0;\n";
#print FPGA_TB "\t\tconfig_mode = 1;\n";
$config_range = $config_range + 1;
#print FPGA_TB "\t\tfor (prod_n = 0; prod_n < $config_range; prod_n = prod_n + 1) begin\n";
#print FPGA_TB "\t\t\t@(negedge config_clk);\n";
#print FPGA_TB "\t\t\tconfig_in = bitstream[prod_n];\n";
#print FPGA_TB "\t\tend\n\n";
print FPGA_TB "\t\tfpga_rst = 1;\n";
print FPGA_TB "\t\tfor (prod_n = 0; prod_n < N_INPUTS; prod_n = prod_n + 1) begin\n";
print FPGA_TB "\t\t\t@(negedge fpga_clk);\n";
print FPGA_TB "\t\t\tstart_cns = 1; //start cns when this starts\n";
print FPGA_TB "\t\tcount_ovalid = count_ovalid+1;\n";
print FPGA_TB "\t\t\tif (count_ovalid > 10) begin\n";
print FPGA_TB "\t\t\t\tovalid = 1;\n";
print FPGA_TB "\t\t\tend\n";
for $i (0 .. $#in_type) {
	print FPGA_TB "\t\t\tprod_rand = \$random(prod_rand);\n";
	print FPGA_TB "\t\t\t//@in_name[$i]\n";	
	print FPGA_TB "\t\t\t@{in_type[$i]}_@{in_x[$i]}_@{in_y[$i]}_wire_reg[@{in_z[$i]}] = prod_rand;\n";	
}
print FPGA_TB "\t\tend\n\n";
print FPGA_TB "\tend\n\n";

############################################
# declare wires/regs used to connect to cns
for $i (0 .. $#reg_cns) {
	@reg_cns[$i] =~ s/\;//g;
	print FPGA_TB "\twire @reg_cns[$i];\n"; #attach this to the output of cns module
	print FPGA_TB "\treg @reg_cns[$i]_cns;\n"; #attach this to the cns output
	print FPGA_TB "\treg @reg_cns[$i]_prod;\n"; #attach this to the prod output
	if (@reg_cns[$i] =~ m/\[/) {
		@reg_cns[$i] =~ s/\s+//g;
		@temp = split(/\]|\;/, @reg_cns[$i]);
		@reg_size_cns[$i] = @temp[0];
		@reg_size_cns[$i] =~ s/\[|\:|0|\]|s+//g;
		for $j (0 .. $#define_name_cns) {
			if (@reg_size_cns[$i] =~ m/@define_name_cns[$j]/) {
				@reg_size_cns[$i] = @define_val_cns[$j]-1;
			}
		}
		@reg_cns[$i] = @temp[1];
	} else {
		@reg_cns[$i] =~ s/\s| wire | reg |;//g;
		@reg_size_cns[$i] = 0;
	}
}
print FPGA_TB "\n";
for $i (0 .. $#wire_cns) {
	print FPGA_TB "\twire @wire_cns[$i]\n";
	if (@wire_cns[$i] =~ m/\[/) {
		@wire_cns[$i] =~ s/\s+//g;
		@temp = split(/\]|\;/, @wire_cns[$i]);
		@wire_size_cns[$i] = @temp[0];
		@wire_size_cns[$i] =~ s/\[|\:|0|\]|s+//g;
		for $j (0 .. $#define_name_cns) {
			if (@wire_size_cns[$i] =~ m/@define_name_cns[$j]/) {
				@wire_size_cns[$i] = @define_val_cns[$j]-1;
			}
		}
		@wire_cns[$i] = @temp[1];
	} else {
		@wire_cns[$i] =~ s/\s| wire | reg |;//g;
		@wire_size_cns[$i] = 0;
	}
}
print FPGA_TB "\n";

############################################
# instantiate consumer
print FPGA_TB "\t$cns_module cns (\n";
for $i (0 .. $#wire_cns) {
	if (@wire_cns[$i] =~ m/clk|clock/) {
		print FPGA_TB "\t\t.@wire_cns[$i](fpga_clk),\n";
	} 
	#elsif (@wire_cns[$i] =~ m/rst|reset/) {
	#	print FPGA_TB "\t\t.@wire_cns[$i](config_reset),\n";
	#} 
	else {
		print FPGA_TB "\t\t.@wire_cns[$i](@wire_cns[$i]),\n";
	}

}
for $i (0 .. $#reg_cns) {
	if ($i == $#reg_cns) { print FPGA_TB "\t\t.@reg_cns[$i](@reg_cns[$i])\n\t);\n"; }
	else { print FPGA_TB "\t\t.@reg_cns[$i](@reg_cns[$i]),\n"; }
	
}
print FPGA_TB "\n";

############################################
# consumer, copies the producer
print FPGA_TB "\treg [31:0] cns_rand = SEED;\n";
print FPGA_TB "\treg fail = 1'b0;\n";
print FPGA_TB "\tinteger cns_n;\n\n";

$curr;

for $i (0 .. $#wire_cns) {
	for $j (0 .. $#in_name) {
		if ($wire_size_cns[$i]>1) {
			$curr = "top_$wire_cns[$i]_$wire_size_cns[$i]";
			if ($curr eq @in_name[$j]) {
				print FPGA_TB "\t\tassign @wire_cns[$i] = {top_$wire_cns[$i]_$wire_size_cns[$i]";
				for $j (reverse 0 .. $wire_size_cns[$i]-1) {
					print FPGA_TB ", top_$wire_cns[$i]_$j";
				}
				print FPGA_TB "};\n";
			}
		} else {
			$curr = "top_$wire_cns[$i]";
			if ($curr eq @in_name[$j]) {
				if (@wire_cns[$i] =~ m/clk|clock/) {
					print FPGA_TB "\t\tassign @wire_cns[$i] = fpga_clk;\n";
				} else {
					print FPGA_TB "\t\tassign @wire_cns[$i] = top_$wire_cns[$i];\n";
				}
			}
		}
	}
}

print FPGA_TB "\n";

print FPGA_TB "\tinitial begin\n";

for $i (0 .. $#in_name) {
	print FPGA_TB "\t\t@{in_name[$i]} = 1'b1;\n";	
}

print FPGA_TB "\t\tfor (cns_n = 0; cns_n < N_INPUTS; cns_n = cns_n + 1) begin\n";
print FPGA_TB "\t\t\t@(negedge fpga_clk);\n";
print FPGA_TB "\t\t\twhile (!start_cns) begin\n";
print FPGA_TB "\t\t\t\t@(negedge fpga_clk);\n";
print FPGA_TB "\t\t\tend\n";

print FPGA_TB "\t\t\t\$display(\"cycle %d\", cns_n);\n";

for $i (0 .. $#in_name) {
	print FPGA_TB "\t\t\tcns_rand = \$random(cns_rand);\n";
	print FPGA_TB "\t\t\t@{in_name[$i]} = cns_rand;\n";	
}
print FPGA_TB "\n";

for $i (0 .. $#reg_cns) {
	print FPGA_TB "\t\t\t@reg_cns[$i]_cns = @reg_cns[$i];\n";
	for $j (0 .. $#out_name) {
		if ($reg_size_cns[$i]>1) {
			$curr = "top_$reg_cns[$i]_$reg_size_cns[$i]";
			if ($curr eq @out_name[$j]) {
				print FPGA_TB "\t\t\t@reg_cns[$i]_prod = {top_$reg_cns[$i]_$reg_size_cns[$i]";
				for $j (reverse 0 .. $reg_size_cns[$i]-1) {
					print FPGA_TB ", top_$reg_cns[$i]_$j";
				}
				print FPGA_TB "};\n";
				print FPGA_TB "\n";

				print FPGA_TB "\t\t\tif (ovalid == 1'b1) begin\n";
				print FPGA_TB "\t\t\tif (@reg_cns[$i]_cns != @reg_cns[$i]_prod) begin\n";
				print FPGA_TB "\t\t\t\t\$display(\"FAIL: Expected %d, Got %d\", @reg_cns[$i]_cns, @reg_cns[$i]_prod);\n";
				print FPGA_TB "\t\t\t\tfail = 1'b1;\n";
				print FPGA_TB "\t\t\tend\n";
				print FPGA_TB "\t\t\telse begin\n";
				print FPGA_TB "\t\t\t\t\$display(\"SUCCESS: Expected %d, Got %d\", @reg_cns[$i]_cns, @reg_cns[$i]_prod);\n";
				print FPGA_TB "\t\t\tend\n";
				print FPGA_TB "\t\t\tend\n";
				print FPGA_TB "\n";
			}
		} else {
			$curr = "top_$reg_cns[$i]";
			if ($curr eq @out_name[$j]) {
				print FPGA_TB "\t\t\t@reg_cns[$i]_prod = top_$reg_cns[$i];\n";
				print FPGA_TB "\n";

				print FPGA_TB "\t\t\tif (ovalid == 1'b1) begin\n";
				print FPGA_TB "\t\t\tif (@reg_cns[$i]_cns != @reg_cns[$i]_prod) begin\n";
				print FPGA_TB "\t\t\t\t\$display(\"FAIL: Expected %d, Got %d\", @reg_cns[$i]_cns, @reg_cns[$i]_prod);\n";
				print FPGA_TB "\t\t\t\tfail = 1'b1;\n";
				print FPGA_TB "\t\t\tend\n";
				print FPGA_TB "\t\t\telse begin\n";
				print FPGA_TB "\t\t\t\t\$display(\"SUCCESS: Expected %d, Got %d\", @reg_cns[$i]_cns, @reg_cns[$i]_prod);\n";
				print FPGA_TB "\t\t\tend\n";
				print FPGA_TB "\t\t\tend\n";
				print FPGA_TB "\n";
			}
		}
	}
}

print FPGA_TB "\t\tend\n";

print FPGA_TB "\t\t\$display(\"%s\", fail? \"SOME TESTS FAILED\" : \"ALL TESTS PASSED\");\n";
print FPGA_TB "\t\t\$stop(0);\n";
print FPGA_TB "\tend\n\n";

print FPGA_TB "endmodule\n\n";

close (FPGA_TB);

#########################################
### Create wave.do for easy debugging ###
#########################################
open (VSIM, ">$vsim_file");
print VSIM "vlib work\n";
print VSIM "vlog -work work $fpga_top_file $fpga_modules_file $fpga_mux_file $fpga_top_tb_file $fpga_primitives_file $verilog_file\n";
print VSIM "vsim -L work -novopt fpga_top_tb\n";
#print VSIM "do wave.do\n";
@config_bits = split('', $config_bits);
	
#print VSIM "force {/fpga_top_tb/dut/config_mode} 1\n";
#for $i (0 .. $#config_bits) {
#	print VSIM "force {/fpga_top_tb/dut/config_chain[$i]} @config_bits[$i]\n";
#}
#print VSIM "run 10 ns\n";
#print VSIM "force {/fpga_top_tb/dut/config_mode} 0\n";
print VSIM "run -all\n";
close(VSIM);

open (FPGA_WAVE, ">$do_file");
print FPGA_WAVE "onerror {resume}\n";
print FPGA_WAVE "quietly WaveActivateNextPane {} 0\n";
	print FPGA_WAVE "add wave -noupdate -format Logic -label fail {/fpga_top_tb/fail}\n";
for $i (0 .. $#in_name) {
	print FPGA_WAVE "add wave -noupdate -format Logic -label @in_name[$i] {/fpga_top_tb/dut/@{in_type[$i]}_@{in_x[$i]}_@{in_y[$i]}/inpad[@{in_z[$i]}]}\n";
}
for $i (0 .. $#out_name) {
	print FPGA_WAVE "add wave -noupdate -format Logic -label @out_name[$i] {/fpga_top_tb/dut/@{out_type[$i]}_@{out_x[$i]}_@{out_y[$i]}/outpad[@{out_z[$i]}]}\n";
}
for $i (0 .. $#clb_name) {
	print FPGA_WAVE "add wave -noupdate -format Literal -group @clb_name[$i] /fpga_top_tb/dut/@clb_path[$i]/*\n";
}
#@config_bits = split('', $config_bits);
#for $i (0 .. $#config_bits) {
#	print FPGA_WAVE "force {/fpga_top_tb/dut/config_chain[$i]} @config_bits[$i]\n";
#}
print FPGA_WAVE "add wave -noupdate -format Literal -group consumer /fpga_top_tb/cns/*\n";
close(FPGA_WAVE);


######################
### Run simulation ###
######################

print "\tstarting modelsim...";
system ("vsim -c -do vsim.do </dev/null >vsim_out.txt");

open (OUTPUT, "vsim_out.txt");
while (<OUTPUT>) {
	if ($_ =~ m/error|Error/) {
		print " error.\n";
		exit;
	} elsif ($_ =~ m/ALL TESTS PASSED/) {
		print " successful.\n";
		print "\n";		
		exit;
	} elsif ($_ =~ m/FAIL/) {
		print " unsuccessful.\n";
		exit;
	} elsif ($_ =~ m/Expected x/) {
		print " unsuccessful.\n";
		exit;
	} elsif ($_ =~ m/Got x|Got z/) {
		print " unsuccessful.\n";
		exit;
	}
}
print " simulation incomplete.\n";
close(OUTPUT);

print "\n";
		
exit;

