use File::Spec;
use File::Basename;
use Cwd;

@design = (alu4, apex4, des, diffeq, dsip, elliptic, ex1010, ex5p, frisc, misex3, pdc, s298, s38417, seq_mcnc, spla, tseng, addshift16, fsm);
@opt = (pt_balance_final);

#for ($i = 0; $i <= $#design; $i++) {
#	system ("perl fpga_flow.pl -v verilog/mcnc/@design[$i].v -a arch/sIII_arch_fixed.xml -op --nodisp --route_chan_width 300 -tag newvtr -nodigital");
#	print "done @design[$i]\n";
#}

for ($i = 0; $i <= $#design; $i++) {
	# copy the sdc files
	system ("cp design/@design[$i]_newvtr/vtr/fpga_top.sdc design/timing_analysis/sdc/@design[$i].sdc");

	for ($j = 0; $j <= $#opt; $j++) {
		system ("cp design/timing_analysis/sdc/@design[$i].sdc design/timing_analysis/@opt[$j]/src/fpga_top.sdc");
	
		chdir ("design/timing_analysis/@opt[$j]/");
		system ("pt_shell -64 -f script/primetime_timing.tcl > output.txt");
		system ("mv timing.rpt @design[$i].rpt");
	
		chdir ("../../..");
		system ("cp design/timing_analysis/@opt[$j]/output.txt design/timing_analysis/result/@design[$i]_@opt[$j].txt");
		system ("echo @design[$i]_@opt[$j].txt has been saved");
	}
}
