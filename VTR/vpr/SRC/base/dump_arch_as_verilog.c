#include <assert.h>
#include <string.h>
#include "util.h"
#include "vpr_types.h"
#include "globals.h"
#include "pb_type_graph.h"
#include "rr_graph.h"
#include "rr_graph_util.h"
#include "dump_arch_as_verilog.h"
#include "dump_bitstream.h"
#include "vpr_utils.h"

int buffer_freq = 3;

void dump_arch_as_verilog () {
	int *pb_graph_config_bits = (int*)malloc(num_types*sizeof(int));
	int max_mux_size = 0;
	dump_pb_graph_as_verilog("FPGA/fpga_modules.v", pb_graph_config_bits, &max_mux_size);
	dump_rr_graph_as_verilog("FPGA/fpga_top.v", pb_graph_config_bits, &max_mux_size);
	max_mux_size++; // for GROUND signal for the mux
	dump_mux_as_verilog("FPGA/fpga_mux.v", &max_mux_size);

}

void dump_mux_as_verilog (INP const char *file_name, int* mux_max_size) {
	FILE *fp;
	fp = my_fopen(file_name, "w", 0);
	/////////////////////////////////////////////////////////////////////	
	//create muxes
	/////////////////////////////////////////////////////////////////////

	int CMUX_SIZE = 16;


		for (int i=2; i<mux_max_size[0]+1; i++) {

			int n_i = i; //total number if inputs
			int n_m16 = ceil((double)((int)((double)(n_i-1)/8))/2); //number of mux16		
			int n_r = n_i-(16*(n_m16)); // rest of inputs
			int n_sel = (int)ceil(log(i)/log(2));	//number of select signals		
			if (n_sel>3) n_sel+=2;

			fprintf(fp, "module mux%d (\n", i);
			fprintf(fp, "\tinput [%d:0]in,\n", n_i-1);
			fprintf(fp, "\tinput [%d:0]config_in,\n", n_sel-1);
			fprintf(fp, "\tinput config_rst,\n");				
			fprintf(fp, "\toutput out\n");				
			fprintf(fp, ");\n\n");
			fprintf(fp, "reg out_mux;\n");

			int j;
			
			//instantiate mux16
			//there should be a mux for every 16 input and a mux if remaining is greater than 8
			for (j=0; j<n_m16; j++) {
				fprintf(fp, "wire out_mux16_%d;\n", j);
				fprintf(fp, "NPASSMUX16 mux_%d (", j);
				for (int k=0; k<16; k++) {
					if ((k+(16*j))>=n_i) fprintf(fp, ".I%d(1'b0), ", k);
					else fprintf(fp, ".I%d(in[%d]), ", k, k+(16*j));
				}
				for (int k=0; k<6; k++) {
					if (k<n_sel) fprintf(fp, ".S%d(config_in[%d]), ", k, k);
					else fprintf(fp, ".S%d(1'b0), ", k);
				}
				fprintf(fp, ".O(out_mux16_%d));\n\n", j);
			}

			//instantiate mux for remainder
			//always statement since you don't know the size
			//n_r can be negative if remainder was greater than 8 but less than 16
			fprintf(fp, "reg out_r;\n\n");
			fprintf(fp, "always @ (*) begin\n");
			if (n_r>1) {
				if (n_m16>0) fprintf(fp, "\tcase(config_in[%d:%d])\n", 5, 0);
				else fprintf(fp, "\tcase(config_in[%d:%d])\n", (int)ceil(log(n_r)/log(2))-1, 0);
				for (j=0; j<n_r; j++) {
					if (n_m16>0) fprintf(fp, "\t\t%d'b%d%d%d%d%d%d: out_r = in[%d];\n", 6, (j>>3)&1, (j>>2)&1, \
						((j>>1)&1)&(j&1), ((j>>1)&1)&!(j&1), !((j>>1)&1)&(j&1), !((j>>1)&1)&!(j&1), n_m16*16+j);
					else fprintf(fp, "\t\t%d'd%d: out_r = in[%d];\n", (int)ceil(log(n_r)/log(2)), j, n_m16*16+j);
				}
				fprintf(fp, "\t\tdefault: out_r = 1'b1;\n");
                                fprintf(fp, "\tendcase\n");
			} else if (n_r==1) fprintf(fp, "\tout_r = in[%d];\n", n_m16*16);
	                fprintf(fp, "end\n\n");
			
			//create second level of mux
			//must have more than 6 config cells since it used a MUX16
			int n_sel_used;
			fprintf(fp, "always @ (*) begin\n");
			if (n_m16+(int)(n_r>0) > 1) {
				fprintf(fp, "\tcase(config_in[%d:%d])\n", n_sel-1, 6);
				for (j=0; j<n_m16; j++) fprintf(fp, "\t\t%d'd%d: out_mux = out_mux16_%d;\n", (int)ceil(log(1+n_m16)/log(2)), j, j);
				if (n_r>0) fprintf(fp, "\t\t%d'd%d: out_mux = out_r;\n", (int)ceil(log(1+n_m16)/log(2)), j);
		                fprintf(fp, "\t\tdefault: out_mux = 1'b1;\n");
			        fprintf(fp, "\tendcase\n");
			} else if (n_m16 > 0) fprintf(fp, "\tout_mux = out_mux16_0;\n"); 
			else fprintf(fp, "\tout_mux = out_r;\n");
                	fprintf(fp, "end\n\n");

/*
			if (n_r>0&&n_m16>0) {
				fprintf(fp, "\nalways @ (*) begin\n");
				fprintf(fp, "\tcase(config_in[%d:%d])\n", (int)ceil(log(1+n_m16)/log(2))+(int)(n_m16>0)*6-1, (int)(n_m16>0)*6);	
				for (j=0; j<n_m16; j++) fprintf(fp, "\t\t%d'd%d: out_mux = out_mux16_%d;\n", (int)ceil(log(1+n_m16)/log(2)), j, j);
				fprintf(fp, "\t\t%d'd%d: out_mux = out_r;\n", (int)ceil(log(1+n_m16)/log(2)), j);
				fprintf(fp, "\t\tdefault: out_mux = 1'b1;\n");
				fprintf(fp, "\tendcase\n");	
				fprintf(fp, "end\n\n");
			} else if (n_m16==0){
				fprintf(fp, "\nalways @ (*) begin\n");
				fprintf(fp, "\tout_mux = out_r;\nend\n\n");
			} else {
				fprintf(fp, "\nalways @ (*) begin\n");
				fprintf(fp, "\tout_mux = out_mux16_0;\nend\n\n");
			}
*//*
			for (j=0; j<n_m16; j++) {
				fprintf(fp, "wire out_mux16_%d;\n", j);
				fprintf(fp, "NPASSMUX16 mux_%d (", j);
				for (int k=0; k<16; k++) {
					if ((k+(16*j))>=n_i) fprintf(fp, ".I%d(1'bz), ", k);
					else fprintf(fp, ".I%d(in[%d]), ", k, k+(16*j));
				}
				for (int k=0; k<6; k++) {
					if (k<n_sel) fprintf(fp, ".S%d(config_in[%d]), ", k, k);
					else fprintf(fp, ".S%d(1'b0), ", k);
				}
				fprintf(fp, ".OUT(out_mux16_%d));\n", j);
			}
		
			if (n_m16+n_r>8) {
				fprintf(fp, "wire out_mux16_%d;\n", j);
				fprintf(fp, "NPASSMUX16 mux_%d (", j);
				for (int k=j*16; k<(j+1)*16; k++) {
					if (k>=n_i) fprintf(fp, ".I%d(1'bz), ", k);
					else fprintf(fp, ".I%d(in[%d]), ", k, k);
				}
				fprintf(fp, ".OUT(out_mux16_%d));\n", j);
			} else if (n_r>0) {
				fprintf(fp, "\nalways @ (*) begin\n");
				fprintf(fp, "\tcase(config_in[%d:%d])\n", n_sel-1, 6);	
				for (j=0; j<n_m16; j++) fprintf(fp, "\t\t%d'd%d: out_mux = out_mux16_%d;\n", (int)ceil(log(i)/log(2)), j, j);
				for (j=n_m16; j<n_r; j++) fprintf(fp, "\t\t%d'd%d: out_mux = in[%d];\n", (int)ceil(log(i)/log(2)), j, n_m16*16+j);
				fprintf(fp, "\t\tdefault: out_mux = 1'b1;\n");
				fprintf(fp, "\tendcase\n");	
				fprintf(fp, "end\n\n");
			} else {
				fprintf(fp, "\nalways @ (*) begin\n");
				fprintf(fp, "\tout_mux = out_mux16_0;\nend\n\n");
			} 
				
*/




		/*	if (i>8) {
				fprintf(fp, "wire [%d:0]out_mux_temp;\n", (int)ceil((double)i/16));
				fprintf(fp, "wire out_mux\n\n");
				for (int j=0; j<(int)ceil((double)i/16); j++) {	
					fprintf(fp, "NPASSMUX16 mux_%d (", j);
					for (int k=0; k<i; k++) fprintf(fp, ".I%d(in[%d]), ", k, k);
					for (int k=i; k<16*(int)ceil((double)i/16); k++) fprintf(fp, ".I%d(1'bz), ", k);
					fprintf(fp, ".OUT());\n");
				}
				fprintf(fp, "\n");
			} else {
				fprintf(fp, "reg out_mux;\n\n");
				
				fprintf(fp, "always @ (*) begin\n");
				fprintf(fp, "\tcase(config_in)\n");	
				for (int j=0; j<i; j++) {
					fprintf(fp, "\t\t%d'd%d: out_mux = in[%d];\n", (int)ceil(log(i)/log(2)), j, j);
				}	
				fprintf(fp, "\t\tdefault: out_mux = 1'b1;\n");
				fprintf(fp, "\tendcase\n");	
				fprintf(fp, "end\n\n");
			}*/
			fprintf(fp, "assign out = config_rst?1'b1:out_mux;\n\n");
			fprintf(fp, "endmodule\n\n");
		}
		fclose(fp);
	}
		
	/* This function calls the recursive dump pb function for all the types.
	file_name: where the verilog for the pb will be dumped
	pb_graph_config_bits: used to keep information on how many config bits are required */

	void dump_pb_graph_as_verilog (INP const char *file_name, int* pb_graph_config_bits,\
		int* mux_max_size) {
		
		FILE *fp;
		int i;

		fp = my_fopen(file_name, "w", 0);
		
		fprintf(fp, "//////////////////////////////////\n");
		fprintf(fp, "//physical block modules\n");
		fprintf(fp, "//////////////////////////////////\n\n");
		
		//for all blocks (not <EMPTY>), recursively dump physcal blocks
		for (i = 0; i < num_types; i++) {
			if (type_descriptors[i].pb_graph_head) {
				pb_graph_config_bits[i] = dump_pb_rec_verilog(type_descriptors[i].pb_graph_head, \
					fp, type_descriptors[i].capacity, mux_max_size);						
			}
		}
		
		//print module latch
		/*fprintf(fp, "/////////////////////////////////////////////////////\n");
		fprintf(fp, "///////////////////// latch /////////////////////////\n");
		fprintf(fp, "/////////////////////////////////////////////////////\n");
		fprintf(fp, "module latch ( input clk, input reset, input en, input in, output reg out );\n\n");
		fprintf(fp, "always @ (posedge clk) begin\n");
		fprintf(fp, "\tif(!reset) begin\n\t\tout<=0;\n\tend\n");
		fprintf(fp, "\telse if (en) begin\n\t\tout<=in;\n\tend\n");
		fprintf(fp, "end\n\n");
		fprintf(fp, "endmodule\n");
		*/
		fclose(fp);
	}

	/* This function recursively prints out pb tree as modules (from the bottom of tree - lut and ff).
	pb_graph_node: current node being printed
	fp: file where the verilog is being dumped
	capacity: capacity of the block (to group them together)

	returns number of configuration bits required for node and its children

	This function does NOT accomodate "modes" (for loops commented out with i set to 0)
	Only a special case for fracturable lut with 2nd mode named "lut5inter".*/

	int dump_pb_rec_verilog (const INP t_pb_graph_node *pb_graph_node, INP FILE *fp, \
		INP int capacity, int* mux_max_size) {

		int i, j, k, l;
		int n_config_prev_total, n_config;
		int *n_config_used; 
		int** n_config_prev_per_child;
		
		int flag_first;
		int num_input;
		
		t_pb_graph_pin **pb_graph_pins;
		t_port *port;
		
		//////////////////////////////////////////////////////
		// FLE special case
		//	- if a pb_type with a name "fle" is detected, fracturable lut
		//		in EArch is instantiated
		//	- if you do not want a fracturable lut, change the pb_type name to
		//		something other than "fle"
		//////////////////////////////////////////////////////
		if (strcmp(pb_graph_node->pb_type->name, "fle")==0) {
			assert(pb_graph_node->pb_type->num_modes>1);

			/*fprintf(fp, "/////////////////////////////////////////////////////\n");
			fprintf(fp, "/////////////////////// fle /////////////////////////\n");
			fprintf(fp, "/////////////////////////////////////////////////////\n");
			fprintf(fp, "module fle (\n");
			fprintf(fp, "\tinput [65:0]config_in,\n"); 
			fprintf(fp, "\tinput config_mode,\n");
			fprintf(fp, "\tinput clk,\n");
			fprintf(fp, "\tinput [7:0]fle_in,\n"); 
			fprintf(fp, "\toutput [1:0]fle_out\n");
			fprintf(fp, ");\n\n");
			fprintf(fp, "endmodule\n\n");
			
			fprintf(fp, "/////////////////////////////////////////////////////\n");
			fprintf(fp, "///////////////////// ff /////////////////////////\n");
			fprintf(fp, "/////////////////////////////////////////////////////\n");
			fprintf(fp, "module ff ( input D, input clk, output reg Q );\n\n");
			fprintf(fp, "always @ (posedge clk) begin\n\tQ <= D;\nend\n\n");
			fprintf(fp, "endmodule\n\n");
			
			num_input = 6;
			
			fprintf(fp, "/////////////////////////////////////////////////////\n");
			fprintf(fp, "/////////////////////// lut /////////////////////////\n");
			fprintf(fp, "/////////////////////////////////////////////////////\n");
			fprintf(fp, "module lut%d ( input [%d:0]config_in, input config_mode, input [%d:0]in, output reg out );\n\n", num_input, (int)pow(2, num_input)-1, num_input-1);	
			fprintf(fp, "wire [%d:0]in_flip;\n", num_input-1);
			fprintf(fp, "assign in_flip = {");
			for (j=0; j<num_input; j++) {
				fprintf(fp, "in[%d]", j);
				if (j!= num_input-1) fprintf(fp, ", ");
			}			
			fprintf(fp, "};\n\n");
			fprintf(fp, "always @ (*) begin\n");			
			fprintf(fp, "\tif (config_mode) begin\n");
			fprintf(fp, "\t\tout = 1'b1;\n");
			fprintf(fp, "\tend else begin\n");
			fprintf(fp, "\t\tcase(in_flip)\n");
			for (j=0; j<(int)pow(2, num_input); j++) {
				fprintf(fp, "\t\t\t%d'd%d: out = config_in[%d];\n", num_input, j, j);
			}		
			fprintf(fp, "\t\tendcase\n\tend\nend\n\n");					
			fprintf(fp, "endmodule\n\n");*/
		
			
			return 67;
		}

		//////////////////////////////////////////////////////
		// Bottom of the tree: primitives
		//	- LUT is recognized by having a mode called "wire"
		//	- FF is recognized by having a blif_model ".latch"
		//	- IO is recognized by having child with a blif_model ".input or .output"
		//////////////////////////////////////////////////////
		
		for (i=0; i<pb_graph_node->pb_type->num_modes; i++) {
			if (strcmp(pb_graph_node->pb_type->modes[i].name, "wire")==0) {
			num_input = pb_graph_node->pb_type->num_input_pins;
			
			/*fprintf(fp, "/////////////////////////////////////////////////////\n");
			fprintf(fp, "/////////////////////// lut /////////////////////////\n");
			fprintf(fp, "/////////////////////////////////////////////////////\n");
	
			fprintf(fp, "module %s ( input [%d:0]config_in, input config_mode, input [%d:0]in, output reg out );\n\n", pb_graph_node->pb_type->name, (int)pow(2, num_input)-1, num_input-1);	
			fprintf(fp, "wire [%d:0]in_flip;\n", num_input-1);
			fprintf(fp, "assign in_flip = {");
			for (j=0; j<num_input; j++) {
				fprintf(fp, "in[%d]", j);
				if (j!= num_input-1) fprintf(fp, ", ");
			}			
			fprintf(fp, "};\n\n");
			fprintf(fp, "always @ (*) begin\n");			
			fprintf(fp, "\tif (config_mode) begin\n");
			fprintf(fp, "\t\tout = 1'b1;\n");
			fprintf(fp, "\tend else begin\n");
			fprintf(fp, "\t\tcase(in_flip)\n");
			for (j=0; j<(int)pow(2, num_input); j++) {
				fprintf(fp, "\t\t\t%d'd%d: out = config_in[%d];\n", num_input, j, j);
			}		
			fprintf(fp, "\t\tendcase\n\tend\nend\n\n");					
			fprintf(fp, "endmodule\n\n");*/
		
			return (int)pow(2, num_input); // 6-input LUT requires 64 configuration bits	
		} else if (pb_graph_node->child_pb_graph_nodes[i][0][0].pb_type->blif_model != NULL && \
				(strcmp(pb_graph_node->child_pb_graph_nodes[i][0][0].pb_type->blif_model, ".input")==0 || \
				strcmp(pb_graph_node->child_pb_graph_nodes[i][0][0].pb_type->blif_model, ".output")==0)) {
			fprintf(fp, "/////////////////////////////////////////////////////\n");
			fprintf(fp, "///////////////////// io /////////////////////////\n");
			fprintf(fp, "/////////////////////////////////////////////////////\n");
			fprintf(fp, "module io (\n");

			flag_first = 0;
			pb_graph_pins = pb_graph_node->input_pins;
			for (i = 0; i < pb_graph_node->num_input_ports; i++) {
				if (flag_first == 0) flag_first = 1;
				else fprintf(fp, ",\n");
				port = pb_graph_pins[i][0].port;
				fprintf(fp, "\tinput [%d:0]%s", capacity*port->num_pins-1, port->name);
			}
			pb_graph_pins = pb_graph_node->output_pins;
			for (i = 0; i < pb_graph_node->num_output_ports; i++) {
				if (flag_first == 0) flag_first = 1;
				else fprintf(fp, ",\n");
				port = pb_graph_pins[i][0].port;
				fprintf(fp, "\toutput [%d:0]%s", capacity*port->num_pins-1, port->name);
			}
			fprintf(fp, ",\n\tinout [%d:0]%s_ext", capacity-1, pb_graph_node->pb_type->name);	
			fprintf(fp, ",\n\tinput [%d:0]config_in", capacity-1);	
			fprintf(fp, ",\n\tinput config_rst");
			fprintf(fp, "\n);\n\n");

			pb_graph_pins = pb_graph_node->input_pins;
			for (i = 0; i < pb_graph_node->num_input_ports; i++) {
				port = pb_graph_pins[i][0].port;
				for (j=0; j<capacity; j++) {
					fprintf(fp, "assign %s_ext[%d] = config_rst?1'bz:(config_in[%d]?1'bz:%s[%d]);\n", \
						pb_graph_node->pb_type->name, j, j, port->name, j);	
				}
			}
			fprintf(fp, "\n");
			pb_graph_pins = pb_graph_node->output_pins;
			for (i = 0; i < pb_graph_node->num_output_ports; i++) {
				port = pb_graph_pins[i][0].port;
				for (j=0; j<capacity; j++) {
					fprintf(fp, "assign %s[%d] = config_rst?1'bz:(config_in[%d]?%s_ext[%d]:1'bz);\n", \
						port->name, j, j, pb_graph_node->pb_type->name, j);	
				}
			}
			fprintf(fp, "\n");
			fprintf(fp, "endmodule\n\n");
			return capacity;
		}
	}
	
	if (pb_graph_node->pb_type->blif_model!= NULL && strcmp(pb_graph_node->pb_type->blif_model, ".latch")==0) {
		/*fprintf(fp, "/////////////////////////////////////////////////////\n");
		fprintf(fp, "///////////////////// ff /////////////////////////\n");
		fprintf(fp, "/////////////////////////////////////////////////////\n");
		fprintf(fp, "module ff ( input D, input clk, output reg Q );\n\n");
		fprintf(fp, "always @ (posedge clk) begin\n\tQ <= D;\nend\n\n");
		fprintf(fp, "endmodule\n\n");
		*/
		return 0; // ff requires 0 configuration bits
	}

	//////////////////////////////////////////////////////
	// Recursively go down to bottom of list
	// - keep track of previous configuration bits
	//////////////////////////////////////////////////////
	n_config_prev_total = 0; 
	n_config_prev_per_child = (int**)malloc(pb_graph_node->pb_type->num_modes*sizeof(int*));
	i=0;
	//for (i = 0; i < pb_graph_node->pb_type->num_modes; i++) {
	n_config_prev_per_child[i] = (int*)malloc(pb_graph_node->pb_type->modes[i].num_pb_type_children*sizeof(int));
	for (j = 0; j < pb_graph_node->pb_type->modes[i].num_pb_type_children; j++) {
		n_config_prev_per_child[i][j] = pb_graph_node->pb_type->modes[i].pb_type_children[j].num_pb*\
			dump_pb_rec_verilog(&pb_graph_node->child_pb_graph_nodes[i][j][0], \
				fp, capacity, mux_max_size);
		n_config_prev_total+=n_config_prev_per_child[i][j];
	}

	//////////////////////////////////////////////////////
	// Figure out config bit count
	// - repeat but need this info before module declaration
	//////////////////////////////////////////////////////
	n_config = 0;
	i = 0;
	int mux_size = 0;
	//for (i = 0; i < pb_graph_node->pb_type->num_modes; i++) {
	for (j = 0; j < pb_graph_node->pb_type->modes[i].num_pb_type_children; j++) {
		for (k = 0; k< pb_graph_node->pb_type->modes[i].pb_type_children[j].num_pb; k++) {
			for (l = 0; l < pb_graph_node->child_pb_graph_nodes[i][j][k].num_clock_ports; l++) {
				port = pb_graph_node->child_pb_graph_nodes[i][j][k].clock_pins[l][0].port;		
				for (int h = 0; h < port->num_pins; h++) {
					if (pb_graph_node->child_pb_graph_nodes[i][j][k].clock_pins[l][h].num_input_edges > 1) {
						mux_size = (int)ceil(((double)log(pb_graph_node->child_pb_graph_nodes[i][j][k].input_pins[l][h].num_input_edges)/log(2)));
						if (mux_size > 3) mux_size+=2;
						n_config += mux_size;
					}
				}
			}
			for (l = 0; l < pb_graph_node->child_pb_graph_nodes[i][j][k].num_input_ports; l++) {
				port = pb_graph_node->child_pb_graph_nodes[i][j][k].input_pins[l][0].port;		
				for (int h = 0; h < port->num_pins; h++) {
					if (pb_graph_node->child_pb_graph_nodes[i][j][k].input_pins[l][h].num_input_edges > 1) {
						mux_size = (int)ceil(((double)log(pb_graph_node->child_pb_graph_nodes[i][j][k].input_pins[l][h].num_input_edges+1)/log(2)));
						if (mux_size > 3) mux_size+=2;
						n_config += mux_size;
					}
				}
			}
		}
	}

	for (l = 0; l < pb_graph_node->num_output_ports; l++) {
		port = pb_graph_node->output_pins[l][0].port;		
		for (int h = 0; h < port->num_pins; h++) {
			if (pb_graph_node->output_pins[l][h].num_input_edges > 1) {
				mux_size = (int)ceil(((double)log(pb_graph_node->output_pins[l][h].num_input_edges)/log(2)));
				if (mux_size > 3) mux_size+=2;
				n_config += mux_size;
			}
		}
	}

	printf("%d?\n", n_config);
	
	//////////////////////////////////////////////////////
	// Declare modules
	//////////////////////////////////////////////////////
	fprintf(fp, "/////////////////////////////////////////////////////\n");
	fprintf(fp, "///////////////////// %s /////////////////////////\n", pb_graph_node->pb_type->name);
	fprintf(fp, "/////////////////////////////////////////////////////\n");
	fprintf(fp, "module %s (\n", pb_graph_node->pb_type->name);
	
	//////////////////////////////////////////////////////
	// Declare input/output/clock pins
	//////////////////////////////////////////////////////
	flag_first = 0;

	pb_graph_pins = pb_graph_node->input_pins;
	for (i = 0; i < pb_graph_node->num_input_ports; i++) {
		if (flag_first == 0) flag_first = 1;
		else fprintf(fp, ",\n");
		port = pb_graph_pins[i][0].port;
		fprintf(fp, "\tinput [%d:0]%s", capacity*port->num_pins-1, port->name);
	}
	pb_graph_pins = pb_graph_node->clock_pins;
	for (i = 0; i < pb_graph_node->num_clock_ports; i++) {
		if (flag_first == 0) flag_first = 1;
		else fprintf(fp, ",\n");
		port = pb_graph_pins[i][0].port;
		fprintf(fp, "\tinput [%d:0]%s,\n", capacity*port->num_pins-1, port->name);
		fprintf(fp, "\tinput reset");
	}
	pb_graph_pins = pb_graph_node->output_pins;
	for (i = 0; i < pb_graph_node->num_output_ports; i++) {
		if (flag_first == 0) flag_first = 1;
		else fprintf(fp, ",\n");
		port = pb_graph_pins[i][0].port;
		fprintf(fp, "\toutput [%d:0]%s", capacity*port->num_pins-1, port->name);
	}
	//determine if configuration bits are needed
	//check children + itself has 0
	if (n_config+n_config_prev_total != 0) {
		if (flag_first == 0) flag_first = 1;
		else fprintf(fp, ",\n");
		fprintf(fp, "\tinput [%d:0]config_in,\n", (n_config+n_config_prev_total)-1);
		fprintf(fp, "\tinput config_rst\n");
	}
	fprintf(fp, "\n);\n\n");
	
	//////////////////////////////////////////////////////
	// Inside of the module
	//////////////////////////////////////////////////////
	flag_first = 0;
	i = 0;
	n_config_used = (int*)calloc(1, sizeof(int));
	
	// CROSSBAR
	fprintf(fp, "wire ground;\n"); //GND FOR UNUSED SIGNAL
	for (j = 0; j < pb_graph_node->pb_type->modes[0].num_pb_type_children; j++) {
		for (k = 0;	k< pb_graph_node->pb_type->modes[i].pb_type_children[j].num_pb;	k++) {

			fprintf(fp, "////////child (%d,%d,%d)////////\n", i, j, k);
			
			//////////////////////////////////////////////////////
			// Connect module ports to instantiated blocks
			//////////////////////////////////////////////////////
			for (l = 0;  l< pb_graph_node->child_pb_graph_nodes[i][j][k].num_input_ports; l++) {
				fprintf(fp, "wire [%d:0]%s_%s_%d;", \
					capacity*pb_graph_node->child_pb_graph_nodes[i][j][k].input_pins[l][0].port->num_pins-1,\
					pb_graph_node->child_pb_graph_nodes[i][j][k].input_pins[l][0].port->name,\
					pb_graph_node->child_pb_graph_nodes[i][j][k].input_pins[l][0].parent_node->pb_type->name,\
					pb_graph_node->child_pb_graph_nodes[i][j][k].input_pins[l][0].parent_node->placement_index);
				fprintf(fp, "//input to child\n");
			}
			for (l = 0;  l< pb_graph_node->child_pb_graph_nodes[i][j][k].num_clock_ports; l++) {
				fprintf(fp, "wire [%d:0]%s_%s_%d;", \
					capacity*pb_graph_node->child_pb_graph_nodes[i][j][k].clock_pins[l][0].port->num_pins-1,\
					pb_graph_node->child_pb_graph_nodes[i][j][k].clock_pins[l][0].port->name,\
					pb_graph_node->child_pb_graph_nodes[i][j][k].clock_pins[l][0].parent_node->pb_type->name,\
					pb_graph_node->child_pb_graph_nodes[i][j][k].clock_pins[l][0].parent_node->placement_index);
				fprintf(fp, "//clock to child\n");
			}
			
			for (l = 0;  l< pb_graph_node->child_pb_graph_nodes[i][j][k].num_output_ports; l++) {
				fprintf(fp, "wire [%d:0]%s_%s_%d;", \
					capacity*pb_graph_node->child_pb_graph_nodes[i][j][k].output_pins[l][0].port->num_pins-1,\
					pb_graph_node->child_pb_graph_nodes[i][j][k].output_pins[l][0].port->name,\
					pb_graph_node->child_pb_graph_nodes[i][j][k].output_pins[l][0].parent_node->pb_type->name,\
					pb_graph_node->child_pb_graph_nodes[i][j][k].output_pins[l][0].parent_node->placement_index);
				fprintf(fp, "//output from child\n");
			}
		}
		fprintf(fp, " \n");
	}
	
	for (j = 0; j < pb_graph_node->pb_type->modes[i].num_pb_type_children; j++) {
		for (k = 0;	k< pb_graph_node->pb_type->modes[i].pb_type_children[j].num_pb;	k++) {

			dump_pb_pins_verilog(pb_graph_node->child_pb_graph_nodes[i][j][k].input_pins, \
				pb_graph_node->child_pb_graph_nodes[i][j][k].num_input_ports, n_config_used, fp, mux_max_size);
			dump_pb_pins_verilog(pb_graph_node->child_pb_graph_nodes[i][j][k].clock_pins, \
				pb_graph_node->child_pb_graph_nodes[i][j][k].num_clock_ports, n_config_used, fp, mux_max_size);
			fprintf(fp, " \n");

			//////////////////////////////////////////////////////
			// Instantiate children blocks
			//////////////////////////////////////////////////////
			flag_first = 0;
			fprintf(fp, "%s %s_%d (", 
				pb_graph_node->child_pb_graph_nodes[i][j][k].pb_type->name,
				pb_graph_node->child_pb_graph_nodes[i][j][k].pb_type->name, k);
			pb_graph_pins = pb_graph_node->clock_pins;
			for (l = 0;  l< pb_graph_node->child_pb_graph_nodes[i][j][k].num_clock_ports; l++) {
				if (flag_first == 0) {flag_first = 1;}
				else fprintf(fp, ",");					
				fprintf(fp, " .%s(%s_%s_%d)", 
					pb_graph_node->child_pb_graph_nodes[i][j][k].clock_pins[l][0].port->name, 
					pb_graph_node->child_pb_graph_nodes[i][j][k].clock_pins[l][0].port->name,
					pb_graph_node->child_pb_graph_nodes[i][j][k].clock_pins[l][0].parent_node->pb_type->name,
					pb_graph_node->child_pb_graph_nodes[i][j][k].clock_pins[l][0].parent_node->placement_index);
				fprintf(fp, ", .reset(reset)");
			}
			for (l = 0;  l< pb_graph_node->child_pb_graph_nodes[i][j][k].num_input_ports; l++) {
				if (flag_first == 0) {flag_first = 1;}
				else fprintf(fp, ",");
				fprintf(fp, " .%s(%s_%s_%d)", 
					pb_graph_node->child_pb_graph_nodes[i][j][k].input_pins[l][0].port->name, 
					pb_graph_node->child_pb_graph_nodes[i][j][k].input_pins[l][0].port->name,
					pb_graph_node->child_pb_graph_nodes[i][j][k].input_pins[l][0].parent_node->pb_type->name,
					pb_graph_node->child_pb_graph_nodes[i][j][k].input_pins[l][0].parent_node->placement_index);
			}
			for (l = 0;  l< pb_graph_node->child_pb_graph_nodes[i][j][k].num_output_ports; l++) {
				if (flag_first == 0) {flag_first = 1;}
				else fprintf(fp, ",");
				fprintf(fp, " .%s(%s_%s_%d)", 
					pb_graph_node->child_pb_graph_nodes[i][j][k].output_pins[l][0].port->name, 
					pb_graph_node->child_pb_graph_nodes[i][j][k].output_pins[l][0].port->name,
					pb_graph_node->child_pb_graph_nodes[i][j][k].output_pins[l][0].parent_node->pb_type->name,
					pb_graph_node->child_pb_graph_nodes[i][j][k].output_pins[l][0].parent_node->placement_index);
			}
			//determine if configuration bits are needed
			if (n_config_prev_per_child[i][j] != 0) { 
				int num_pb = pb_graph_node->pb_type->modes[i].pb_type_children[j].num_pb;
				fprintf(fp, ", .config_in(config_in[%d:%d]), .config_rst(config_rst) ); //block instantiation\n", \
					n_config_used[0]+n_config_prev_per_child[i][j]/num_pb-1, n_config_used[0]);
				n_config_used[0] += n_config_prev_per_child[i][j]/num_pb;
			}
			else fprintf(fp, " );\n");
			fprintf(fp, "\n");
		}
	}

	
	fprintf(fp, "//child output to block output\n");
	dump_pb_pins_verilog(pb_graph_node->output_pins,
		pb_graph_node->num_output_ports, n_config_used, fp, mux_max_size);
	fprintf(fp, "\n");
	
	fprintf(fp, "assign ground = 1'b0;\n");
	fprintf(fp, "\n");
	
	fprintf(fp, "endmodule\n\n\n");
	
	return n_config_used[0];
}

