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

use <include/iso261-extended.scad>;
include <settings-trv.scad>;

int_radius = screw_diameter / 2;
ext_radius = int_radius + screw_thickness;
bevel_thickness = 1;
bevel_r1 = ext_radius - bevel_thickness;
bevel_r2 = bevel_r1 + screw_height;
lip_radius = int_radius - 1;
lip_thickness = 1;
thread_height = screw_height / 2;
screw_scale = 1 + screw_tolerance;
protusion_angle = 360 / screw_protusion_number;

scale([screw_scale, screw_scale, 1])
intersection() {
    union() {
        difference() {
            cylinder(h = screw_height, r = ext_radius);
            translate([0, 0, screw_height - thread_height - 0.5])
                M30x1_5_int(thread_height + 1);
            translate([0, 0, lip_thickness])
                cylinder(h = screw_height - thread_height - lip_thickness,
                    r = int_radius);
            translate([0, 0, -0.5])
                cylinder(h = lip_thickness + 1, r = lip_radius);
        }
        for ( a = [-180 : protusion_angle : 179] ) {
            rotate( a = a, v = [0, 0, 1] )
            translate( [ext_radius, 0, 0] )
            cylinder(h = screw_height, r = 1);
        }
    }
    cylinder(h = screw_height, r1 = bevel_r1, r2 = bevel_r2);
}

