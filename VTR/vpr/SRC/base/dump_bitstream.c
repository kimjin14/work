#include <assert.h>
#include <string.h>
#include "util.h"
#include "vpr_types.h"
#include "globals.h"
#include "pb_type_graph.h"
#include "rr_graph.h"
#include "rr_graph_util.h"
#include "verilog_writer.h"
#include "dump_bitstream.h"

void config_set(int bits_req, int value, char** config_array, int* config_array_size, FILE * fp) {
	
	int curr_iarray = *config_array_size/8;
	int curr_bit_used = *config_array_size%8;
	int i;
	char c;

	if (bits_req > 3) bits_req+=2;
		
	//first time configuring, use malloc
	if (*config_array_size == 0) {	
		*config_array_size += bits_req;
		*config_array = (char*)malloc((*config_array_size/8)*sizeof(char));
	} 

	//case where you have bits unused and require less than that
	//if curr_bit_used != 0, there are some unused bits
	//if (8bits - curr_bit_used) > bits_req), there are enough unused bits
	else if (curr_bit_used!=0 && (8-curr_bit_used) > bits_req) {
		*config_array_size += bits_req;
	} else { //if not enough
		*config_array_size += bits_req;
		*config_array = (char*)realloc(*config_array, (int)ceil((double)(*config_array_size)/8)*sizeof(char));
	}

	int j = 0;
	//for each bit, set the values
	for (i=0; i<bits_req; i++) {	

		if (curr_bit_used<8) curr_bit_used++;
		else { //all filled up, set count back to 0 and go to the next array
			curr_bit_used = 0;
			curr_iarray++;
		}

		//if there are space, keep filling it up from [0:7]
		c = (*config_array)[curr_iarray];
		c = (c << 1)&254;
		
		//special case: where partially decoded MUX16 is used
		//last 2 bits should turn into 4 bits (value&3 is last 2 bits)
		//however, if not part of MUX16, use regular encoding
		//if (bits_req > 3 && i<4 && value>(8)) {
		if (bits_req > 3 && i<4) {
			if ((value&3)==j&&value!=-1) c += 1&1;
			else c += 0&1;
			j++;		
		} else {
			c += value>>(i-(int)((double)j/2))&1;
		}	
		fprintf(fp, "\t%d %d\n", c&1, value&3);
		(*config_array)[curr_iarray] = c;
	}
	assert(curr_iarray < ((int)ceil((double)(*config_array_size)/8)));

}

void config_set_block (int x, int y, int**** net_order, \
	char** config_array, int* config_array_size, FILE * fp, FILE * fp_sdc) {
	
	int icap, iblk;
	
	t_grid_tile grid_tile = grid[x][y];
	int* logical_blk_indices = grid_tile.blocks;
	int logical_blk_cap = grid_tile.type->capacity;
	t_pb_graph_node *pb_graph_node = grid_tile.type->pb_graph_head;
	
	fprintf(fp_sdc, "# %s_%d_%d\n", pb_graph_node->pb_type->name, x, y);
	fprintf(fp_sdc, "current_instance %s_%d_%d\n", pb_graph_node->pb_type->name, x, y);
	for (icap=0; icap<logical_blk_cap; icap++) {
		iblk = logical_blk_indices[icap];
		
		fprintf(fp, "[%d] -> \n", *config_array_size);	
		
		// if the blocks not used, use "config_set_empty_block_rec" to recursively set config bits to 0
		// else, use "config_set_block_rec"
		if (iblk == -1) {	
			config_set_empty_block_rec(pb_graph_node, \
					config_array, config_array_size, fp, fp_sdc);	
			fprintf(fp, "[%d] unused %s %d %d %d\n\n", *config_array_size-1, \
				pb_graph_node->pb_type->name, x, y, icap);

		} else {
			config_set_block_rec(block[iblk].pb, net_order, \
				config_array, config_array_size, fp, fp_sdc);
			//important to print in this order: used by the testbench.pl
			fprintf(fp, "[%d] \"%s\" %s %d %d %d <-\n\n",*config_array_size-1, block[iblk].name, \
				block[iblk].pb->pb_graph_node->pb_type->name, block[iblk].x, block[iblk].y, block[iblk].z);
		}
	}
	fprintf(fp_sdc, "current_instance\n");	
	fprintf(fp, "\n");
}

