use File::Spec;
use File::Basename;
use Cwd;

#@design = (addshift16);
@design = (alu4, fsm, apex2, apex4, bigkey, clma, frisc, diffeq);
@opt = (pt_area, pt_area_fp, pt_timing, pt_timing_fp);
#@opt = (pt, pt_fp, pt_area, pt_area_fp, pt_timing, pt_timing_fp);

#for ($i = 0; $i <= $#design; $i++) {

#	system ("perl fpga_flow.pl -v benchmarks/@design[$i].v -a arch/sIII_arch_fixed.xml -op --nodisp --route_chan_width 300 -tag vtr -nodigital");
#	print "done @design[$i]\n";
#}

for ($i = 0; $i <= $#design; $i++) {
	system ("cp design/@design[$i]_vtr/vtr/fpga_top.sdc design/timing_analysis/sdc/@design[$i].sdc");

	for ($j = 0; $j <= $#opt; $j++) {
		system ("cp design/timing_analysis/sdc/@design[$i].sdc design/timing_analysis/@opt[$j]/src/fpga_top.sdc");
	
		chdir ("design/timing_analysis/@opt[$j]/");
		system ("pt_shell -64 -f script/primetime_timing.tcl > output.txt");
	
		chdir ("../../..");
		system ("cp design/timing_analysis/@opt[$j]/output.txt design/timing_analysis/result/@design[$i]_@opt[$j].txt");
	}
}
