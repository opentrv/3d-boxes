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

include <user-settings.scad>;
include <common-settings.scad>;

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
/* Boiler and power served by same hole */
wire_hole_boiler_power_side = LEFT;
wire_hole_boiler_power_width = 11;
wire_hole_boiler_power_offset = -0.5;

wire_hole_power220_side = RIGHT;
wire_hole_power220_radius = 4;
wire_hole_power220_hoffset = 15;

wire_tie_width = 10;
wire_tie_thickness = 1.5;
wire_tie_iwidth = wire_tie_width - 2 * wire_tie_thickness;
wire_tie_depth = 4;
wire_tie_idepth = wire_tie_depth - wire_tie_thickness;
wire_tie_height = wire_hole_power220_radius;
wire_tie_offset = 2;


/* LED */
led_hole_xoffset = -19.49143125;
led_hole_yoffset = 12.538525;
led_hole_radius = 2.5;

/* Labels */
label_opentrv_chars = ["O", "p", "e", "n", "T", "R", "V"];
label_opentrv_char_count = 7;
label_boiler_chars = ["B", "o", "i", "l", "e", "r"];
label_boiler_char_count = 6;
label_control_chars = ["C", "o", "n", "t", "r", "o", "l"];
label_control_char_count = 7;
label_block_size = 0.75;
label_recess_depth = layer_3_thickness / 2;

/* Nut and bolt recesses */
nut_recess_radius = 6.25 / 2;
nut_recess_height = 2;
bolt_head_recess_height = 1;