void config_set_fle_lut_rec (t_pb *pb, char* lut_config, int fle_num, int* lut_cnt,
	char** config_array, int* config_array_size, FILE * fp, FILE * fp_sdc) {
	
	int i, j, k;
	
	//This is unused CLB
	if (pb == NULL) {
		fprintf(fp, "\t[%d:%d] unused LUT*\n",((int)pow(2, 6))+*config_array_size-1, *config_array_size);
		//printf("set_false_path -to clb_x_y/fle_i/LUT/*\n");	
		for (i=0; i<(int)pow(2, 6); i++) {
			config_set(1, 0, config_array, config_array_size, fp);
		}
		return;
	}
	//fprintf(fp, "%s\n", pb->name);
	t_pb_graph_node *pb_graph_node = pb->pb_graph_node;
		
	//This is FF (end case w/o config settings)
	if (pb_graph_node->pb_type->blif_model!= NULL && \
		strcmp(pb_graph_node->pb_type->blif_model, ".latch")==0) {
		return;
	}
	
	//This is LUT being used
	for (i=0; i<pb_graph_node->pb_type->num_modes; i++) {
		if (strcmp(pb_graph_node->pb_type->modes[i].name, "wire")==0) {
			config_set_LUT(pb, fle_num,\
				config_array, config_array_size, fp, fp_sdc);
			lut_config = NULL;
			
			int num_input = find_number_of_inputs(pb);
			
			if (num_input <= 5) {
				for (int l = 0; l<num_input; l++) {
					int p_pin_count = pb->pb_graph_node->input_pins[0][l].pin_count_in_cluster;
					int p_net = pb->parent_pb->rr_graph[p_pin_count].net_num;	
					if (p_net == OPEN && *lut_cnt == 0) { // 0 1 2 3 6
						if (l == 4) {
							//fprintf(fp_sdc, "set_disable_timing fle_%d/lut5_0_0\n", fle_num);	
						} else {
							fprintf(fp_sdc, "set_disable_timing fle_%d/lut4_0/in[%d]\n", fle_num, l);	
							fprintf(fp_sdc, "set_disable_timing fle_%d/lut4_1/in[%d]\n", fle_num, l);
						}		
					} else if (p_net == OPEN && *lut_cnt == 1) { // 0 1 4 5 7
						if (l == 4) {
							//fprintf(fp_sdc, "set_disable_timing fle_%d/lut5_1\n", fle_num);	
						} else {
							fprintf(fp_sdc, "set_disable_timing fle_%d/lut4_2/in[%d]\n", fle_num, l);	
							fprintf(fp_sdc, "set_disable_timing fle_%d/lut4_3/in[%d]\n", fle_num, l);
						}
					}
				}
				(*lut_cnt)++;
			}
			return;
		}
	}
	
	//This is unused FLE
	//CURRENTLY only handles unused FLEs
	//NEED TO SUPPORT unused half of FLE set as 2 5-LUT mode
	//int num_input = pb_graph_node->pb_type->num_input_pins;
	if (pb->name == NULL ) {
		int used_flag = 0;
		int num_input = find_number_of_inputs(pb);
		for (i=0; i<num_input; i++) {
			int p_pin_count = pb->pb_graph_node->input_pins[0][i].pin_count_in_cluster;			
			if (pb->parent_pb == NULL);// printf("null parent \n");
			else {
				int p_net = pb->rr_graph[p_pin_count].net_num;			
				if (p_net != OPEN) {
					used_flag = 1;
					break;
				}	
			}
		}
		if (!used_flag) {
			num_input = 5;
			if (pb_graph_node->pb_type->num_input_pins > 5) num_input = 6;
			//printf("set_false_path -to \n");	
			fprintf(fp, "\t[%d:%d] unused LUT\n",((int)pow(2, num_input))+*config_array_size-1, *config_array_size);
			for (i=0; i<(int)pow(2, num_input); i++) {
				config_set(1, 0, config_array, config_array_size, fp);
			}
			return;
		}else {
			//SHOULD BE SOMETHING HERE?
		}
	}

	//Recursively descend until you find the LUT
	for (i = 0; i < pb_graph_node->pb_type->num_modes; i++) {
		for (j = 0; j < pb_graph_node->pb_type->modes[i].num_pb_type_children; j++) {
			for (k = 0;	k<pb_graph_node->pb_type->modes[i].pb_type_children[j].num_pb;	k++) {
				if (strcmp(pb_graph_node->pb_type->modes[i].pb_type_children[j].name, \
						pb->child_pbs[j][k].pb_graph_node->pb_type->name)==0) {
					config_set_fle_lut_rec(&pb->child_pbs[j][k], lut_config, fle_num, lut_cnt,
						config_array, config_array_size, fp, fp_sdc);
				}
			}
		}
	}
}

