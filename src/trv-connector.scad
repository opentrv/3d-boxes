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

include <./settings-trv.scad>;

screw_radius = screw_diameter / 2;
ext_radius = screw_radius * 13.5 / 15.0;
int_radius = screw_radius * 10.5 / 15.0;
lip_radius = screw_radius * 14.5 / 15.0 + screw_tolerance;
bevel_height = 1;
lip_height = 0.5;
slit_angle = 360 / connector_slit_number;

difference() {
    union() {
        difference() {
            union() {
                cylinder(h = connector_height, r = ext_radius);
                translate([0, 0, connector_height - bevel_height])
                    cylinder(h = bevel_height, r1 = lip_radius, r2 = ext_radius);
                translate([0, 0, connector_height - bevel_height - lip_height])
                    cylinder(h = lip_height, r = lip_radius);
            }
            translate([0, 0, -1])
                cylinder(h = connector_height + 2, r = int_radius);
        }
        cylinder(h = connector_plate_thickness, r = screw_radius);
    }

    for ( i = [0 : connector_slit_number / 2 - 1] ) {
        rotate(a = slit_angle * i, v = [0, 0, 1])
        translate([0, 0, connector_slit_offset]) {
            union() {
                rotate(a = 90, v = [0, 1, 0])
                    translate([0, 0, -screw_radius])
                        cylinder(h = screw_diameter, r = connector_slit_thickness / 2);
                translate([0, 0, screw_radius / 2])
                    cube(size = [screw_diameter, connector_slit_thickness, screw_radius], center = true);
            }
        }
    }
}