void dump_pb_pins_verilog(INP t_pb_graph_pin **pb_graph_pins, INP int num_ports,
		INP int* n_config_used, INP FILE * fp, int* mux_max_size) {
	
	int i, j, k, m;
	int fan_in, mux_size;
	t_port *port, *edge_port;
	
	for (i = 0; i < num_ports; i++) {
		port = pb_graph_pins[i][0].port;
		for (j = 0; j < port->num_pins; j++) {
			assert(j == pb_graph_pins[i][j].pin_number);
			assert(pb_graph_pins[i][j].port == port);
			
			fan_in = pb_graph_pins[i][j].num_input_edges; 
			if (mux_max_size[0] < fan_in-1) mux_max_size[0] = fan_in;
			for (k = 0; k < fan_in; k++) {
				//first input edge, either create mux or use assign
				if (k == 0) { 
					if (fan_in > 1) {
						if (port->type == OUT_PORT) fprintf(fp, "mux%d mux_%d ( .in({", fan_in, n_config_used[0]);
						else fprintf(fp, "mux%d mux_%d ( .in({", fan_in+1, n_config_used[0]);
					} else if (port->type == OUT_PORT) {
						fprintf(fp, "assign %s[%d] = ",
							pb_graph_pins[i][j].port->name, j);
					} else {
						fprintf(fp, "assign %s_%s_%d[%d] = ",
							pb_graph_pins[i][j].port->name,
							pb_graph_pins[i][j].parent_node->pb_type->name,
							pb_graph_pins[i][j].parent_node->placement_index, j);
					}
				}
				for (m = 0; m < pb_graph_pins[i][j].input_edges[k]->num_input_pins; m++) {
					edge_port = pb_graph_pins[i][j].input_edges[k]->input_pins[m]->port;
					if (edge_port->type == OUT_PORT || strcmp(pb_graph_pins[i][j].input_edges[k]->input_pins[m]->parent_node->pb_type->name, pb_graph_pins[i][j].parent_node->pb_type->name)==0) {
						fprintf(fp, "%s_%s_%d[%d]",
							pb_graph_pins[i][j].input_edges[k]->input_pins[m]->port->name,
							pb_graph_pins[i][j].input_edges[k]->input_pins[m]->parent_node->pb_type->name,
							pb_graph_pins[i][j].input_edges[k]->input_pins[m]->parent_node->placement_index,
							pb_graph_pins[i][j].input_edges[k]->input_pins[m]->pin_number);
					} else {
						fprintf(fp, "%s[%d]",
							pb_graph_pins[i][j].input_edges[k]->input_pins[m]->port->name,
							pb_graph_pins[i][j].input_edges[k]->input_pins[m]->pin_number);
						
					}
				}
				//last input edge, close mux or assign
				if (k == fan_in-1) { 
					if (fan_in > 1) {
						if (port->type == OUT_PORT) {
							mux_size = (int)ceil(((double)log(fan_in)/log(2))); //no need for GND for outputs
							if (mux_size > 3) mux_size = mux_size+2;
							fprintf(fp, "}), .config_in(config_in[%d:%d]), .config_rst(config_rst), .out(%s[%d]) );\n",
								mux_size+n_config_used[0]-1, n_config_used[0],
								pb_graph_pins[i][j].port->name, j);
							
						} else { //GND signal for unused pins, needed for config calculations and etc.
							mux_size = (int)ceil(((double)log(fan_in+1)/log(2))); //+1 because of GND
							if (mux_size > 3) mux_size = mux_size+2;
							fprintf(fp, ", ground}), .config_in(config_in[%d:%d]), .config_rst(config_rst), .out(%s_%s_%d[%d]) );\n", 
								mux_size+n_config_used[0]-1, n_config_used[0],
								pb_graph_pins[i][j].port->name,
								pb_graph_pins[i][j].parent_node->pb_type->name,
								pb_graph_pins[i][j].parent_node->placement_index, j);
						}
						n_config_used[0] += mux_size;
					} else fprintf(fp, ";\n");
				} else fprintf(fp, ", ");
			}
		} 
	}
}