void config_set_fle_mode_rec (t_pb *pb, char* lut_config, int fle_num, int* lut_cnt,
	char** config_array, int* config_array_size, FILE * fp, FILE * fp_sdc) {
	
	int i, j, k;
	
	//This is unused CLB
	if (pb == NULL) {
	
		fprintf(fp, "\t[%d:%d] unused\n", *config_array_size, *config_array_size);
		config_set(1, 0, config_array, config_array_size, fp);
		return;
	}
	
	t_pb_graph_node *pb_graph_node = pb->pb_graph_node;
	
	//This is FF (end case w/o config settings)
	if (pb_graph_node->pb_type->blif_model!= NULL && \
		strcmp(pb_graph_node->pb_type->blif_model, ".latch")==0) {
		return;
	}
	
	if (pb->name == NULL) {
		fprintf(fp, "\t[%d:%d] unused\n", *config_array_size, *config_array_size);
		config_set(1, 1, config_array, config_array_size, fp);
		return;
	}
	
	for (i = 0; i < pb_graph_node->pb_type->num_modes; i++) {
		for (j = 0; j < pb_graph_node->pb_type->modes[i].num_pb_type_children; j++) {
			for (k = 0;	k<pb_graph_node->pb_type->modes[i].pb_type_children[j].num_pb;	k++) {
				if (strcmp(pb_graph_node->pb_type->modes[i].pb_type_children[j].name, \
						pb->child_pbs[j][k].pb_graph_node->pb_type->name)==0) {
					if (pb->child_pbs[j][k].pb_graph_node->pb_type->num_input_pins == 6) {
						fprintf(fp, "\t[%d:%d] 6 LUT mode [%d]\n", *config_array_size, *config_array_size, 0);
						fprintf(fp_sdc, "set_disable_timing fle_%d/lut5_1\n", fle_num);
						fprintf(fp_sdc, "set_disable_timing fle_%d/fracture_lut_in_4/in[1]\n", fle_num);
						fprintf(fp_sdc, "set_disable_timing fle_%d/fracture_lut_in_5/in[1]\n", fle_num);
						config_set(1, 0, config_array, config_array_size, fp);			
						return;
					} else if (pb->child_pbs[j][k].pb_graph_node->pb_type->num_input_pins == 5) {
						fprintf(fp, "\t[%d:%d] 5 LUT mode [%d]\n", *config_array_size, *config_array_size, 1);
						config_set(1, 1, config_array, config_array_size, fp);
						fprintf(fp_sdc, "set_disable_timing fle_%d/lut6\n", fle_num);
						fprintf(fp_sdc, "set_disable_timing fle_%d/fracture_lut_in_4/in[0]\n", fle_num);
						fprintf(fp_sdc, "set_disable_timing fle_%d/fracture_lut_in_5/in[0]\n", fle_num);
						return;
					}
					config_set_fle_mode_rec(&pb->child_pbs[j][k], lut_config, fle_num, lut_cnt,
						config_array, config_array_size, fp, fp_sdc);
				}
			}
		}
	}
}

void config_set_fle_bypass_rec (t_pb *pb, int mode, int fle_num, int* lut_cnt,
	char** config_array, int* config_array_size, FILE * fp, FILE * fp_sdc) {
	
	int i, j, k;
	
	//This is unused CLB
	if (pb == NULL) {
		fprintf(fp, "\t[%d:%d] [%d]1\n", *config_array_size, *config_array_size, 0);
		config_set(1, 0, config_array, config_array_size, fp);
		fprintf(fp, "\t[%d:%d] [%d]2\n", *config_array_size, *config_array_size, 0);
		config_set(1, 0, config_array, config_array_size, fp);
		//disable both mux
		fprintf(fp_sdc, "set_disable_timing fle_%d/mux_bypass_*/in*\n", fle_num);
		fprintf(fp_sdc, "set_disable_timing fle_%d/ff_*/D\n", fle_num);
		return;
	}
	
	t_pb_graph_node *pb_graph_node = pb->pb_graph_node;
	
	//This is FF (end case w/o config settings)
	if (pb_graph_node->pb_type->blif_model!= NULL && \
		strcmp(pb_graph_node->pb_type->blif_model, ".latch")==0) {
		//if mode is 1, its being used as 6 lut so both FF has to be configured
		//else only one has to be configured
		if (mode == 1) {
			if (pb->name == NULL) { //bypass mode
				fprintf(fp, "\t[%d:%d] [%d]3\n", *config_array_size, *config_array_size, 0);
				config_set(1, 0, config_array, config_array_size, fp);
				fprintf(fp, "\t[%d:%d] [%d]4\n", *config_array_size, *config_array_size, 0);
				config_set(1, 0, config_array, config_array_size, fp);
				//disable one path of 1st mux
				fprintf(fp_sdc, "set_disable_timing fle_%d/mux_bypass_0/in[1]\n", fle_num);
				fprintf(fp_sdc, "set_disable_timing fle_%d/ff_0/D\n", fle_num);
			} else { //ff mode seems to never happen???
				fprintf(fp, "\t[%d:%d] [%d]5\n", *config_array_size, *config_array_size, 1);
				config_set(1, 1, config_array, config_array_size, fp);
				fprintf(fp, "\t[%d:%d] [%d]6\n", *config_array_size, *config_array_size, 0);
				config_set(1, 0, config_array, config_array_size, fp);
				//disable one path of 1st mux
				fprintf(fp_sdc, "set_disable_timing fle_%d/mux_bypass_0/in[0]\n", fle_num);
			}
			//disable both paths of 2nd mux
			fprintf(fp_sdc, "set_disable_timing fle_%d/mux_bypass_1/in*\n", fle_num);
			fprintf(fp_sdc, "set_disable_timing fle_%d/ff_1/D\n", fle_num);
		} else {
			if (pb->name == NULL) {
				fprintf(fp, "\t[%d:%d] [%d]7\n", *config_array_size, *config_array_size, 0);
				config_set(1, 0, config_array, config_array_size, fp);
				//disable one path of 1st mux
				fprintf(fp_sdc, "set_disable_timing fle_%d/mux_bypass_%d/in[1]\n", fle_num, *lut_cnt);
				fprintf(fp_sdc, "set_disable_timing fle_%d/ff_%d/D\n", fle_num, *lut_cnt);
			} else { //ALso seems to never happen
				fprintf(fp, "\t[%d:%d] [%d]8\n", *config_array_size, *config_array_size, 1);
				config_set(1, 1, config_array, config_array_size, fp);
				//disable one path of 1st mux
				fprintf(fp_sdc, "set_disable_timing fle_%d/mux_bypass_%d/in[0]\n", fle_num, *lut_cnt);
			}
			(*lut_cnt)++;
		}
		return;
	}
	//This is LUT being used
	for (i=0; i<pb_graph_node->pb_type->num_modes; i++) {
		if (strcmp(pb_graph_node->pb_type->modes[i].name, "wire")==0) {
			return;
		}
	}
	//This is unused FLE
	//CURRENTLY only handles unused FLEs
	//NEED TO SUPPORT unused half of FLE set as 2 5-LUT mode
	//int num_input = pb_graph_node->pb_type->num_input_pins;
	if (pb->mode!=1 && pb->name == NULL) {
		if (pb_graph_node->pb_type->num_input_pins > 5) {
			fprintf(fp, "\t[%d:%d] [%d]9\n", *config_array_size, *config_array_size, 0);
			config_set(1, 0, config_array, config_array_size, fp);
			fprintf(fp, "\t[%d:%d] [%d]10\n", *config_array_size, *config_array_size, 0);
			config_set(1, 0, config_array, config_array_size, fp);
			fprintf(fp_sdc, "set_disable_timing fle_%d/mux_bypass_*/in*\n", fle_num);
			fprintf(fp_sdc, "set_disable_timing fle_%d/ff_*/D\n", fle_num);
		} else {
			fprintf(fp, "\t[%d:%d] [%d]11 %d\n", *config_array_size, *config_array_size, 0, pb->mode);
			config_set(1, 0, config_array, config_array_size, fp);
			fprintf(fp_sdc, "set_disable_timing fle_%d/mux_bypass_%d/in*\n", fle_num, *lut_cnt);
			fprintf(fp_sdc, "set_disable_timing fle_%d/ff_%d/D\n", fle_num, *lut_cnt);
			(*lut_cnt)++;
		}	
		return;
	}
	//Recursively descend until you find the LUT
	for (i = 0; i < pb_graph_node->pb_type->num_modes; i++) {
		for (j = 0; j < pb_graph_node->pb_type->modes[i].num_pb_type_children; j++) {
			for (k = 0;	k<pb_graph_node->pb_type->modes[i].pb_type_children[j].num_pb;	k++) {
				if (strcmp(pb_graph_node->pb_type->modes[i].pb_type_children[j].name, \
						pb->child_pbs[j][k].pb_graph_node->pb_type->name)==0) {
					if (pb_graph_node->pb_type->num_modes > 1) {
						mode = pb->mode;
					}
					config_set_fle_bypass_rec(&pb->child_pbs[j][k], mode, fle_num, lut_cnt, 
						config_array, config_array_size, fp, fp_sdc);
				}
			}
		}
	}
}

