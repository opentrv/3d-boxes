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

Author(s) / Copyright (s): Bo Herrmannsen, Bruno Girin 2013
*/

include <../main/user-settings.scad>;
include <../main/settings.scad>;

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



/* Wire holes */

wire_hole_boiler_width = 9;
wire_hole_boiler_side = BOTTOM;
wire_hole_boiler_offset = 15.625;

/* Central hole */
central_hole_radius = 1.5;

/* Labels */
label_ssr_chars = ["S", "S", "R"];
label_ssr_char_count = 3;
label_opentrv_chars = ["O", "p", "e", "n", "T", "R", "V"];
label_opentrv_char_count = 7;
label_block_size = 0.75;
label_recess_depth = layer_3_thickness / 2;

/* Nut and bolt recesses */
nut_recess_radius = 6.25 / 2;
nut_recess_height = 2.4;
bolt_head_recess_height = 1;

