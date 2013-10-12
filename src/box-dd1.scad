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

include <settings-dd1.scad>;
include <box-common.scad>;

module box_layer0() {
    difference() {
        box_base();
        box_mounting_holes();
    }
}

module box_layer1(thickness=box_layer_thickness) {
    difference() {
        box_spacer_layer(thickness);
        box_outside_hole(
            prog_jack_side,
            2 * prog_cable_radius,
            box_layer_thickness + 0.1,
            prog_jack_offset,
            thickness
        );
        box_outside_hole(
            prog_jack_side,
            prog_jack_width,
            box_layer_thickness + prog_jack_depth,
            prog_jack_offset,
            thickness
        );
        box_outside_hole(
            capacitor_side,
            capacitor_hole_width,
            box_layer_thickness + 0.1,
            capacitor_hole_offset,
            thickness
        );
    }
}

module box_layer0_1_merged() {
    union() {
        box_layer0();
        translate([0, 0, box_layer_thickness - 0.1])
            box_layer1(2 * box_layer_thickness + 0.1);
    }
}

box_layer0_1_merged();