void config_set_fle (t_pb *pb, t_pb_graph_node *pb_graph_node, int**** net_order, int fle_num,\
	char** config_array, int* config_array_size, FILE * fp, FILE * fp_sdc) {

	char* lut_config = NULL;
	//int* mode_config;
	//int* output_config;
	
	int lut_count;
	
	lut_count = 0;
	config_set_fle_lut_rec (pb, lut_config, fle_num, &lut_count, config_array, config_array_size, fp, fp_sdc);
	
	lut_count = 0;
	config_set_fle_mode_rec (pb, lut_config, fle_num, &lut_count, config_array, config_array_size, fp, fp_sdc);
	
	lut_count = 0;
	config_set_fle_bypass_rec (pb, 0, fle_num, &lut_count, config_array, config_array_size, fp, fp_sdc);

}

void config_set_empty_block_rec (t_pb_graph_node *pb_graph_node, 
	char** config_array, int* config_array_size, FILE * fp, FILE * fp_sdc) {
	
	int i, j, k;
	int num_input = pb_graph_node->pb_type->num_input_pins;
	
	//special case of fracturable LUT
	//handle separately
	if (strcmp(pb_graph_node->pb_type->name, "fle")==0) {
		assert(pb_graph_node->pb_type->num_modes>1);
		config_set_fle(NULL, pb_graph_node, NULL, pb_graph_node->placement_index, config_array, config_array_size, fp, fp_sdc);
		return;
	}
	
	for (i=0; i<pb_graph_node->pb_type->num_modes; i++) {
		if (strcmp(pb_graph_node->pb_type->modes[i].name, "wire")==0) {
			//printf("set_false_path -to \n");	
			fprintf(fp, "\t[%d:%d] (LUT -1) unused\n",(int)pow(2, num_input)+*config_array_size-1, *config_array_size);
			for (i=0; i<(int)pow(2, num_input); i++) {
				config_set(1, 0, config_array, config_array_size, fp);
			}
			return;
		} else if (pb_graph_node->child_pb_graph_nodes[i][0][0].pb_type->blif_model != NULL && \
				(strcmp(pb_graph_node->child_pb_graph_nodes[i][0][0].pb_type->blif_model, ".input")==0 || \
				strcmp(pb_graph_node->child_pb_graph_nodes[i][0][0].pb_type->blif_model, ".output")==0)) {
			config_set(1, 0, config_array, config_array_size, fp);				
			return;
		}
	}
	
	for (i = 0; i < pb_graph_node->pb_type->num_modes; i++) {
		for (j = 0; j < pb_graph_node->pb_type->modes[i].num_pb_type_children; j++) {
			for (k = 0;	k<pb_graph_node->pb_type->modes[i].pb_type_children[j].num_pb;	k++) {
				config_set_empty_pins(pb_graph_node->child_pb_graph_nodes[i][j][k].input_pins, \
					pb_graph_node->child_pb_graph_nodes[i][j][k].num_input_ports, \
					config_array, config_array_size, fp, fp_sdc);
				config_set_empty_block_rec(&pb_graph_node->child_pb_graph_nodes[i][j][k],
					config_array, config_array_size, fp, fp_sdc);
			}
		}
	}
	config_set_empty_pins(pb_graph_node->output_pins, \
		pb_graph_node->num_output_ports, \
		config_array, config_array_size, fp, fp_sdc);
}