/////////////////////////////////////////////////////////////////////	
// dump_rr_graph_as_verilog
//	- this function dumps the rr_graph as the top level module of FPGA.
//	- this function uses the grid to spit out and connect up all the blocks within top level.
//	- must be run after dump_pb_graph to collect correct number of configuration bits to connect
//		to the blocks in top level.
//
// 	file_name: top level module will be stored to this file.
//	type_config_bits: contains the configuration bits required for each type.
//		indexed by the type_descriptor index
//	max_mux_size: keeps track of the biggest mux seen.
// 		mux of various sizes from 0 to this number will be created.
//		generation is quick and unused muxes are not included after synthesis.
//
/////////////////////////////////////////////////////////////////////
void dump_rr_graph_as_verilog (INP const char *file_name, int* type_config_bits, int* max_mux_size) {
	
	static const char *name_type[] = { "SOURCE", "SINK", "IPIN", "OPIN",
			"CHANX", "CHANY", "INTRA_CLUSTER_EDGE" };
	static const char *direction_name[] = { "OPEN", "INC_DIRECTION",
			"DEC_DIRECTION", "BI_DIRECTION" };
			
	FILE *fp;
	FILE *fp_config;
	FILE *fp_sdc;
	FILE *fp_floorplan;
	FILE *fp_config_helper;
	
	int inode, iconn, icap;
	
	int config_size, pre_config_array_size;
	int config_array_size = 0; //used to keep track of all the configuration @ top level
	char* config_array;
	
	t_rr_type rr_type;
	char* t_name;
	int t_cap;

	t_port *port;
	t_pb_graph_node *pb_graph_node = NULL;
	
	fp = my_fopen(file_name, "w", 0);
	fp_config = my_fopen("FPGA/bitgen_report.txt", "w", 0);
	fp_config_helper = my_fopen("FPGA/fpga_config.txt", "w", 0);
	fp_sdc = my_fopen("FPGA/fpga_top.sdc", "w", 0);
	fp_floorplan = my_fopen("FPGA/floorplan.txt", "w", 0);
	
	int i, j, k, l, m;
	
	/////////////////////////////////////////////////////////////////////	
	// manage data for easy use
	//
	// 	node_fan_in[0...num_rr_nodes][0...fan_in]: Used to keep track of all
	//		the edges that connect to it. This is needed because only the opposite
	//		information (fan_out) is stored in rr_node). 
	//		This allows the top level mux creations.
	//	node_fan_in_index[0...num_rr_nodes]: Used by node_fan_in to keep track of 
	// 		how many edges have been found currently.
	//		Only used to fill node_fan_in.
	//
	//	node_trace: Used to keep track of all the paths
	// 		taken by the router in the top level mux.
	//		node_trace[0 ... num_rr_nodes]
	//	node_net_num: Used to keep track of all the paths
	// 		taken by the router's net number.
	//
	//	x_pin_sort_by_grid[0...nx+2][0...ny+2][0...capacity][0...num_x_ports][0...num_x_pins]: 
	//		used to assign correct rr_graph nodes to the clb inputs.
	/////////////////////////////////////////////////////////////////////
	
	////////////////////// INITIALIZE //////////////////////
	int***** clock_pin_sort_by_grid = (int*****)malloc((nx+2)*sizeof(int****));
	int***** input_pin_sort_by_grid = (int*****)malloc((nx+2)*sizeof(int****));
	int***** output_pin_sort_by_grid = (int*****)malloc((nx+2)*sizeof(int****));
	
	int** node_fan_in = (int**)malloc((num_rr_nodes)*sizeof(int*));
	int* node_fan_in_index = (int*)malloc((num_rr_nodes)*sizeof(int));
	double* node_x = (double*)malloc(num_rr_nodes*sizeof(double));
	double* node_y = (double*)malloc(num_rr_nodes*sizeof(double));
	int* cb_sb = (int*)malloc(num_rr_nodes*sizeof(int));
	int* long_short = (int*)malloc(num_rr_nodes*sizeof(int));
	int* node_len = (int*)malloc(num_rr_nodes*sizeof(int));	

	int* node_trace = (int*)malloc(num_rr_nodes*sizeof(int));
	int* node_net_num = (int*)malloc(num_rr_nodes*sizeof(int));
		
	for (i=0; i<nx+2; i++) {
		clock_pin_sort_by_grid[i] = (int****)malloc((ny+2)*sizeof(int***));
		input_pin_sort_by_grid[i] = (int****)malloc((ny+2)*sizeof(int***));
		output_pin_sort_by_grid[i] = (int****)malloc((ny+2)*sizeof(int***));
		
		for (j=0; j<ny+2; j++) {
			pb_graph_node = grid[i][j].type->pb_graph_head;
			if (grid[i][j].type == EMPTY_TYPE) continue;
			
			clock_pin_sort_by_grid[i][j] = (int***)malloc(grid[i][j].type->capacity*sizeof(int**));
			input_pin_sort_by_grid[i][j] = (int***)malloc(grid[i][j].type->capacity*sizeof(int**));
			output_pin_sort_by_grid[i][j] = (int***)malloc(grid[i][j].type->capacity*sizeof(int**));
			
			for (k=0; k<grid[i][j].type->capacity; k++) {
				clock_pin_sort_by_grid[i][j][k] = (int**)malloc(pb_graph_node->num_clock_ports*sizeof(int*));
				input_pin_sort_by_grid[i][j][k] = (int**)malloc(pb_graph_node->num_input_ports*sizeof(int*));
				output_pin_sort_by_grid[i][j][k] = (int**)malloc(pb_graph_node->num_output_ports*sizeof(int*));
				
				for (l=0; l<pb_graph_node->num_clock_ports; l++)
					clock_pin_sort_by_grid[i][j][k][l] = (int*)malloc(pb_graph_node->num_clock_pins[l]*sizeof(int));
				for (l=0; l<pb_graph_node->num_input_ports; l++)
					input_pin_sort_by_grid[i][j][k][l] = (int*)malloc(pb_graph_node->num_input_pins[l]*sizeof(int));
				for (l=0; l<pb_graph_node->num_output_ports; l++)
					output_pin_sort_by_grid[i][j][k][l] = (int*)malloc(pb_graph_node->num_output_pins[l]*sizeof(int));
			}
		}
	}
	
	for (inode = 0; inode < num_rr_nodes; inode++) {
		node_fan_in[inode] = (int*)malloc((rr_node[inode].fan_in)*sizeof(int));
		node_fan_in_index[inode] = rr_node[inode].fan_in;
		node_x[inode] = -1;
		node_y[inode] = -1;
		cb_sb[inode] = -1;
		long_short[inode] = -1;
		node_len[inode] = -1;
		node_trace[inode] = -1;
		node_net_num[inode] = -1;
	}
	
	////////////////////// START FILLING IN DATA STRUCTURES //////////////////////
	t_pb_graph_pin *current_pin;
	int max_len = 14;
	for (inode = 0; inode < num_rr_nodes; inode++) {
		i = rr_node[inode].xlow;
		j = rr_node[inode].ylow;
		k = rr_node[inode].z;
		rr_type = rr_node[inode].type;
		
		//IPIN or OPIN - Connection Blocks
		if (name_type[rr_type] == name_type[2]||name_type[rr_type] == name_type[3]) {			
			node_x[inode] = rr_node[inode].xlow;
			node_y[inode] = rr_node[inode].ylow;
			cb_sb[inode] = 0;
			//printf("pin x, y = %d %d\n", rr_node[inode].xlow, rr_node[inode].ylow);
		}
		
		//x dir
		if (name_type[rr_type] == name_type[4]) {
		//increment, low is driven by mux
			if (direction_name[rr_node[inode].direction + 1]==direction_name[1]) {				
				node_x[inode] = rr_node[inode].xlow-1;
				node_y[inode] = rr_node[inode].ylow;
				node_len[inode] = rr_node[inode].xhigh - rr_node[inode].xlow + 1;
				cb_sb[inode] = 1;
				//printf("chan x, y = %d %d\n", rr_node[inode].xlow, rr_node[inode].ylow);
			} else if (direction_name[rr_node[inode].direction + 1]==direction_name[2]) {
				node_x[inode] = rr_node[inode].xhigh;
				node_y[inode] = rr_node[inode].yhigh;
				node_len[inode] = rr_node[inode].xlow - rr_node[inode].xhigh + 1;
				cb_sb[inode] = 1;
				//printf("chan x, y = %d %d\n", rr_node[inode].xhigh, rr_node[inode].yhigh);
			}
				node_len[inode] = rr_node[inode].xhigh - rr_node[inode].xlow + 1;
			//check if its long or short
			if (rr_node[inode].xhigh - rr_node[inode].xlow >= max_len) {
				//max_len = rr_node[inode].xhigh - rr_node[inode].xlow;
				long_short[inode] = 0;
				if (rr_node[inode].num_edges<10) {
					//printf("long but small = %d %d\n", inode, rr_node[inode].num_edges);
				}
			} else {
				long_short[inode] = 1;
				if (rr_node[inode].num_edges>15) {
					//printf("short but big = %d %d\n", inode, rr_node[inode].num_edges);
				}
			}
		} else if (name_type[rr_type] == name_type[5]) {
		//increment, low is driven by mux
			if (direction_name[rr_node[inode].direction + 1]==direction_name[1]) {				
				node_x[inode] = rr_node[inode].xlow;
				node_y[inode] = rr_node[inode].ylow-1;
				node_len[inode] = rr_node[inode].yhigh - rr_node[inode].ylow;
				cb_sb[inode] = 1;
				//printf("chan x, y = %d %d\n", rr_node[inode].xlow, rr_node[inode].ylow);
			} else if (direction_name[rr_node[inode].direction + 1]==direction_name[2]) {
				node_x[inode] = rr_node[inode].xhigh;
				node_y[inode] = rr_node[inode].yhigh;
				node_len[inode] = rr_node[inode].ylow - rr_node[inode].yhigh;
				cb_sb[inode] = 1;
				//printf("chan x, y = %d %d\n", rr_node[inode].xhigh, rr_node[inode].yhigh);
			}
				node_len[inode] = rr_node[inode].yhigh - rr_node[inode].ylow + 1;
			//check if its long or short
			if (rr_node[inode].yhigh - rr_node[inode].ylow >= max_len) {
				//max_len = rr_node[inode].yhigh - rr_node[inode].ylow;
				long_short[inode] = 0;
				if (rr_node[inode].num_edges<10) {
				//	printf("long but small = %d %d\n", inode, rr_node[inode].num_edges);
				}
			} else {
				long_short[inode] = 1;
				if (rr_node[inode].num_edges>15) {
				//	printf("short but big = %d %d\n", inode, rr_node[inode].num_edges);
				}
			}				
		}

		//given the pb_graph_node and the ptc_num, pin info is provided
		current_pin = get_pb_graph_node_pin_from_pb_graph_node\
			(grid[i][j].type->pb_graph_head, rr_node[inode].ptc_num);
		port = current_pin->port;
		
		//only the IPIN and OPINs are relevant to pb_graph_node pins
		if (name_type[rr_type] == name_type[2] || name_type[rr_type] == name_type[3]) {	
			if (port->is_clock)
				clock_pin_sort_by_grid[i][j][k][port->port_index_by_type][current_pin->pin_number] = inode;
			else if (port->type == IN_PORT) {
				input_pin_sort_by_grid[i][j][k][port->port_index_by_type][current_pin->pin_number] = inode;
			} else
				output_pin_sort_by_grid[i][j][k][port->port_index_by_type][current_pin->pin_number] = inode;
		}
		
		//since rr_node[inode] contains who it's driving,
		//for each connection, note who it's driven by (current inode).
		for (iconn = 0; iconn<rr_node[inode].num_edges; iconn++) {
			node_fan_in[rr_node[inode].edges[iconn]][node_fan_in_index[rr_node[inode].edges[iconn]]-1] = inode;
			node_fan_in_index[rr_node[inode].edges[iconn]]--;
		}
	}
	//node_fan_in_index no longer used
	free(node_fan_in_index);
	
	// go through the trace to keep track of connections
	// used for bitstream generation!
	struct s_trace *tptr;
	for (i=0; i<num_nets; i++) {
		tptr = trace_head[i];
		while (tptr != NULL && tptr->next != NULL) {
			//printf("%d -> ", tptr->index);
			rr_type = rr_node[tptr->index].type;
			if (name_type[rr_type] != name_type[1]) {				
				node_trace[tptr->next->index] = tptr->index;
				node_net_num[tptr->next->index] = clb_to_vpack_net_mapping[i]; //match nets with block nets
			}
			tptr = tptr->next;
		}
	}
	
	////////////////////// PRINT GROUPS //////////////////////
	for (i=0; i<nx+2; i++) {
		for (j=0; j<ny+2; j++) {
			fprintf(fp_floorplan, "createInstGroup area_%d_%d\n", i, j);
		}
	}
	for (i=0; i<nx+1; i++) {
		for (j=0; j<ny+1; j++) {
			fprintf(fp_floorplan, "createInstGroup sb_%d_%d\n", i, j);
		}
	}
	for (i=0; i<nx+2; i++) {
		for (j=0; j<ny+2; j++) {
			fprintf(fp_floorplan, "setObjFPlanBox Group area_%d_%d [expr $w*%d] [expr $w*%d] [expr $w*(%d+1)] [expr $w*(%d+1)]\n", i, j, i, j, i, j);
		}
	}
	for (i=0; i<nx+1; i++) {
		for (j=0; j<ny+1; j++) {
			fprintf(fp_floorplan, "setObjFPlanBox Group sb_%d_%d [expr $w*(%d+0.5)] [expr $w*(%d+0.5)] [expr $w*(%d+1.5)] [expr $w*(%d+1.5)]\n", i, j, i, j, i, j);
		}
	}
	
	/////////////////////////////////////////////////////////////////////
	// create top module and top level inputs and outputs
	//	io has special handling: inout ports to be configred
	/////////////////////////////////////////////////////////////////////
	fprintf(fp, "`include \"FPGA/define.v\"\n\n");
	fprintf(fp, "module fpga_top (\n");
	fprintf(fp, "\tinput fpga_clk,\n");
	fprintf(fp, "\tinput fpga_rst,\n");
	for (i=0; i<nx+2; i++) {
		for (j=0; j<ny+2; j++) {
			t_name = grid[i][j].type->name;
			t_cap = grid[i][j].type->capacity;
			if (grid[i][j].type == IO_TYPE) {
				fprintf(fp, "\tinout [%d:0]%s_%d_%d_wire,\n", t_cap-1, t_name, i, j);
			}
		}
	}
	fprintf(fp, "\tinput config_rst,\n");
	fprintf(fp, "\tinput config_clk,\n");
	fprintf(fp, "\tinput config_in\n");
	fprintf(fp, ");\n\n");

	/////////////////////////////////////////////////////////////////////	
	// create each node as wires
	/////////////////////////////////////////////////////////////////////
	int ibuff;	
	for (inode = 0; inode < num_rr_nodes; inode++) {
		//printf("%d, ", node_len[inode]);
		rr_type = rr_node[inode].type;
		if (name_type[rr_type] != name_type[0] && name_type[rr_type] != name_type[1]) {
			fprintf(fp, "wire n%d; //%s %d (%d,%d) #%d\n", inode, name_type[rr_type], \
				node_len[inode], rr_node[inode].xlow, rr_node[inode].ylow, rr_node[inode].ptc_num);
			//fprintf(fp, "wire n%d_0;\n", inode);
			//if the wire length is greater than desired
			//divide it up into segments
			for (ibuff = 0; ibuff < (int)ceil(((double)node_len[inode]/buffer_freq)); ibuff++) {
				fprintf(fp, "wire n%d_%d;\n", inode, ibuff);
			}
				//if (direction_name[rr_node[inode].direction+1] == direction_name[1]) {
					for (ibuff = (int)ceil(((double)node_len[inode]/buffer_freq))-1; ibuff >= 1; ibuff--) {
						fprintf(fp, "buffer_wire buffer_%d_%d (.in(n%d_%d), .out(n%d_%d));\n", inode, ibuff, inode, ibuff-1, inode, ibuff);
					}
				//} else {
				//	for (ibuff = 0; ibuff < (int)ceil(((double)node_len[inode]/buffer_freq))-1; ibuff++) {
						//fprintf(fp, "assign n%d_%d = n%d_%d;\n", inode, ibuff, inode, ibuff+1);
				//		fprintf(fp, "buffer_wire buffer_%d_%d (.in(n%d_%d), .out(n%d_%d));\n", inode, ibuff, inode, ibuff+1, inode, ibuff);
				//	}
				//}
			
			//if (long_short[inode] == 0) fprintf(fp, "wire n%d_long; //%s (%d,%d) #%d\n", inode, name_type[rr_type], \
				rr_node[inode].xlow, rr_node[inode].ylow, rr_node[inode].ptc_num);
			//else fprintf(fp, "wire n%d; //%s (%d,%d) #%d\n", inode, name_type[rr_type], \
				rr_node[inode].xlow, rr_node[inode].ylow, rr_node[inode].ptc_num);
		}
	}
	fprintf(fp, "wire [`CONFIG_SIZE-1:0] config_chain;\n\n");
	
	printf("instantiation muxes\n");	
	/////////////////////////////////////////////////////////////////////	
	// instantiate muxes for all nodes with fan_in > 1
	//	configure the muxes by looking at the trace
	/////////////////////////////////////////////////////////////////////	
	int imux = 0; //indexes the muxes
	int mux_size = 0; //number of inputs to the mux (mux size)
	int config_value = -1; //value to configure the mux
	int buff_num = 0; 

	for (inode = 0; inode < num_rr_nodes; inode++) {
		//else printf("---------\nnode %d\n", inode);
		rr_type = rr_node[inode].type;
		mux_size = rr_node[inode].fan_in;
		config_value = -1;
		//SOURCE and SINK are not physical nodes
		if ((name_type[rr_type] != name_type[0] && name_type[rr_type] != name_type[1]) && mux_size > 1) {
			//if (node_len[inode]>buffer_freq) fprintf(fp, "mux%d_long mux_%d (.in({", mux_size, imux);	
			fprintf(fp, "mux%d mux_%d (.in({", mux_size, imux);	
			for (iconn=0; iconn<mux_size; iconn++) {

				if (name_type[rr_node[inode].type] == name_type[4]) { //output of mux is x direction
					if (name_type[rr_node[node_fan_in[inode][iconn]].type] == name_type[4]) { //connecting wire is x direction	
						if (direction_name[rr_node[node_fan_in[inode][iconn]].direction+1] == direction_name[1]) //incrementing direction
							buff_num = rr_node[inode].xlow - rr_node[node_fan_in[inode][iconn]].xlow - 1;
						else 
							//printf("SHOULD NOT HAPPEN\n");
							buff_num = rr_node[node_fan_in[inode][iconn]].xhigh - rr_node[inode].xhigh - 1;
					} else { //connecting wire is y direction	
						if (direction_name[rr_node[node_fan_in[inode][iconn]].direction+1] == direction_name[1]) //incrementing direction
							buff_num = rr_node[inode].ylow - rr_node[node_fan_in[inode][iconn]].ylow;
						else 
							buff_num = rr_node[node_fan_in[inode][iconn]].yhigh - rr_node[inode].ylow - 1;
					}
				} else if (name_type[rr_node[inode].type] == name_type[5]) { //output of mux is y direction
					if (name_type[rr_node[node_fan_in[inode][iconn]].type] == name_type[5]) { //connecting wire is y direction	
						if (direction_name[rr_node[node_fan_in[inode][iconn]].direction+1] == direction_name[1]) //incrementing direction
							buff_num = rr_node[inode].ylow - rr_node[node_fan_in[inode][iconn]].ylow - 1;
						else 
							buff_num = rr_node[node_fan_in[inode][iconn]].yhigh - rr_node[inode].yhigh - 1;
					} else { //connecing wire is in x direction
						if (direction_name[rr_node[node_fan_in[inode][iconn]].direction+1] == direction_name[1]) //incrementing direction
							buff_num = rr_node[inode].xlow - rr_node[node_fan_in[inode][iconn]].xlow;
						else 
							buff_num = rr_node[node_fan_in[inode][iconn]].xhigh - rr_node[inode].xlow - 1;
					} 
				} else { //output of mux is a input/output pin
					if (name_type[rr_node[node_fan_in[inode][iconn]].type] == name_type[5]) { //connecting wire is y direction	
						if (direction_name[rr_node[node_fan_in[inode][iconn]].direction+1] == direction_name[1]) //incrementing direction
							buff_num = rr_node[inode].ylow - rr_node[node_fan_in[inode][iconn]].ylow;
						else 
							buff_num = rr_node[node_fan_in[inode][iconn]].yhigh - rr_node[inode].yhigh;
					} else { //connecing wire is in y direction
						if (direction_name[rr_node[node_fan_in[inode][iconn]].direction+1] == direction_name[1]) //incrementing direction
							buff_num = rr_node[inode].xlow - rr_node[node_fan_in[inode][iconn]].xlow;
						else 
							buff_num = rr_node[node_fan_in[inode][iconn]].xhigh - rr_node[inode].xlow;
					}
				}
					//	printf("to node %d %d %d %d, from node %d %d %d %d, %d\n",\
							rr_node[inode].xlow,\
							rr_node[inode].xhigh,\
							rr_node[inode].ylow,\
							rr_node[inode].yhigh,\
							rr_node[node_fan_in[inode][iconn]].xlow,\
							rr_node[node_fan_in[inode][iconn]].xhigh,\
							rr_node[node_fan_in[inode][iconn]].ylow,\
							rr_node[node_fan_in[inode][iconn]].yhigh,\
							direction_name[rr_node[node_fan_in[inode][iconn]].direction+1] == direction_name[1]);
					/*if (name_type[rr_node[node_fan_in[inode][iconn]].type] == name_type[4]) { //XDIR
						//incrementing direction
						if (direction_name[rr_node[node_fan_in[inode][iconn]].direction+1] == direction_name[1])
							buff_num = (rr_node[inode].xlow - rr_node[node_fan_in[inode][iconn]].xlow) -1;
						else 
							buff_num = node_len[node_fan_in[inode][iconn]] - (rr_node[inode].xhigh - rr_node[node_fan_in[inode][iconn]].xlow) -1;
					} else if (name_type[rr_node[node_fan_in[inode][iconn]].type] == name_type[5]) { //YDIR
						if (direction_name[rr_node[node_fan_in[inode][iconn]].direction+1] == direction_name[1])
							buff_num = (rr_node[inode].ylow - rr_node[node_fan_in[inode][iconn]].ylow) -1;
						else 
							buff_num = node_len[node_fan_in[inode][iconn]] - (rr_node[inode].yhigh - rr_node[node_fan_in[inode][iconn]].ylow)-1;
					} else if (name_type[rr_node[node_fan_in[inode][iconn]].type] == name_type[2]) { //YDIR
						buff_num = 0;
					}*/
					if (name_type[rr_node[node_fan_in[inode][iconn]].type] == name_type[3])
						fprintf(fp, "n%d", node_fan_in[inode][iconn]);
					else fprintf(fp, "n%d_%d", node_fan_in[inode][iconn], buff_num/buffer_freq);
				if (node_trace[inode] == node_fan_in[inode][iconn]) {
					fprintf(fp, "/**/"); //mark the correct node for easy debugging
					config_value = mux_size-iconn-1;
				} else {
					fprintf(fp_sdc, "set_disable_timing mux_%d/in[%d]\n", imux, mux_size-iconn-1); //mark the correct node for easy debugging
				}
				if (iconn != mux_size-1) fprintf(fp, ", ");
			}
			//printf("\n");	
			//set configuration bits and record it to fp_config
			//config_set(num_bits, value, config_array, config_array_size, file)
			pre_config_array_size = config_array_size;
			//if (config_value == -1) config_set((int)ceil((double)log(mux_size)/log(2)), 0, &config_array, &config_array_size, fp_config);
			config_set((int)ceil((double)log(mux_size)/log(2)), config_value, &config_array, &config_array_size, fp_config);
			
			if (config_value == -1) fprintf(fp_config, "[%d:%d] (mux_%d) %d unused\n", config_array_size-1, pre_config_array_size, imux, config_value);
			else fprintf(fp_config, "[%d:%d] (mux_%d) %d\n", config_array_size-1, pre_config_array_size, imux, config_value);
			//fprintf(fp, "}), .out(n%d), .config_in(config_chain[%d:%d]), .config_rst(config_rst)); \n", inode, config_array_size-1, pre_config_array_size);
			//if (long_short[inode]==0)fprintf(fp, "}), .out(n%d_long), .config_in(config_chain[%d:%d]), .config_rst(config_rst)); \n", inode, config_array_size-1, pre_config_array_size);
			//if (direction_name[rr_node[inode].direction+1]==direction_name[1]){
			//	fprintf(fp, "}), .out(n%d), .config_in(config_chain[%d:%d]), .config_rst(config_rst)); \n", inode, config_array_size-1, pre_config_array_size);
			//	fprintf(fp, "buffer_wire buffer_%d (.in(n%d), .out(n%d_%d));\n", inode, inode, inode, 0);
			//} else if (node_len[inode]>buffer_freq){
			//	fprintf(fp, "}), .out(n%d), .config_in(config_chain[%d:%d]), .config_rst(config_rst)); \n", inode, config_array_size-1, pre_config_array_size);
			//	fprintf(fp, "buffer_wire buffer_%d (.in(n%d), .out(n%d_%d));\n", inode, inode, inode, (int)ceil((double)node_len[inode]/buffer_freq)-1);
			//} else {
			fprintf(fp, "}), .out(n%d), .config_in(config_chain[%d:%d]), .config_rst(config_rst)); \n", inode, config_array_size-1, pre_config_array_size);
			if (name_type[rr_type] != name_type[2] && name_type[rr_type] != name_type[3]) 
				fprintf(fp, "buffer_wire buffer_%d (.in(n%d), .out(n%d_0));\n", inode, inode, inode);
			
			if (cb_sb[inode] == 0) fprintf(fp_floorplan, "addInstToInstGroup area_%d_%d mux_%d\n", int(node_x[inode]), int(node_y[inode]), imux);
			else fprintf(fp_floorplan, "addInstToInstGroup sb_%d_%d mux_%d\n", int(node_x[inode]), int(node_y[inode]), imux);
		
			imux++;

			// keep track of biggest mux for mux definitions
			if (*max_mux_size < mux_size) *max_mux_size = mux_size;
 		}
	}
	fprintf(fp, "\n");
	fprintf(fp_config, "\n");
	
	// node_fan_in no longer used
	// node trace no longer used
	for (i=0; i<num_rr_nodes; i++) {
		free(node_fan_in[i]);
	}
	free(node_fan_in);
	free(node_trace);
	
	printf("connecting blocks\n");	
	/////////////////////////////////////////////////////////////////////	
	// connect up the blocks
	// 	first, create wires with block_x_y naming for easy debugging
	//	then, connect the nodes that correspond to those and assign
	//	ex: wire [11:0] IN_1_1;
	//		IN_1_1 = {n0, n1, n2, n3, n4, ..., n11};
	//		clb_1_1 (.IN(IN_1_1)...);
	/////////////////////////////////////////////////////////////////////
	int flag_bitstream_diff = 0;
	
	for (i=0; i<nx+2; i++) {
		for (j=0; j<ny+2; j++) {
			if (grid[i][j].type == EMPTY_TYPE) continue;
			
			pb_graph_node = grid[i][j].type->pb_graph_head;
			t_name = grid[i][j].type->name;
			t_cap = grid[i][j].type->capacity;
			config_size = type_config_bits[grid[i][j].type->index];
			
			fprintf(fp_floorplan, "addInstToInstGroup area_%d_%d %s_%d_%d\n", i, j, t_name, i, j);	
			//this structure is used to translate node to nets for blocks to use
			//[0] for clock, [1] for input, and [2] for output
			int*** input_equivalence_net_order[3];
			
			//create clock wires to connect to the blocks
			if (grid[i][j].type != IO_TYPE) {
				input_equivalence_net_order[0] = (int***)malloc(pb_graph_node->num_clock_ports*sizeof(int**));
				for (k=0; k<pb_graph_node->num_clock_ports; k++) {
					port = pb_graph_node->clock_pins[k][0].port;
					input_equivalence_net_order[0][k] = (int**)malloc(pb_graph_node->num_clock_pins[k]*sizeof(int*));
					fprintf(fp, "wire [%d:0]%s_%d_%d;\n", \
						t_cap*pb_graph_node->num_clock_pins[k]-1, port->name, i, j);
					fprintf(fp, "assign %s_%d_%d = {", port->name, i, j);
					for (l=pb_graph_node->num_clock_pins[k]-1; l>=0; l--) {
						input_equivalence_net_order[0][k][l] = (int*)malloc(t_cap*sizeof(int));
						for (icap = t_cap-1; icap>=0; icap--) {
							input_equivalence_net_order[0][k][l][icap] = node_net_num[clock_pin_sort_by_grid[i][j][icap][k][l]];
							fprintf(fp, "fpga_clk");
							if (icap!=0 || l!=0) fprintf(fp, ", ");
						}
					}
					fprintf(fp, "};\n");
				}				
			}
			//create input wires to connect to the blocks
			input_equivalence_net_order[1] = (int***)malloc(pb_graph_node->num_input_ports*sizeof(int**));
			for (k=0; k<pb_graph_node->num_input_ports; k++) {
				port = pb_graph_node->input_pins[k][0].port;
				input_equivalence_net_order[1][k] = (int**)malloc(pb_graph_node->num_input_pins[k]*sizeof(int*));
				fprintf(fp, "wire [%d:0]%s_%d_%d;\n", \
					t_cap*pb_graph_node->num_input_pins[k]-1, port->name, i, j);
				fprintf(fp, "assign %s_%d_%d = {", port->name, i, j);
				for (l=pb_graph_node->num_input_pins[k]-1; l>=0; l--) {
					input_equivalence_net_order[1][k][l] = (int*)malloc(t_cap*sizeof(int));
					for (icap = t_cap-1; icap>=0; icap--) {
						input_equivalence_net_order[1][k][l][icap] = node_net_num[input_pin_sort_by_grid[i][j][icap][k][l]];
						fprintf(fp, "n%d", input_pin_sort_by_grid[i][j][icap][k][l]);
						if (icap!=0 || l!=0) fprintf(fp, ", ");
					}
				}
				fprintf(fp, "};\n");
			}
			//create output wires to connect to the blocks
			input_equivalence_net_order[2] = (int***)malloc(pb_graph_node->num_output_ports*sizeof(int**));
			for (k=0; k<pb_graph_node->num_output_ports; k++) {
				port = pb_graph_node->output_pins[k][0].port;
				input_equivalence_net_order[2][k] = (int**)malloc(pb_graph_node->num_output_pins[k]*sizeof(int*));
				fprintf(fp, "wire [%d:0]%s_%d_%d;\n", \
					t_cap*pb_graph_node->pb_type->num_output_pins-1, \
					port->name, i, j);
				fprintf(fp, "assign {");
				for (l=pb_graph_node->num_output_pins[k]-1; l>=0; l--) {
					input_equivalence_net_order[2][k][l] = (int*)malloc(t_cap*sizeof(int));
					for (icap = t_cap-1; icap>=0; icap--) {
						input_equivalence_net_order[2][k][l][icap] = node_net_num[output_pin_sort_by_grid[i][j][icap][k][l]];
						fprintf(fp, "n%d", output_pin_sort_by_grid[i][j][icap][k][l]);
						if (icap!=0 || l!=0) fprintf(fp, ", ");
					}
				}
				fprintf(fp, "} = %s_%d_%d;\n", port->name, i, j);
			}
			fprintf(fp, "\n");
			
			//debugging
			/*
			printf("%s[%d][%d]\n", t_name, i, j);
			
			if (strcmp(t_name, "io")!=0) { //CLOCK for IO means nothing currently!!
				for (k=0; k<pb_graph_node->num_clock_ports; k++) {
					for (l=pb_graph_node->num_clock_pins[k]-1; l>=0; l--) {
						for (icap = 0; icap<t_cap; icap++) 
						printf("clock [%d][%d][%d][%d]%d\n", 0, k, l, icap, input_equivalence_net_order[0][k][l][icap]);
					}
				}	
			}
			for (k=0; k<pb_graph_node->num_input_ports; k++) {
				for (l=pb_graph_node->num_input_pins[k]-1; l>=0; l--) {
						for (icap = 0; icap<t_cap; icap++) 
					printf("input [%d][%d][%d][%d]%d\n", 1, k, l, icap, input_equivalence_net_order[1][k][l][icap]);
				}
			}	
			for (k=0; k<pb_graph_node->num_output_ports; k++) {
				for (l=pb_graph_node->num_output_pins[k]-1; l>=0; l--) {
						for (icap = 0; icap<t_cap; icap++) 
					printf("output [%d][%d][%d][%d]%d\n", 2, k, l, icap, input_equivalence_net_order[2][k][l][icap]);
				}
			}printf("\n");
			*/
			pre_config_array_size = config_array_size;
			config_set_block (i, j, input_equivalence_net_order, &config_array, &config_array_size, fp_config, fp_sdc);
			
			//block instantiation
			k=pb_graph_node->num_clock_ports-1;
			l=pb_graph_node->num_input_ports-1;
			m=pb_graph_node->num_output_ports-1;
			
			fprintf(fp, "%s %s_%d_%d ( ", t_name, t_name, i, j);
			if (grid[i][j].type != IO_TYPE) {
				for (; k>=0; k--) {
					port = pb_graph_node->clock_pins[k][0].port;
					fprintf(fp, ".%s(%s_%d_%d)", port->name, port->name, i, j);
					if (k==0) fprintf(fp, ", .reset(fpga_rst)");
					if (k!=-1 || l!=-1 || m!=-1 || config_size !=0) fprintf(fp, ", ");
				}
			} else k = -1;
			for (; l>=0; l--) {
				port = pb_graph_node->input_pins[l][0].port;
				fprintf(fp, ".%s(%s_%d_%d)", port->name, port->name, i, j);
				if (k!=-1 || l!=-1 || m!=-1 || config_size !=0) fprintf(fp, ", ");
			}
			for (; m>=0; m--) {
				port = pb_graph_node->output_pins[m][0].port;
				fprintf(fp, ".%s(%s_%d_%d)", port->name, port->name, i, j);
				if (k!=-1 || l!=-1 || m!=-1 || config_size !=0) fprintf(fp, ", ");
			}
			
			if (grid[i][j].type == IO_TYPE) {
				fprintf(fp, ".%s_ext(%s_%d_%d_wire), ", t_name, t_name, i, j);
				fprintf(fp, ".config_in(config_chain[%d:%d]), .config_rst(config_rst) );\n\n", \
					config_array_size-1, pre_config_array_size);
			} else if (config_size !=0) {
				fprintf(fp, ".config_in(config_chain[%d:%d]), .config_rst(config_rst) );\n\n",\
					config_array_size-1, pre_config_array_size);
			} else fprintf(fp, " );\n\n");

			if ((config_array_size - pre_config_array_size) != config_size) {
				flag_bitstream_diff++;
			}
			if (grid[i][j].type != IO_TYPE) {
				for (k=0; k<pb_graph_node->num_clock_ports; k++) {
					for (l=0; l<pb_graph_node->num_clock_pins[k]; l++) {
						free(input_equivalence_net_order[0][k][l]);
					}
					free(input_equivalence_net_order[0][k]);
				}
				free(input_equivalence_net_order[0]);
			}
			for (k=0; k<pb_graph_node->num_input_ports; k++) {
				for (l=0; l<pb_graph_node->num_input_pins[k]; l++) {
					free(input_equivalence_net_order[1][k][l]);
				}
				free(input_equivalence_net_order[1][k]);
			}
			for (k=0; k<pb_graph_node->num_output_ports; k++) {
				for (l=0; l<pb_graph_node->num_output_pins[k]; l++) {
					free(input_equivalence_net_order[2][k][l]);
				}
				free(input_equivalence_net_order[2][k]);
			}
			free(input_equivalence_net_order[1]);
			free(input_equivalence_net_order[2]);

		}
	}
	assert(flag_bitstream_diff == 0);
	
	//x_pin_sort_by_grid no longer needed
	for (i=0; i<nx+2; i++) {		
		for (j=0; j<ny+2; j++) {
			if (grid[i][j].type == EMPTY_TYPE) continue;			
			for (k=0; k<grid[i][j].type->capacity; k++) {				
				for (l=0; l<pb_graph_node->num_clock_ports; l++)
					free(clock_pin_sort_by_grid[i][j][k][l]);
				for (l=0; l<pb_graph_node->num_input_ports; l++)
					free(input_pin_sort_by_grid[i][j][k][l]);
				for (l=0; l<pb_graph_node->num_output_ports; l++)
					free(output_pin_sort_by_grid[i][j][k][l]);
				free(clock_pin_sort_by_grid[i][j][k]);
				free(input_pin_sort_by_grid[i][j][k]);
				free(output_pin_sort_by_grid[i][j][k]);
			}
			free(clock_pin_sort_by_grid[i][j]);
			free(input_pin_sort_by_grid[i][j]);
			free(output_pin_sort_by_grid[i][j]);
		}
		free(clock_pin_sort_by_grid[i]);
		free(input_pin_sort_by_grid[i]);
		free(output_pin_sort_by_grid[i]);	
	}
	free(clock_pin_sort_by_grid);
	free(input_pin_sort_by_grid);
	free(output_pin_sort_by_grid);
	
	//node_net_num no longer needed
	free(node_net_num);
	
	/////////////////////////////////////////////////////////////////////	
	// configuration chain
	/////////////////////////////////////////////////////////////////////
	pre_config_array_size = config_array_size;
	//push xx0011 to 0011-- since reading from msb
	for (i=0; i<config_array_size%8; i++) {
		config_set(1, 0, &config_array, &config_array_size, fp_config);
	}
	fprintf(fp_config, "\nbitstream [%d:0]\n", pre_config_array_size-1);
	/*for (i=0; i<ceil((double)config_array_size/8); i++) {
		for (j=7; j>=0; j--) {
			if (i*8+(8-j-1) > pre_config_array_size-1) break;
			fprintf(fp_config, "%d", (config_array[i]>>j)&1);
		}
	}*/
	printf("size = %d/%d\n", pre_config_array_size, config_array_size);
	for (i=ceil((double)config_array_size/8)-1; i>=0; i--) {
		for (j=0; j<8; j++) {
			if (i*8+(8-j-1) > pre_config_array_size-1) continue;
			fprintf(fp_config, "%d", (config_array[i]>>j)&1);
		}
	}
	printf("size = %d/%d\n", pre_config_array_size, config_array_size);
	fprintf(fp, "config_helper config_helper");
	fprintf(fp, "( .config_in(config_in), .config_out(config_chain[`CONFIG_SIZE-1:0]), ");
	fprintf(fp, ".clk(config_clk) );\n\n");	


	fprintf(fp, "endmodule\n\n");
	
	fprintf(fp_config_helper, "module config_helper(\n");
	fprintf(fp_config_helper, "\tinput clk,\n");
	//fprintf(fp_config_helper, "\tinput reset,\n");
	fprintf(fp_config_helper, "\tinput config_in,\n");
	fprintf(fp_config_helper, "\toutput reg [%d:0]config_out\n",(pre_config_array_size)-1);
	fprintf(fp_config_helper, ");\n\n");

	// only used for simulation
	fprintf(fp_config_helper, "initial begin\n");
	int n=0;
	fprintf(fp_config_helper, "\tconfig_out = %d'b",pre_config_array_size );
	//for (i=0; i<ceil((double)config_array_size/8); i++) {
	/*for (i=0; i<ceil((double)config_array_size/8); i++) {
		for (j=7; j>=0; j--) {
			if (i*8+(8-j-1) > pre_config_array_size-1) break;
			fprintf(fp_config_helper, "%d", (config_array[i]>>j)&1);
		}
	}*/
	for (i=ceil((double)config_array_size/8)-1; i>=0; i--) {
		for (j=0; j<8; j++) {
			if (i*8+(8-j-1) > pre_config_array_size-1) continue;
			fprintf(fp_config_helper, "%d", (config_array[i]>>j)&1);
			n++;
		}	
	}
	//for (i=ceil((double)config_array_size/8)-1; i>=0; i--) {
		//for (j=7; j>=0; j--) {
		//for (j=0; j<8; j++) {
		//	if (i*8+(8-j-1) > pre_config_array_size-1) continue;
			//printf("[%d]%d\n", (i)*8+(8-1-j), (config_array[i]>>j)&1);
			//fprintf(fp_config, "%d", (config_array[i]>>j)&1);
			//if (i*8+(8-j-1) > pre_config_array_size-1) break;
		//	fprintf(fp_config_helper, "%d", (config_array[i]>>j)&1);
		//	n++;
		//}
	//}
	fprintf(fp_config_helper, ";\nend\n\n");

	int n_config_helper = pre_config_array_size/100000;
	
	if (n_config_helper < 1) {
		fprintf(fp_config_helper, "wire [%d:0]config_wire;\n\n", (pre_config_array_size%100000)-1);
		fprintf(fp_config_helper, "always @ (posedge clk) begin\n");
		fprintf(fp_config_helper, "\tconfig_out<=config_wire;\nend\n\n");
		fprintf(fp_config_helper, "assign config_wire = {config_out[%d:0], config_in};\n\n", (pre_config_array_size%100000)-2);
	} else {
		for (i=0; i<n_config_helper; i++) {
			fprintf(fp_config_helper, "wire [%d:0]config_wire_%d;\n\n", (100000*(i+1))-1, i);
			fprintf(fp_config_helper, "always @ (posedge clk) begin\n");
			fprintf(fp_config_helper, "\t\tconfig_out[%d:%d]<=config_wire_%d;\nend\n\n", (100000*(i+1))-1, (100000*(i)), i);
			if (i==0) fprintf(fp_config_helper, "assign config_wire_%d = {config_out[%d:0], config_in};\n\n", i, (100000*(i+1))-2);
			else fprintf(fp_config_helper, "assign config_wire_%d = {config_out[%d:%d]};\n\n", i, (100000*(i+1))-2, (100000*(i))-1);
		}
		fprintf(fp_config_helper, "wire [%d:0]config_wire_%d;\n\n", (pre_config_array_size%100000)-1, i);
		fprintf(fp_config_helper, "always @ (posedge clk) begin\n");
		fprintf(fp_config_helper, "\t\tconfig_out[%d:%d]<=config_wire_%d;\nend\n\n", (100000*(i))+(pre_config_array_size%100000)-1, (100000*(i)), i);
		fprintf(fp_config_helper, "assign config_wire_%d = {config_out[%d:%d]};\n\n", i, (100000*(i))+(pre_config_array_size%100000)-2, (100000*(i))-1);
	}
		
	fprintf(fp_config_helper, "endmodule\n");
	
	//USE BELOW CODE TO DEBUG BITSTREAM
	/*fprintf(fp_config, "\n");
	for (i=0; i<ceil((double)config_array_size/8); i++) {
		for (j=7; j>=0; j--) {
			if (i*8+(8-j-1) > config_array_size-1) break;
			fprintf(fp_config, "[%d]%d\n", (i*8)+(8-j-1), (config_array[i]>>j)&1);
		}
	}
	fprintf(fp_config, "\n");*/
	fclose(fp_config_helper);
	fclose(fp);
}

