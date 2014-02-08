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
layer_1_0_thickness = 3; /* Same as learn button zoffset */
layer_1_1_thickness = 4; /* Same as learn button diameter */
layer_1_thickness = layer_1_0_thickness + layer_1_1_thickness;
layer_3_thickness = box_layer_thickness;
layer_2_thickness = box_height - layer_0_thickness - layer_1_thickness - layer_3_thickness;

/* USB connector position */
usb_connector_side = LEFT;
usb_connector_offset = 12;

/* Wire holes */
/* Boiler and power served by same hole */
wire_hole_boiler_power_side = LEFT;
wire_hole_boiler_power_width = 12;
wire_hole_boiler_power_offset = 0;
wire_hole_antenna_width = 3;
wire_hole_antenna_side = TOP;
wire_hole_antenna_offset = 17.5;

/* Potentiometer */
pot_hole_side = RIGHT;
pot_hole_radius = 3;
pot_hole_zoffset = 7;
pot_hole_offset = 0;

/* Learn buttons */
learn_buttons_side = RIGHT;
learn_buttons_radius = 2;
learn_buttons_zoffset = 3;
learn_buttons_offset = 14; /* same offset for both each side of pot */

/* FTDI connector */
ftdi_hole_side = TOP;
ftdi_hole_offset = -10;
ftdi_hole_width = 18;
ftdi_hole_zoffset = 2;

/* LED */
led_hole_xoffset = 0;
led_hole_yoffset = 15;
led_hole_radius = 2.5;

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
nut_recess_height = 2;
bolt_head_recess_height = 1;

/* Red button dimensions */
red_button_xwidth = 16;
red_button_ywidth = 14;
red_button_margin = 2;
red_button_clip_margin = 2;
red_button_clip_extent = 4;
red_button_panel_thickness = 1.5;
red_button_panel_zoffset = 5;
red_button_panel_xwidth = red_button_xwidth + 2 * red_button_clip_extent + 2 * red_button_margin;
red_button_panel_ywidth = red_button_ywidth + 2 * red_button_margin;
red_button_clip_xwidth = red_button_xwidth + 2 * red_button_clip_extent;
red_button_clip_ywidth = red_button_ywidth - 2 * red_button_clip_margin;
red_button_clip_height = red_button_panel_zoffset - red_button_panel_thickness;