void config_set_block_rec (t_pb *pb, int**** net_order, \
	char** config_array, int* config_array_size, FILE * fp, FILE * fp_sdc) {
	
	int i, j, k;	
	t_pb_graph_node *pb_graph_node = pb->pb_graph_node;

	//special case of fracturable LUT
	//handle separately
	if (strcmp(pb_graph_node->pb_type->name, "fle")==0) {
		assert(pb_graph_node->pb_type->num_modes>1);
		//fprintf(fp, "pb->name = %s\n", pb->name);
		config_set_fle(pb, pb_graph_node, net_order, pb_graph_node->placement_index, config_array, config_array_size, fp, fp_sdc);
		return;
	}
								
	for (i=0; i<pb_graph_node->pb_type->num_modes; i++) {
		//fprintf(fp, "pb->name = %s\n", pb->name);
		if (strcmp(pb_graph_node->pb_type->modes[i].name, "wire")==0) {
			config_set_LUT(pb, 0, \
				config_array, config_array_size, fp, fp_sdc);
			return;
		} else if (pb_graph_node->child_pb_graph_nodes[i][0][0].pb_type->blif_model != NULL && \
				(strcmp(pb_graph_node->child_pb_graph_nodes[i][0][0].pb_type->blif_model, ".input")==0 || \
				strcmp(pb_graph_node->child_pb_graph_nodes[i][0][0].pb_type->blif_model, ".output")==0)) {
			for (int ipin=0; ipin<pb_graph_node->total_pb_pins ; ipin++) {
				if (pb->rr_graph[ipin].prev_node != -1) {
					if (pb->rr_graph[ipin].pb_graph_pin->port->type == OUT_PORT) {
						config_set(1, 1, config_array, config_array_size, fp);
					} else {
						config_set(1, 0, config_array, config_array_size, fp);
					}
				}
			}		
			return;
		}
	}
	if (pb_graph_node->pb_type->blif_model!= NULL && strcmp(pb_graph_node->pb_type->blif_model, ".latch")==0) {
		return;
	}
	// for cases where some LUTs being used and some not,
	// parts of the block will be defined by pb and some parts won't be

	if (pb->name == NULL ) {
		int used_flag = 0;
		int num_input = find_number_of_inputs(pb);
		for (i=0; i<num_input; i++) {
			int p_pin_count = pb->pb_graph_node->input_pins[0][i].pin_count_in_cluster;			
			if (pb->parent_pb == NULL);// printf("null parent \n");
			else {
				int p_net = pb->rr_graph[p_pin_count].net_num;			
				if (p_net != OPEN) {
					used_flag = 1;
					break;
				}	
			}
		}
		if (!used_flag) {
			config_set_empty_block_rec (pb_graph_node, config_array, config_array_size, fp, fp_sdc);
			return;
		}
	}

	for (i = 0; i < pb_graph_node->pb_type->num_modes; i++) {
		for (j = 0; j < pb_graph_node->pb_type->modes[i].num_pb_type_children; j++) {
			for (k = 0;	k<pb_graph_node->pb_type->modes[i].pb_type_children[j].num_pb;	k++) {
				config_set_pins(pb_graph_node->child_pb_graph_nodes[i][j][k].input_pins, \
					pb_graph_node->child_pb_graph_nodes[i][j][k].num_input_ports, \
					pb->rr_graph, net_order, config_array, config_array_size, fp, fp_sdc);
				config_set_block_rec(&pb->child_pbs[j][k], net_order, \
					config_array, config_array_size, fp, fp_sdc);
			}
		}
	}
	config_set_pins(pb_graph_node->output_pins, \
		pb_graph_node->num_output_ports, \
		pb->rr_graph, net_order, config_array, config_array_size, fp, fp_sdc);
	
	//config_set_empty_block_rec (pb_graph_node, config_array, config_array_size, fp, fp_sdc);
	return;

}

