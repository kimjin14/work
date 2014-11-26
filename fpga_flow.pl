########################################################################
#
# FPGA Design Flow
#
# 1. Generate architecture and verify functionality using VTR
# 2. Synthesize, place and route, and simulate using DIGITAL_65NM
#
########################################################################
use File::Spec;
use File::Basename;
use Cwd;

########################### Parse Options ##############################
$vtr_flag = 1;
$digital_flag = 1;

$fpga_syn_file = "fpga_syn_bottom_up_timin2.tcl";

for ($i = 0; $i <= $#ARGV; $i++) {
	print $_;
	if ($ARGV[$i] =~ s/-v\s*//g) { $i++; $design_verilog_file = $ARGV[$i]; }
	elsif ($ARGV[$i] =~ s/-a\s*//g) { $i++; $arch_file = $ARGV[$i];} 
	elsif ($ARGV[$i] =~ s/-sdc\s*//g) { $i++; $fpga_syn_file = $ARGV[$i];} 
	elsif ($ARGV[$i] =~ s/-op\s*//g) { 
		$i++; $vtr_options = $ARGV[$i];
		while ($ARGV[$i+1] =~ /^[a-zA-Z0-9_.\/]|--/) { #no '-', keep going
			$i++;
			$vtr_options = "$vtr_options $ARGV[$i]";
		}
	} #elsif ($ARGV[$i] =~ s/-c\s*//g) { $i++; $cnstr_file = $ARGV[$i]; }
	elsif ($ARGV[$i] =~ s/-novtr\s*//g) { $i++; $design_name = $ARGV[$i]; $vtr_flag = 0; }
	elsif ($ARGV[$i] =~ s/-nodigital\s*//g) { $digital_flag = 0; }
	elsif ($ARGV[$i] =~ s/-tag\s*//g) { $i++; $study_name = $ARGV[$i]; }
	elsif ($ARGV[$i] =~ s/-help\s*//g) { 
		print "Usage: ./fpga_flow.pl -v <verilog_file> -a <arch_file>\n";
		print "\t-op: vpr options\n";
		print "\t-sdc: sdc file\n";
		print "\t-novtr <design_name>: no vtr, must provide the design name\n";
		print "\t-nodigital: no digital flow\n";
		print "\t-tag <study_name>: helps you tag diff studies of same design\n";
		print "\t-help: shows the list of options\n";
		exit;
	} else { print "$ARGV[$i] is not a valid input.\n" }
}

if ($design_verilog_file eq "") { print "no verilog file specified\n"; exit; }
if ($arch_file eq "") { print "no architecture file specified\n"; exit; }
if ( $study_name eq "") { print "tag not specified\n"; exit; }
#if ($vtr_options eq "") { exit; } NOT REQ
#if ($cnstr_file eq "") { exit; } NOT REQ

if ($vtr_flag) { $design_name = basename("$design_verilog_file", ".v"); }
$fpga_name = "fpga_top";

$design_verilog_file = File::Spec->rel2abs( $design_verilog_file );
$arch_file = File::Spec->rel2abs( $arch_file );
$cnstr_file = File::Spec->rel2abs( $cnstr_file );
$fpga_syn_file = File::Spec->rel2abs( $fpga_syn_file );
$fpga_verilog_file = "fpga_top.v,fpga_modules.v,fpga_mux.v,primitives.v,define.vh";
$fpga_other_file = "fpga_top_tb.v,bitgen_report.txt,vsim.do,wave.do,vpr_out.txt,vsim_out.txt,fpga_top.sdc";

$vtr_path = File::Spec->rel2abs( "VTR/vpr" );
$digital_flow_path = File::Spec->rel2abs( "DIGITAL_65NM/digital_flow" );
$starting_path = getcwd;

$i = 0;
# since there are many designs with the same name, store all the things separately!
$result_path = "$starting_path/design/${design_name}_${study_name}";
while (-d "$result_path") {
	if ($i == 0) { $study_name = "${study_name}_"; }
	$study_name =~ s/_\w*/_$i/g;
	$result_path = "$starting_path/design/${design_name}_${study_name}";
	$i++;
} system ("mkdir $result_path");
print "\nAll the results will be stored in $result_path.\n\n";

######################### Run Generate Arch ############################
if ($vtr_flag) {
	if (!(-d "$result_path/vtr")) { system ("mkdir $result_path/vtr"); }
	print "\nStarting architecture generation and verification.\n";

	# change directory to vpr and run perl script
	if (!(chdir $vtr_path)) { print "Director does not exist.\n"; exit; }
	system ("perl gen_arch.pl -v $design_verilog_file -a $arch_file -op $vtr_options");
	chdir ( $starting_path );

	# change back directory and copy the verilog file here
	system ("cp $vtr_path/{$fpga_verilog_file,$fpga_other_file} $result_path/vtr");
} else {"\nArchitecture generation skipped, design will be $design_name.\n"; }

############################ Digital Flow ##############################
if ($digital_flag) {
	if (!(-d "$result_path/digital")) { system ("mkdir $result_path/digital"); }
	print "\nStarting digital flow.\n";

	# file names need spaces rather than commas
	$fpga_verilog_file =~ s/,/ $result_path\/vtr\//g;

	# create the compile options

	# change directory to digital_flow and run perl script
	if (!(chdir $digital_flow_path)) { print "Director does not exist.\n"; exit; }
	system ("perl digital_flow.pl -v $result_path/vtr/$fpga_verilog_file -c $cnstr_file -d ${design_name}_${study_name} -tcl $fpga_syn_file -nosim -nopower -notiming\n");
	chdir ( $starting_path );

	# change back directory and copy the log here
	system ("mv $digital_flow_path/${design_name}_${study_name} $result_path/digital");

	print "\nSuccessful!\n";
} else {"\nDigital flow skipped.\n"; }

