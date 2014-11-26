####################################
# Verilog TB Generator
# 	input: verilog file
####################################
use File::Basename;

$clk_flag = 0;
$rst_flag = 0;
$cnst_flag = 0;

$test_cycle = 1000;
$seed = BAADF00D;

for ($i = 0; $i <= $#ARGV; $i++) {

    if ($ARGV[$i] eq '-v') {
    	$temp = basename("$ARGV[$i+1]", ".v");
		@src = split (/\.|\_golden/, $temp);
		$src_name = $ARGV[$i+1];
   		$design_name = $src[0];
	} elsif ($ARGV[$i] eq '-clk') {
    	$clk_flag = 1;
    	$clk_name = $ARGV[$i+1];
    	$clk_period = $ARGV[$i+2];
    } elsif ($ARGV[$i] eq '-r') {
    	$rst_flag = 1;
    	$rst_name = $ARGV[$i+1];
    	$rst_hold = $ARGV[$i+2];
    	$rst_hl = $ARGV[$i+3];
    } elsif ($ARGV[$i] eq '-const') {
    	$cnst_flag = 1;
    	while ($i <= $#ARGV) {
    		$temp = substr($ARGV[$i+1], 0, 1);
    		if ($temp eq '-') { last; }
    		push (@cnst_name, $ARGV[$i+1]);
			push (@cnst_value, "$ARGV[$i+1] = $ARGV[$i+2]");
			$i++; $i++;
		}
    } elsif ($ARGV[$i] eq '-l') {
    	$test_cycle = $ARGV[$i+1];
    } elsif ($ARGV[$i] eq '-tglr') {
    	$switch_rate = $ARGV[$i+1];
    }
}

#### Open files, set up the signals ####

open(SRC,"$src_name");

$src_name = $design_name;

open(TB,">$src_name\_tb.v");
print TB "//testbench for $src_name.v\n";
print TB "`timescale 1 ns / 1 ps\n\n";
print TB "module $src_name\_tb ();\n\n";

print TB "localparam N_INPUTS = $test_cycle;\n";
print TB "localparam SEED = 32'h$seed;\n\n";

$found_design = 0;
while (<SRC>) {
	if ($_ =~ /$design_name/) {
		$found_design = 1;
	}
	if ($found_design == 1) {
		if ($_ =~ /input/) {
			$_ =~ s/\s*input/\treg/g;
			print TB;
			chomp;
			@temp = split (/\s+|;/);
			if ($temp[2] =~ /\[/) { push (@signals, "$temp[3]") }
			else { push (@signals, "$temp[2]") }	
		} elsif ($_ =~ /inout/) {
			$_ =~ s/\s*inout/\treg/g;
			print TB;
			chomp;
			@temp = split (/\s+|;/);
			if ($temp[2] =~ /\[/) { push (@signals, "$temp[3]") }
			else { push (@signals, "$temp[2]") }	
		} elsif ($_ =~ /output/) {
			$_ =~ s/\s*output/\twire/g;
			print TB;
			chomp;
			@temp = split (/\s+|;/);
			if ($temp[2] =~ /\[/) { push (@outputs, "$temp[3]") }
			else { push (@outputs, "$temp[2]") }
		} elsif($_ =~ /endmodule/) {
			last;
		} elsif ($_ =~ /module/) {
			@temp = split (/\s+/);
			$module_name = $temp[1];
		}
	}
}

if ($clk_flag == 0) {
	$clk_name = "clk_generated";
	print TB "\treg $clk_name; //no clock constraint - generated clock for test bench only\n";
	$clk_period = 5; #this is not yet decided
}

print TB "\n\t//Set up the device under testing.\n";
print TB "\t$module_name dut (";
foreach (@outputs) {
	print TB ".$_($_), ";
}
foreach (@signals) {
	print TB ".$_($_)";
	if ($_ cmp @signals[$#signals]) { print TB ", "; }
}
print TB ");\n";

#### Set up CLK ####
print TB "\n\talways begin\n";
$clk_period = $clk_period/2;
print TB "\t\t#$clk_period\n\t\t$clk_name = ~$clk_name;\n";
$clk_period = $clk_period*2;

print TB "\tend\n";

#### Set up VARIABLES for RAND ####
print TB "\n\treg [31:0] prod_rand = SEED;\n";
print TB "\tinteger prod_n;\n";

print TB "\n\tinitial begin\n";

@signals = grep { $_ cmp $rst_name } @signals;
foreach $temp (@cnst_name) {
	@signals = grep { $_ cmp $temp } @signals;
}
#### Set up RESET ####
if ($rst_flag == 1) {
	$rst_hold = $rst_hold*$clk_period;
	print TB "\t\t$rst_name = $rst_hl;\n";
}

#### Set up CONSTANTS ####
foreach (@cnst_value) {
	print TB "\t\t$_;\n";
}

#### Set up REST OF SIGNALS ####
foreach (@signals) {
	print TB "\t\t$_ = 0;\n";
}

if ($clk_flag == 0) {print TB "\t\t$clk_name = 0;\n";}
if ($rst_flag == 1) {
	print TB "\t\t#$rst_hold;\n\n";
	if ($rst_hl==1) { print TB "\t\t$rst_name = 0;\n"; }
	else { print TB "\t\t$rst_name = 1;\n"; }
} else {
	$rst_hold = 1*$clk_period;
	print TB "\t\t#$rst_hold;\n\n";
}

@signals = grep { $_ cmp $clk_name } @signals;

#### toggle rate calculation ####
$switch_rate = (100 - $switch_rate) * 10;
print "$switch_rate";
#### RANDOM NUMBER GENERATOR ####
print TB "\t\tfor (prod_n = 0; prod_n < N_INPUTS; prod_n = prod_n + 1) begin\n";

print TB "\t\t\t//Produce an input every clock cycle.\n";
print TB "\t\t\t@(negedge $clk_name);\n";

print TB "\t\t\tprod_rand = \$random(prod_rand);\n";
print TB "\t\t\tif (prod_rand\[9:0\] \> 10\'d$switch_rate) begin\n";

foreach  (@signals) {
	#$temp = int(rand(10));
	print TB "\t\t\t\t$_ = prod_rand;\n";
	print TB "\t\t\t\tprod_rand = \$random(prod_rand);\n";
}

print TB "\t\t\tend\n";

print TB "\t\tend\n";
print TB "\t\t\$finish(0);\n";	

print TB "\tend\n";
print TB "\nendmodule\n";
close(SRC);
close(TB);