void config_set_empty_pins(t_pb_graph_pin **pb_graph_pins, int num_ports, \
	char** config_array, int* config_array_size, FILE * fp, FILE * fp_sdc) {
		
	int i, j;
	int fan_in, mux_size;
	int config_val = 0;
	
	t_port *port;
	for (i = 0; i < num_ports; i++) {
		port = pb_graph_pins[i][0].port;
		for (j = 0; j < port->num_pins; j++) {
			assert(j == pb_graph_pins[i][j].pin_number);
			assert(pb_graph_pins[i][j].port == port);
			fan_in = pb_graph_pins[i][j].num_input_edges;
			
			//similar to architecture pin connection
			//if fan_in > 1, mux needs to be instantiated
			if (fan_in>1) {			
				mux_size = (int)ceil(log(fan_in)/log(2));
				config_val = 0;	
				fprintf(fp, "\t[%d:%d] (%s[%d].%s[%d]) unused\n", mux_size +*config_array_size-1, *config_array_size, \
					pb_graph_pins[i][j].parent_node->pb_type->name, pb_graph_pins[i][j].parent_node->placement_index, \
					pb_graph_pins[i][j].port->name, pb_graph_pins[i][j].pin_number);
				config_set(mux_size, config_val, config_array, config_array_size, fp);
				
				if (port->type == OUT_PORT)
					fprintf(fp_sdc, "set_disable_timing %s_%d/%s[%d]\n", \
						pb_graph_pins[i][0].parent_node->pb_type->name, \
						pb_graph_pins[i][0].parent_node->placement_index, \
						pb_graph_pins[i][0].port->name, j);			
			}
		} 
	}
}

void config_set_pins(t_pb_graph_pin **pb_graph_pins, int num_ports, \
	s_rr_node *rr_graph_of_cluster, int**** net_order, \
	char** config_array, int* config_array_size, FILE * fp, FILE * fp_sdc) {
		
	int i, j, k, m;
	int fan_in, mux_size;
	int config_val;
	
	int pin_count_in_cluster;
	int edge_pin_count_in_cluster;
	int net_num, new_net_num;
	t_port *port, *edge_port;
	
	//when a LUT is being used as wire mode, the input and output will both have the same net number
	//ex. ith input has 6 inputs, [in[0], in[2], in[4], in[6], out[0], out[1]] //4 ext and 2 feedback
	//in[0] could have net num = 4 but if that's going through LUT to out[0], out[0] will have net num = 4 
	//always pick the input!
	int flag_found_as_input = 0;
	
	for (i = 0; i < num_ports; i++) {
		port = pb_graph_pins[i][0].port;
		for (j = 0; j < port->num_pins; j++) {
			assert(j == pb_graph_pins[i][j].pin_number);
			assert(pb_graph_pins[i][j].port == port);
			fan_in = pb_graph_pins[i][j].num_input_edges;
			
			flag_found_as_input = 0;
			
			//similar to architecture pin connection
			//if fan_in > 1, mux needs to be instantiated
			if (fan_in>1) {
				config_val = 0;	
				if (rr_graph_of_cluster[pb_graph_pins[i][j].pin_count_in_cluster].net_num != OPEN) {
				//	config_val = 0;	
			//	} else {
					pin_count_in_cluster = pb_graph_pins[i][j].pin_count_in_cluster;					
					net_num = rr_graph_of_cluster[pin_count_in_cluster].net_num;
						
					for (k = 0; k < fan_in; k++) {					
						for (m = 0; m < pb_graph_pins[i][j].input_edges[k]->num_input_pins; m++) {
							edge_pin_count_in_cluster = pb_graph_pins[i][j].input_edges[k]->input_pins[m]->pin_count_in_cluster;
							edge_port = pb_graph_pins[i][j].input_edges[k]->input_pins[m]->port;

							if (port->type != OUT_PORT && edge_port->type != OUT_PORT) {
								new_net_num = net_order[1][edge_port->port_index_by_type][pb_graph_pins[i][j].input_edges[k]->input_pins[m]->pin_number][0];
							} else {
								new_net_num = rr_graph_of_cluster[edge_pin_count_in_cluster].net_num;
							}
							//need to take care of
							// 1. mux have repeated inputs (happens in ALU4) - using flag_found_as_input
							// 2. bypass wire output being assigned to itself (happens in pdc) - using placement_index
							if (net_num == new_net_num && !flag_found_as_input) {
								if (port->type == OUT_PORT) {
									config_val = fan_in-k-1;
								}
								else {
									config_val = fan_in-k; //NO -1 for inputs only since there's a GND signal
									if(edge_port->type == IN_PORT || ((edge_port->type == OUT_PORT) && (pb_graph_pins[i][j].input_edges[k]->input_pins[m]->parent_node->placement_index != pb_graph_pins[i][j].parent_node->placement_index))) flag_found_as_input = 1;
									//break;
								}
								fprintf(fp, "%d(%d %d %d %d) ", net_num, pb_graph_pins[i][j].input_edges[k]->input_pins[m]->parent_node->placement_index, edge_port->type, config_val, edge_pin_count_in_cluster);
							}  else {
								if (port->type == OUT_PORT) {
									fprintf(fp_sdc, "set_disable_timing %s_%d/%s[%d]\n", \
										pb_graph_pins[i][0].input_edges[k]->input_pins[m]->parent_node->pb_type->name, \
										pb_graph_pins[i][0].input_edges[k]->input_pins[m]->parent_node->placement_index, \
										pb_graph_pins[i][0].input_edges[k]->input_pins[m]->port->name, j);	
								}
							}
						}
						//if (flag_found_as_input) break;
					}
				}		
				mux_size = (int)ceil(log(fan_in)/log(2));
				fprintf(fp, "\t[%d:%d] (%s[%d].%s[%d]) [%d]\n",mux_size +*config_array_size-1, *config_array_size, \
					pb_graph_pins[i][j].parent_node->pb_type->name, pb_graph_pins[i][j].parent_node->placement_index, \
					pb_graph_pins[i][j].port->name, pb_graph_pins[i][j].pin_number, config_val);
				config_set(mux_size, config_val, config_array, config_array_size, fp);
				
				if (port->type == IN_PORT && config_val==0) {
					fprintf(fp_sdc, "set_disable_timing %s_%d/%s[%d]\n", \
						pb_graph_pins[i][0].parent_node->pb_type->name, \
						pb_graph_pins[i][0].parent_node->placement_index, \
						pb_graph_pins[i][0].port->name, j);	
				} else if (port->type == IN_PORT) {
					for (k=0; k<fan_in+1; k++) {
						if (config_val!=k) {
							fprintf(fp_sdc, "set_disable_timing mux_%d/in[%d]\n", \
								j*(mux_size+2*(mux_size>3))+((67+(mux_size+2*(mux_size>3))*8)*pb_graph_pins[i][0].parent_node->placement_index), k);	
						
						}
					}
				}
			}
		} 
	}
}

