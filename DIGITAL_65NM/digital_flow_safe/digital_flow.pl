#############################################
# Verilog to Area Timing Power
#############################################
use File::Basename;
use File::Copy;

$input_flag = 0;

$dc_flag = 1;
$enc_flag = 1;
$timing_flag = 1;
$sim_flag = 1;
$power_flag = 1;

$syn_flag = 0;
$syn_script_flag = 0;

for ($i = 0; $i <= $#ARGV; $i++) {
	if ($ARGV[$i] eq '-v') {		
		$i++;
		push(@design_file, $ARGV[$i]);
		$design_dir = dirname("$ARGV[$i]");
		$design_name = basename("$ARGV[$i]", ".v");
		$folder_name = $design_name;
		$input_flag++;
		while ($ARGV[$i+1] =~ /^[a-zA-Z0-9_.\/]/) { #no '-', keep going
			$i++;
			push(@design_file, $ARGV[$i]);
		}

	} elsif ($ARGV[$i] eq '-c') {
		$i++;
		$constraint_file = $ARGV[$i];
		$input_flag++;
	} elsif ($ARGV[$i] eq '-d') {
		$i++;
		$folder_name = $ARGV[$i];
	} elsif ($ARGV[$i] eq '-sdc') {
		$i++;
		$sdc_sub = $ARGV[$i];
		$sdc_flag = 1;
	} elsif ($ARGV[$i] eq '-tcl') {
		$i++;
		$syn_sub = $ARGV[$i];
		$syn_script_flag = 1;
	} elsif ($ARGV[$i] eq '-nosyn') {
		$dc_flag = 0;
	} elsif ($ARGV[$i] eq '-nopr') {
		$enc_flag = 0;
	} elsif ($ARGV[$i] eq '-notiming') {
		$timing_flag = 0;
	} elsif ($ARGV[$i] eq '-nosim') {
		$sim_flag = 0;
	} elsif ($ARGV[$i] eq '-nopower') {
		$power_flag = 0;
	} elsif ($ARGV[$i] eq '-help') {
		$input_flag = 0;
	}
}

if ($input_flag < 2) {
	print "Usage perl digital_flow.pl -v <verilog.v> -c <constraint.in>\n";
	print "\t-v <verilog.v> top level module must be the same name as the file\n";
	print "\t-c <constraint.in> should follow the constraint_sample.in format\n";
	print "\t\tclock name:\n";
	print "\t\tclock period:\n";
	print "\t\treset name:\n";
	print "\t\treset cycle:\n";
	print "\t\treset (active h/l):\n";
	print "\t\tconstants:\n";
	print "\t\tconstants values:\n";
	print "\t\tpercentage toggle:\n";
	print "\t\tsimulation length (in cycles):\n";
	print "\t\tmaximum area:\n";
	print "\t\tother constraints:\n";
	print "\t\tother compile options: set_flatten, ungroup -all\n";
	print "\t-d directory\n";
	print "\t-sdc: use this sdc file\n";
	print "\t-tcl: use this tcl file for synopsys\n";
	print "\t-nosyn: skip synthesis, requires synthesized verilog from previous run\n";
	print "\t-nopr: skip place and route, requires golden netlist, spef, and sdc file\n";
	print "\t-notiming: skip timing analysis, requires maximum frequency\n";
	print "\t-nosim: skip simulation, requires vcd\n";
	print "\t-nopower: skip power analysis\n";
	exit;
}
print "---------------------------------------------------\n";
print "Design to be synthesized is $design_name.\n";
print "- verilog files: @design_file\n";


#############################################
# Parse input constraint
#############################################
print "- design constraints: $constraint_file\n";

open(cnstr, "$constraint_file");

$design_clk = "";
$design_period = "5";
$design_rst = "";
$design_rstcycle = "";
$design_rsthl = "";
$design_cnst = "";
$design_cnstval = "";
$design_tglr = "100";
$design_simlength = "1000";
$#design_compile = -1;
$#design_constraints = -1;
$design_area = "0";

$start_constraints = 0;
$start_compile = 0;

