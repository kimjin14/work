#############################################
# Area/Timing trade off analysis
#############################################
use File::Basename;

$flag = 0;

for ($i = 0; $i <= $#ARGV; $i++) {
	if ($ARGV[$i] eq '-v') {		
		$i++;
		push(@design_file, $ARGV[$i]);
		$design_dir = dirname("$ARGV[$i]");
		$design_name = basename("$ARGV[$i]", ".v");
		$flag++;
		while ($ARGV[$i+1] =~ /^[a-zA-Z0-9_.\/]/) { #no '-', keep going
			$i++;
			push(@design_file, $ARGV[$i]);
		}

	} elsif ($ARGV[$i] eq '-c') {
		$i++;
		$constraint_dir = dirname("$ARGV[$i]");
		$constraint_file = basename("$ARGV[$i]");
		$flag++;
	}
}

if ($flag < 2) {
	print "Usage perl digital_flow.pl -v <verilog.v> -c <constraint.in>\n";
	print "\t<verilog.v> top level module must be the same name as the file\n";
	print "\t<constraint.in> should follow the constraint_sample.in format\n";	
	exit;
}

open(cnstr, "$constraint_file");

while (<cnstr>) {
	if ($_ =~ /clock name:\s+\w+/) { @temp = $_ =~ /clock name:\s*(\w+)/; $design_clk = @temp[0]}
	elsif ($_ =~ /clock period:/) { @temp = $_ =~ /clock period:\s*(\w+.\w+)/; $design_period = @temp[0]}
	elsif ($_ =~ /reset name:/) { @temp = $_ =~ /reset name:\s*(\w+)/; $design_rst = @temp[0]}
	elsif ($_ =~ /reset cycle:/) { @temp = $_ =~ /reset cycle:\s*(\w+)/; $design_rstcycle = @temp[0]}
	elsif ($_ =~ /reset \(active h\/l\):/) { @temp = $_ =~ /reset \(active h\/l\):\s*(\w+)/; $design_rsthl = @temp[0]}
	elsif ($_ =~ /constants:/) { @temp = $_ =~ /constants:\s*(\w+)/; $design_cnst = @temp[0]}
	elsif ($_ =~ /constants values:/) { @temp = $_ =~ /constants values:\s*(\w+)/; $design_cnstval = @temp[0]}
	elsif ($_ =~ /percentage toggle:/) { @temp = $_ =~ /percentage toggle:\s*(\w+)/; $design_tglr = @temp[0]}
	elsif ($_ =~ /simulation length \(in cycles\):/) { @temp = $_ =~ /simulation length \(in cycles\):\s*(\w+)/; $design_simlength = @temp[0]}
	elsif ($_ =~ /other constraints:/) { @temp = $_ =~ /other constraints:\s*(.+)/; $design_constraints = @temp[0]}
	elsif ($_ =~ /other compile options:/) { @temp = $_ =~ /other compile options:\s*(.+)/; $design_compile = @temp[0]}
	elsif ($_ =~ /maximum area:/) { @temp = $_ =~ /maximum area:\s*(.+)/; $design_area = @temp[0]}
}

open (cnstr, "$constraint_dir/$constraint_file");
undef $/;
$file = <cnstr>;
close (cnstr);

##################################################################
# area optimized run is same as regular run
##################################################################
open (cnstr_area, ">area_${constraint_file}");
print cnstr_area "$file";
close (cnstr_area);

print "\nArea optimized run.\n";
#system ("perl digital_flow.pl -v @design_file -c area_$constraint_file");
#system ("mv $design_name area_$design_name");
open (area, "area_${design_name}/${design_name}.log");
@min_area = <area> =~ /Area of core:\s*(\w+.\w+)/;
close (area);

##################################################################
# timing optimized run allows area 10 times bigger than previous
##################################################################
$max_area = $min_area[0]*10;
$file =~ s/maximum area: 0/maximum area: $max_area/;
print "$max_area";
open (cnstr_timing, ">timing_${constraint_file}");
print cnstr_timing "$file";
close (cnstr_timing);
exit;
print "\nTiming constraint run.\n";
system ("perl digital_flow.pl -v @design_file -c timing_$constraint_file");
system ("mv $design_name timing_$design_name");

open (timing, "timing_${design_name}/${design_name}.log");
@min_timing = <timing> =~ /Maximum frequency:\s*(\w+.\w+)/;
close (timing);

##################################################################
# optimal point is the area and timing determined from before
##################################################################
$opt_timing = sprintf("%.2f", 1/$min_timing[0]);
$opt_area = $min_area[0];
$file =~ s/clock period:\s+\w+.\w+/clock period: $opt_timing/;
$file =~ s/constraints:\s+\w+\s+\w+.\w+/constraints: set_max_area $opt_area/;

open (cnstr_opt, ">opt_${constraint_file}");
print cnstr_opt "$file";
close (cnstr_opt);

print "\nArea timing constrained run.\n";
system ("perl digital_flow.pl -v @design_file -c opt_$constraint_file");
system ("mv $design_name opt_$design_name");