t_pb_graph_pin* get_pb_graph_node_pin_from_pb_graph_node(t_pb_graph_node *pb_graph_node, int ipin) {
	int i, count;
	const t_pb_type *pb_type;
	pb_type = pb_graph_node->pb_type;

	/* If this is post-placed, then the ipin may have been shuffled up by the z * num_pins, 
	bring it back down to 0..num_pins-1 range for easier analysis */
	ipin %= (pb_type->num_input_pins + pb_type->num_output_pins + pb_type->num_clock_pins);
		
	if(ipin < pb_type->num_input_pins) {
		count = ipin;
		for(i = 0; i < pb_graph_node->num_input_ports; i++) {
			if(count - pb_graph_node->num_input_pins[i] >= 0) {
				count -= pb_graph_node->num_input_pins[i];
			} else {
				return &pb_graph_node->input_pins[i][count];
			}
		}
	} else if (ipin < pb_type->num_input_pins + pb_type->num_output_pins) {
		count = ipin - pb_type->num_input_pins;
		for(i = 0; i < pb_graph_node->num_output_ports; i++) {
			if(count - pb_graph_node->num_output_pins[i] >= 0) {
				count -= pb_graph_node->num_output_pins[i];
			} else {
				return &pb_graph_node->output_pins[i][count];
			}
		}
	} else {
		count = ipin - pb_type->num_input_pins - pb_type->num_output_pins;
		for(i = 0; i < pb_graph_node->num_clock_ports; i++) {
			if(count - pb_graph_node->num_clock_pins[i] >= 0) {
				count -= pb_graph_node->num_clock_pins[i];
			} else {
				return &pb_graph_node->clock_pins[i][count];
			}
		}
	}
	assert(0);
	return NULL;
}