while (<cnstr>) {
	chomp;
	if ($_ =~ s/clock name:\s*//g) { $design_clk = $_; $start_constraints = 0; $start_compile = 0; }
	elsif ($_ =~ s/other compile options:\s*//g || $start_compile == 1 ) { push(@design_compile,"$_\n"); $start_compile = 1; $start_constraints = 0; }
	elsif ($_ =~ s/clock period:\s*//g) { $design_period = $_; $start_constraints = 0; $start_compile = 0; }
	elsif ($_ =~ s/reset name:\s*//g) { $design_rst = $_; $start_constraints = 0; $start_compile = 0; }
	elsif ($_ =~ s/reset cycle:\s*//g) { $design_rstcycle = $_; $start_constraints = 0; $start_compile = 0; }
	elsif ($_ =~ s/reset \(active h\/l\):\s*//g) { $design_rsthl = $_; $start_constraints = 0; $start_compile = 0; }
	elsif ($_ =~ s/constants:\s*//g) { $design_cnst = $_; $start_constraints = 0; $start_compile = 0; }
	elsif ($_ =~ s/constants values:\s*//g) { $design_cnstval = $_; $start_constraints = 0; $start_compile = 0; }
	elsif ($_ =~ s/percentage toggle:\s*//g) { $design_tglr = $_; $start_constraints = 0; $start_compile = 0; }
	elsif ($_ =~ s/simulation length \(in cycles\):\s*//g) { $design_simlength = $_; $start_constraints = 0; $start_compile = 0; }
	elsif ($_ =~ s/other constraints:\s*//g || $start_constraints == 1 ) { push(@design_constraints,"$_\n"); $start_constraints = 1; $start_compile = 0; }
	elsif ($_ =~ s/maximum area:\s*//g) { $design_area = $_; $start_constraints = 0; $start_compile = 0; }
}


if ($design_clk cmp "") {print "    clock: $design_clk with period $design_period ns\n";}
else {print "    clock: no clock signal specified, simulation will run at 200MHz\n";$design_period = 5;}

if ($design_rst cmp "") {print "    reset: $design_rst set to $design_rsthl for $design_rstcycle cycle(s)\n";}
if ($design_cnst cmp "") {print "    constants: $design_cnst set to $design_cnstval respectively\n";}

if ($design_area cmp "") {print "    constraints: set_max_area $design_area @design_constraints\n";}
else {print "    constraints (default): set_max_area 0\n";}

if ($#design_compile > -1) {print "    compile options: @design_compile\n";}

if ($design_simlength cmp "" && $design_tglr eq "") {print "    simulation: $design_simlength cycles with 100% (default) toggle rate\n"; $design_tglr=100;}
elsif ($design_simlength eq "" && $design_tglr cmp ""){print "    simulation: 1000 (default) cycles with $design_tglr\% toggle rate\n"; $design_simlength=1000;}
else {print "    simulation: 1000 (default) cycles with 100% (default) toggle rate\n"; $design_tglr=100; $design_simlength=1000;}

$log = "${design_name}.log";
open (logfile, ">${$folder_name}/$log");
print logfile "Digital Flow Summary\n";

$error_flag = 0;

#############################################
# Synthesis
#############################################
$dc_script = "syn.tcl";
$dc_setup = ".synopsys_dc.setup";
$dc_constraint = "constraint.sdc";

if ($dc_flag == 0) {print "synthesis skipped.\n"; } else { #START SKIP SYNTHESIS
	if (!(-d "$folder_name")) {system ("mkdir $folder_name");}
	if (!(-d "${$folder_name}/syn")) {system ("mkdir ${folder_name}/syn");}
	if (!(-d "${folder_name}/syn/script")) {system ("mkdir ${folder_name}/syn/script");}
	if (!(-d "${folder_name}/syn/src")) {system ("mkdir ${folder_name}/syn/src");}
	print "synthesis starting...";

	#copy verilog source into src folder
	for my $dc_src (@design_file) {	
		copy("$dc_src", "${folder_name}/syn/src") or die "Copy failed: $!";
	}
	$#design_file = -1;
	opendir (DIR, "${folder_name}/syn/src") or die $!;
	while (my $file = readdir(DIR)) {
		next if($file =~ m/^\./);
		push(@design_file, $file);
	}

	#copy over the synopsys setup file to design directory
	copy ("setup/$dc_setup", "${folder_name}/syn") or die "Copy failed: $!";

	#copy script
	{
		if ($syn_script_flag) { open(script, "$syn_sub"); }
		else { open(script, "script/$dc_script"); }
		local $/ = undef;
		$file = <script>;
		$file =~ s/\"\$verilog\"/@design_file/;
		$file =~ s/design/design $design_name/;
		$file =~ s/COMPILE OPTIONS/@design_compile/;
		$file =~ s/CONSTRAINT OPTIONS/@design_constraints/;
	}
	close(script);
	
	open (script, ">${folder_name}/syn/script/$dc_script");
	print script $file;
	close (script);

	#copy constraint file
	open (script, ">${folder_name}/syn/script/$dc_constraint");
	print script $design_constraints;
	print script "set_max_delay -from [all_inputs] -to [all_outputs] $design_period\n";
	print script "set_max_area $design_area\n";
	if ($design_clk cmp "") {
		print script "create_clock -name clk -period $design_period $design_clk\n";
		print script "set_dont_touch_network $design_clk\n";
		print script "set_ideal_network $design_clk\n";
	}
	close (script);

	#run synthesis
	chdir("${folder_name}/syn");
	system ("dc_shell-t -64 -f script/$dc_script >output.txt");
	chdir("../../");
	print " completed.\n";

} #END SKIP SYNTHESIS

#process synthesis output
$#area = -1; $#slack = -1;
open (report, "${folder_name}/syn/output.txt");
while (<report>) {
	chomp;
	if ($_ =~ /Total cell area:\s*(.+)/) {
		push(@area, ($_ =~ /Total cell area:\s*(.+)/));
	} elsif ($_ =~ /slack \(\w+\)\s*(.+)/) {
		push(@slack, ($_ =~ /slack \(\w+\)\s*(.+)/));
	} elsif ($_ =~ /error/i) {
		$error_flag = 1;
		print "Synthesis error: $_\n";
	}
}
close (report);

if ($error_flag == 1) { exit; }

print logfile "\n####### Before Place and Route #######\n";
$pre_area = @area[0];
$pre_area = sprintf("%.2f", $pre_area);
print logfile "Area of core: $pre_area um^2\n";
@slack = sort {$a <=> $b} @slack;
$pre_time = @slack[0];
$pre_time = $design_period - $pre_time;
if ($design_clk eq "") { $pre_time = sprintf("%.2f", $pre_time); print logfile "Longest delay: $pre_time ns\n"; }
else { $pre_time = sprintf("%.2f", 1/$pre_time); print logfile "Maximum frequency: $pre_time GHz\n"; }

#############################################
# Place and Route
#############################################
$enc_script = "encounter.tcl";
$enc_setup = "encounter.conf";

if ($enc_flag == 0) {print "place and route skipped.\n"; } else { #START SKIP PR
	if (!(-d "${folder_name}/enc")) {system ("mkdir ${folder_name}/enc");}
	if (!(-d "${folder_name}/enc/script")) {system ("mkdir ${folder_name}/enc/script");}
	if (!(-d "${folder_name}/enc/src")) {system ("mkdir ${folder_name}/enc/src");}
	print "place and route starting...";

	#copy netlist into src folder
	system ("cp ${folder_name}/syn/${design_name}_compiled.v ${folder_name}/enc/src");

	#copy constraints into src folder
	system ("cp ${folder_name}/syn/${design_name}_default.sdc ${folder_name}/enc/src");

	#copy over the encounter setup file to design directory
	{
		open(script, "setup/$enc_setup");
		local $/ = undef;
		$file = <script>;
		$file =~ s/\(ui_netlist\)/\(ui_netlist\) src\/${design_name}_compiled.v/;
		$file =~ s/\(ui_topcell\)/\(ui_topcell\) $design_name/;
		$file =~ s/\(ui_timingcon_file\)/\(ui_timingcon_file\) src\/${design_name}_default.sdc/;
		close(script);
	}
	open (script, ">${folder_name}/enc/$enc_setup");
	print script $file;
	close (script);

	#copy encounter script
	{
		open(script, "script/$enc_script");
		local $/ = undef;
		$file = <script>;
		$file =~ s/loadConfig/loadConfig $enc_setup/;
		$file =~ s/verilog/verilog ${design_name}.v/;
		$file =~ s/design/design $design_name/;
		close(script);
	}
	open (script, ">${folder_name}/enc/script/$enc_script");
	print script $file;
	close (script);

	#run place and route
	chdir("${folder_name}/enc");
	system ("encounter -nowin -init script/$enc_script >output.txt");
	chdir("../../");
	print " completed.\n";

} #END SKIP PR

#process encounter output
$#area = -1;
open (report, "${folder_name}/enc/report.txt");
while (<report>) {
	chomp;
	if ($_ =~ /Total area of Core:\s*(.+)/) {
		push(@area, ($_ =~ /Total area of Core:\s*(.+)/));
	} elsif ($_ =~ /error/i) {
		if ($_ =~ /Errors: 0/) {} else {
			$error_flag = 1;
			print "Encounter error: $_\n";
		}
	}
}
close (report);

if ($error_flag == 1) { exit; }

print logfile "\n####### After Place and Route #######\n";
$post_area = @area[0];
$post_area = sprintf("%.2f", $post_area);
print logfile "Area of core: $post_area um^s\n";

#############################################
# Timing
#############################################
$primetime_script = "primetime_timing.tcl";

if ($timing_flag == 0) {print "timing analysis skipped.\n"; } else { #START SKIP TIMING
	if (!(-d "${folder_name}/sim")) {system ("mkdir ${folder_name}/sim");}
	if (!(-d "${folder_name}/sim/script")) {system ("mkdir ${folder_name}/sim/script");}
	if (!(-d "${folder_name}/sim/src")) {system ("mkdir ${folder_name}/sim/src");}
	print "timing analysis starting...";

	#copy golen netlist into src folder
	system ("cp ${folder_name}/enc/${design_name}_golden.v ${folder_name}/pt/src");

	#copy rc into src folder
	system ("cp ${folder_name}/enc/${design_name}.spef ${folder_name}/pt/src");

	#copy constraint file
	system ("cp ${folder_name}/syn/${design_name}_default.sdc ${folder_name}/pt/src");

	#copy over the primetime script file to design directory
	{
		open(script, "script/$primetime_script");
		local $/ = undef;
		$file = <script>;
		$file =~ s/design/design $design_name/;
		$file =~ s/spef/spef ${design_name}.spef/;
		close(script);
	}
	open (script, ">${folder_name}/pt/script/$primetime_script");
	print script $file;
	close (script);

	#run timing power analysis
	chdir("${folder_name}/pt");
	system ("primetime -file  script/$primetime_script >output_timing.txt");
	chdir("../../");
	print " completed.\n";

} #END SKIP TIMING

#process primetime output
$#slack = -1;
open (report, "${folder_name}/pt/output_timing.txt");
while (<report>) {
	chomp;
	if ($_ =~ /slack \(\w+\)\s*(.+)/) {
		push(@slack, ($_ =~ /slack \(\w+\)\s*(.+)/));
	} elsif ($_ =~ /error/i) {
		if ($_ =~ /0 error\(s\)/) { } else {
			$error_flag = 1;
			print "Primetine (timing) error: $_\n";
		}	
	}
}
close (report);

if ($error_flag == 1) { exit; }

@slack = sort {$a <=> $b} @slack;
$post_time = @slack[0];
$post_time = $design_period - $post_time + 0.001; #some padding since it was failing setup/hold time
$max_freq = $post_time;
if ($design_clk eq "") { $post_time = sprintf("%.2f", $post_time); print logfile "Longest delay: $post_time ns\n"; }
else { $post_time = sprintf("%.2f", 1/$post_time); print logfile "Maximum frequency: $post_time GHz\n"; }

#############################################
# Post-synthesis Simulation
#############################################
$sim_script = "sim.do";

if ($sim_flag == 0) {print "simulation skipped.\n"; } else { #START SKIP SIM
	if (!(-d "${folder_name}/pt")) {system ("mkdir ${folder_name}/pt");}
	if (!(-d "${folder_name}/pt/script")) {system ("mkdir ${folder_name}/pt/script");}
	if (!(-d "${folder_name}/pt/src")) {system ("mkdir ${folder_name}/pt/src");}
	print "simulation starting...";

	#copy golen netlist into src folder
	system ("cp ${folder_name}/enc/${design_name}_golden.v ${folder_name}/sim/src");

	#copy sdf file into src folder
	system ("cp ${folder_name}/enc/${design_name}.sdf ${folder_name}/sim/src");

	#compile tsmc library for use if it doesn't exist
	system ("mkdir -p lib");
	if (-d "lib/tsmc_lib") {} else {
		system ("vlib lib/tsmc_lib");
		system ("chmod 700 lib/tsmc_lib");
		system ("vlog -work lib/tsmc_lib /CMC/kits/tsmc_65nm_libs/tcbn65gplus/TSMCHOME/digital/Front_End/verilog/tcbn65gplus_140b/tcbn65gplus.v /CMC/kits/tsmc_65nm_libs/tpzn65gpgv2/TSMCHOME/digital/Front_End/verilog/tpzn65gpgv2_140c/tpzn65gpgv2.v");
	}

	#copy over the modelsim script file to design directory
	{
		open(script, "script/$sim_script");
		local $/ = undef;
		$file = <script>;
		$file =~ s/design/design $design_name/;
		$file =~ s/lib/lib ..\/..\/lib\/tsmc_lib/;
		$file =~ s/sdf/sdf src\/${design_name}.sdf/;
		close(script);
	}
	open (script, ">${folder_name}/sim/script/$sim_script");
	print script $file;
	close (script);

	#run testbench generator and modelsim
	chdir("${folder_name}/sim");
	if ($design_clk eq "") {} else {$tb_clk_option = "-clk $design_clk $max_freq";}
	if ($design_rst eq "") {} else {$tb_rst_option = "-r $design_rst $design_rstcycle $design_rsthl";}
	system ("perl ../../script/tb_gen.pl -v src/${design_name}_golden.v $tb_clk_option $tb_rst_option -l $design_simlength -tglr $design_tglr");
	system ("vsim -c -do script/sim.do </dev/null >output.txt");
	chdir("../../");
	print " completed.\n";

	#process output
	open (report, "${folder_name}/sim/output.txt");
	while (<report>) {
		chomp;
		if ($_ =~ /error/i) {
			$error_flag = 1;
			print "ModelSim error: $_\n"
		}
	}
	close (report);

} #END SKIP SIM

if ($error_flag == 1) { exit; }

#############################################
# Power
#############################################
$primetime_script = "primetime.tcl";

if ($power_flag == 0) {print "power analysis skipped.\n"; } else { #START SKIP POWER
	if (!(-d "${folder_name}/pt")) {system ("mkdir ${folder_name}/pt");}
	if (!(-d "${folder_name}/pt/script")) {system ("mkdir ${folder_name}/pt/script");}
	if (!(-d "${folder_name}/pt/src")) {system ("mkdir ${folder_name}/pt/src");}
	print "power analysis starting...";

	#copy golen netlist into src folder
	system ("cp ${folder_name}/enc/${design_name}_golden.v ${folder_name}/pt/src");

	#copy rc into src folder
	system ("cp ${folder_name}/enc/${design_name}.spef ${folder_name}/pt/src");

	#copy vcd into src folder
	system ("cp ${folder_name}/sim/dump.vcd ${folder_name}/pt/src");

	#copy constraint file
	system ("cp script/$dc_constraint ${folder_name}/pt/script/$dc_constraint");

	#copy over the primetime script file to design directory
	{
		open(script, "script/$primetime_script");
		local $/ = undef;
		$file = <script>;
		$file =~ s/design/design $design_name/;
		$file =~ s/spef/spef ${design_name}.spef/;
		$file =~ s/vcd/vcd dump.vcd/;
		close(script);
	}
	open (script, ">${folder_name}/pt/script/$primetime_script");
	print script $file;
	close (script);

	#run timing power analysis
	chdir("${folder_name}/pt");
	system ("primetime -file  script/$primetime_script >output_power.txt");
	chdir("../../");
	print " completed.\n";

} #END SKIP POWER

#process output
$#power = -1; $#magnitude = -1;
open (report, "${folder_name}/pt/output_power.txt");
while (<report>) {
	chomp;
	if ($_ =~ /Total Power\s*=\s*(\d+\.\d+\w\-\w+)/) {
		push(@power,($_ =~ /Total Power\s*=\s*(\d+\.\d+)/));
		push(@magnitude, ($_ =~ /Total Power\s*=\s*\d+\.\d+(\w\-\w+)/));
	} elsif ($_ =~ /error/i) {
		if ($_ =~ /0 error\(s\)/) { } else {
			$error_flag = 1;
			print "Primetine (power) error: $_\n";
		}	
	}
}
close (report);

if ($error_flag == 1) { exit; }
$post_power = @power[0];
if ($design_clk eq "") { $max_freq = 5; }
$post_energy = $post_power*$design_simlength*$max_freq;
print logfile "Total power: ${post_power}@{magnitude} W\n";
print logfile "Total energy: ${post_energy}@{magnitude} J @ $design_simlength cycles at $max_freq ns\n";

print "\nSuccessfully completed.\nPlease refer to $folder_name/${design_name}.log for summary results.\n";

close (logfile);

