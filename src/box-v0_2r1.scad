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

include <settings-v0_2r1.scad>;
include <box-common.scad>;

module layer_0_0(thickness=box_layer_thickness) {
    difference() {
        box_base(thickness);
        box_mounting_holes(thickness);
        box_wall_mount_screw_holes(thickness);
    }
}

module layer_0_1(thickness=box_layer_thickness) {
    difference() {
        box_spacer_layer(thickness);
        box_outside_hole(
            usb_connector_side,
            usb_cable_width,
            box_wall_width + 0.1,
            usb_connector_offset,
            thickness
        );
    }
}

module layer_0_2(thickness=box_layer_thickness) {
    difference() {
        box_base(thickness);
        pcb_hole(thickness, hole_fudge_factor);
        box_outside_hole(
            usb_connector_side,
            usb_cable_width,
            box_wall_width + 0.1,
            usb_connector_offset,
            thickness
        );
    }
}

module layer_0() {
    union() {
        layer_0_0();
        translate([0, 0, box_layer_thickness - 0.1])
            layer_0_1(2 * box_layer_thickness + 0.1);
        translate([0, 0, 3 * box_layer_thickness - 0.1])
            layer_0_2(pcb_thickness + 0.1);
    }
}

layer_0();

