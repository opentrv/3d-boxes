/*
The OpenTRV project licenses this file to you
under the Apache Licence, Version 2.0 (the "Licence");
you may not use this file except in compliance
with the Licence. You may obtain a copy of the Licence at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the Licence is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied. See the Licence for the
specific language governing permissions and limitations
under the Licence.

Author(s) / Copyright (s): Bruno Girin 2013
*/

include <settings.scad>;

/*
PCB board measurements

All measurements and placements are taken such that the version number (V0.09)
is facing the right way up.
*/
/* The basic measurements of the PCB */
pcb_width = 50;
pcb_length = 50;
pcb_thickness = 1.7;

/* Total box height */
box_height = 30;

/* Layer thicknesses */
layer_0_0_thickness = box_layer_thickness;
layer_0_1_thickness = 2 * box_layer_thickness;
layer_0_2_thickness = pcb_thickness;
layer_0_thickness = layer_0_0_thickness + layer_0_1_thickness + layer_0_2_thickness;
layer_1_0_thickness = box_layer_thickness;
layer_1_1_thickness = box_layer_thickness;
layer_1_thickness = layer_1_0_thickness + layer_1_1_thickness;
layer_3_thickness = box_layer_thickness;
layer_2_thickness = box_height - layer_0_thickness - layer_1_thickness - layer_3_thickness;

/* USB connector position */
usb_connector_side = LEFT;
usb_connector_offset = 12;

/* Wire holes */
wire_hole_width = 6;
wire_hole_power_side = TOP;
wire_hole_power_offset = -8.75;
wire_hole_boiler_side = BOTTOM;
wire_hole_boiler_offset = 15.625;
wire_hole_antenna_width = 3;
wire_hole_antenna_side = TOP;
wire_hole_antenna_offset = 18.125;

/* Secondary board spacers */
2nd_board_spacer_height = 4;
2nd_board_spacer_distance_x = 30.2025;
2nd_board_spacer_distance_y = 9.6825;
2nd_board_spacer_hole_height = 2nd_board_spacer_height + 1;
2nd_board_spacer_hole_ratio = 0.7;
2nd_board_spacer_radius = pcb_mounting_hole_radius * 2;

/* Labels */
label_learn_chars = ["L"];
label_learn_char_count = 1;
label_mode_chars = ["M"];
label_mode_char_count = 1;
label_opentrv_chars = ["O", "p", "e", "n", "T", "R", "V"];
label_opentrv_char_count = 7;
label_block_size = 0.75;
label_recess_depth = layer_3_thickness / 2;

/* Nut and bolt recesses */
nut_recess_radius = 6.25 / 2;
nut_recess_height = 2.4;
bolt_head_recess_height = 1;