void config_set_LUT(t_pb *pb, int fle_num,\
	char** config_array, int* config_array_size, FILE * fp, FILE * fp_sdc) {
	
	int a_net, p_net, p_pin_count;
	int i, j, k;
	
	int *lut_pin_remap;
	int num_input;
	int lut_mode;

	s_linked_vptr *row;
	char *output, *original, *copy;
	s_linked_vptr* head_truth_table;

	assert (pb != NULL);

	head_truth_table = (s_linked_vptr*)malloc(sizeof(s_linked_vptr));
	num_input = find_number_of_inputs(pb);

	lut_pin_remap = (int*)malloc(num_input*sizeof(int));

	if (pb->mode == 1) {// LUT MODE (NOT WIRE MODE)
		lut_mode = 1;
		
		pb = &pb->child_pbs[0][0];
		for (j=0; j<num_input; j++) {
			p_pin_count = pb->pb_graph_node->input_pins[0][j].pin_count_in_cluster;
			p_net = pb->parent_pb->rr_graph[p_pin_count].net_num;			
			if (p_net == OPEN) {
				lut_pin_remap[j] = OPEN;
				continue;
			}
			for (k=0; k<num_input; k++) {
				a_net = logical_block[pb->logical_block].input_nets[0][k];
				if (a_net == p_net) {
					lut_pin_remap[j] = k;
					//fprintf(fp, "\t\t%d: %d (%d)\n", j, k, a_net);
				}
			}
		}

		s_linked_vptr* curr_row = head_truth_table;
	
		for(row=logical_block[pb->logical_block].truth_table; row!=NULL; row=row->next){
	
			original = (char*)row->data_vptr;		
			curr_row->data_vptr = (char*)malloc((num_input+3)*sizeof(char));
			copy = (char*)curr_row->data_vptr;
			
			strcpy(copy, original);
			
			//blif lines are stored x1x2x3x4[space][0/1]\0
			copy[num_input] = ' '; //space
			
			if (original[strlen(original)-1] == '0') copy[num_input+1] = '0'; //leads to 0
			else copy[num_input+1] = '1'; //leads to 1
			
			copy[num_input+2] = '\0'; //last line
			
			for (i=0; i<num_input; i++) {
				if (lut_pin_remap[i] != OPEN) {
					copy[num_input-i-1] = original[lut_pin_remap[i]];
				} else {	
					copy[num_input-i-1] = '-';
				}
			}
			

			if (row->next == NULL) curr_row->next = NULL;
			else {
				curr_row->next = (s_linked_vptr*)malloc(sizeof(s_linked_vptr));
				curr_row = curr_row->next;
			}
			//fprintf(fp, "\t\t%s -> %s\n", original, copy);
		}
	} else { //WIRE MODE
		lut_mode = 0;
		for (j=0; j<num_input; j++) {
			p_pin_count = pb->pb_graph_node->input_pins[0][j].pin_count_in_cluster;
			p_net = pb->parent_pb->rr_graph[p_pin_count].net_num;			
			if (p_net == OPEN) {
				lut_pin_remap[j] = OPEN;
			} else {
				lut_pin_remap[j] = 1;
			}
		}

		head_truth_table->data_vptr = (char*)malloc((num_input+3)*sizeof(char));
		copy = (char*)head_truth_table->data_vptr;
		for (i=0; i<num_input; i++) {
			if (lut_pin_remap[i] != OPEN) {
				copy[num_input-i-1] = '1';
			} else {
				copy[num_input-i-1] = '-';
			}
		}
		copy[i] = ' ';
		copy[i+1] = '1';
		copy[i+2] = '\0';
		head_truth_table->next = NULL;
		
		//fprintf(fp, "\t\t1 1 -> %s\n", copy);
		
	}
	
	for (i=0; i<num_input; i++) {
		//fprintf(fp, "\t\t\t%d -> %d\n", i, lut_pin_remap[i]);
	}
	
	output = load_truth_table_without_pb(num_input, head_truth_table);
	free (head_truth_table);

	fprintf(fp, "\t[%d:%d] (LUT %s mode %d) ", \
		(int)pow(2, num_input)+*config_array_size-1, *config_array_size, pb->name, \
		lut_mode);

	for (i=(int)pow(2, num_input)-1; i>=0; i--) {
		config_set(1, output[i]-'0', config_array, config_array_size, fp);
		fprintf(fp, "%c", output[i]);
	}
	fprintf(fp, "\n");
}

