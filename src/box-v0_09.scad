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

include <settings-v0_09.scad>;
include <box-common.scad>;

module box_layer0() {
    difference() {
        box_base();
        box_mounting_holes();
    }
}

module box_layer1() {
    difference() {
        union() {
            box_spacer_layer();
            box_inside_tab(RIGHT, 7, 3, 9);
            box_inside_tab(RIGHT, 5, 3, -8);
            box_inside_tab(LEFT, 36, 2, 0);
            box_inside_tab(BOTTOM, 6, 3, 16);
            box_inside_tab(BOTTOM, 6, 3, -16);
            box_inside_tab(TOP, 28, 2, 0);
        }
        box_outside_hole(
            prog_jack_side,
            2 * prog_cable_radius,
            box_layer_thickness,
            prog_jack_offset
        );
    }
}

module box_layer2() {
    difference() {
        box_base();
        pcb_hole();
        box_outside_hole(
            prog_jack_side,
            2 * prog_cable_radius,
            box_layer_thickness + 0.1,
            prog_jack_offset
        );
    }
}

module box_layer3() {
    difference() {
        union() {
            box_spacer_layer();
            box_inside_tab(
                prog_jack_side,
                2 * prog_cable_radius + 2 * box_layer_thickness,
                box_layer_thickness,
                prog_jack_offset
            );
            box_inside_tab(
                prog_jack_side,
                prog_jack_width + prog_jack_surround_thickness,
                prog_jack_depth + prog_jack_surround_thickness,
                prog_jack_offset
            );
        }
        box_outside_hole(
            prog_jack_side,
            2 * prog_cable_radius,
            box_layer_thickness,
            prog_jack_offset
        );
        box_outside_hole(
            prog_jack_side,
            prog_jack_width,
            box_layer_thickness + prog_jack_depth,
            prog_jack_offset
        );
    }
}


translate([0, 0, -15])
box_layer0();

translate([0, 0, -5])
box_layer1();

translate([0, 0, 5])
box_layer2();

translate([0, 0, 15])
box_layer3();