char *load_truth_table_without_pb(int inputs , s_linked_vptr *truth_table)
{
  int number_of_dont_cares=0;
  int tries,shift,which_row,i,j;
  int possibles = 1 << inputs;
  char *tt_row_blif;
  char *possible_row = (char *)malloc(inputs+1 * sizeof(char));
  char *tt = (char *)malloc((possibles+1) * sizeof(char));
  struct s_linked_vptr *current;
  int number_of_used_inputs_to_lut;
  char set_to;
  assert(possible_row);
  assert(tt);
 
  if (truth_table) { // ??? janders ???? how can you have a LUT without a truth table???
    tt_row_blif =  (char *)truth_table->data_vptr;
  }
  else { // must be producing a GROUND
    for (i = 0; i < possibles; i++)
      tt[i] = '0';
    tt[possibles] = '\0';
    free(possible_row);
    return tt;
  }
  set_to = tt_row_blif[strlen(tt_row_blif)-1];

  /*filling the truth table with the state that is opposite to the output state in the blif truth table*/
  if(set_to =='1')
    {
      for(i=0 ; i<possibles ; i++)
        {
          tt[i]='0';
        }
    }
  else{
    for(i=0 ; i<possibles ; i++)
      {
        tt[i]='1';
      }
  }
  tt[possibles] = '\0';/*null terminating the tt string*/
  /*The code bellow will populate the tt[] array with the truth table of the LUT with "pb"
    
    The truth table is stored as a linked list in the VPR. Each node in the linked list stores one line of the truth table. This line is in the exact same format as in the blif file. Each line of the truth table is read by traversing through each node of the linked list. The code bellow then parses each line of the truth table. That line might not have all the inputs to the lut specified, or there could be don't cares in that line of the truth table. at the end we need the output value of the LUT for every possible combination of inputs, which is not given in the blif truth table.

  The code bellow first counts the number of don't cares in that line of the truth table. It also creates a temporary string "possible_row". and there are n=2^(number of don't cares) possibilities in a particular line of the truth table So in a separate loop we find the nth possibility of the truth table*/

  for(current=truth_table ; current!=NULL ; current=current->next)/*traversing through all the lines of the blif truth table*/
    {
      tt_row_blif=(char *)current->data_vptr;/*tt_row_blif stores the current truth table line*/

      /*counting number of don't cares in this line of the blif truth table*/
      number_of_used_inputs_to_lut = strlen(tt_row_blif)-2;/*used*/
      if(number_of_used_inputs_to_lut == 0)/*If this is a constant generator, then the truth table only contains the constant value that it generates.*/
        {
          for(i=0 ; i<possibles ; i++)
            {
              tt[i] = tt_row_blif[1];
            }
        }
      else{
        for(i=0; i<inputs ; i++)
          {
            if(tt_row_blif[i] == '-')
              {
                number_of_dont_cares++;
              }
          }
        tries = 1 << number_of_dont_cares;/*how many possibilities are there for this line of the blif truth table*/

        for(i=0 ; i<(tries) ; i++)/*traverse through all the possibilities for this line of the blif truth table*/
          {
            shift=number_of_dont_cares-1;
            for(j=0 ; j<number_of_used_inputs_to_lut ; j++)/*going through all the columns of the blif truth table*/
              {
                if(tt_row_blif[j]=='-')/*if this column represents a don't care*/
                  {
                    /*creating a temporary truth table row by taking different values of the possiblity 'i' depending on the shift value*/
                    if(((i>>shift) & 0x1) == 1)
                      {
                        possible_row[j] = '1';
                      }
                    else{
                      possible_row[j] = '0';
                    }
                    shift--;/*reduce the shift value by one*/
                  }
                else
                  {
                    possible_row[j]=tt_row_blif[j];
                  }
              }
            possible_row[j]=0x0;/*null terminate the temporary truth table row*/
            which_row = find_index(possible_row,inputs);/*find index returns the index of the 64bit truth table that this temporary truth table row corresponds to*/
            tt[possibles-1-which_row] = set_to;
          }
      }
      number_of_dont_cares = 0;
    }
  free(possible_row);
  return(tt);
}



