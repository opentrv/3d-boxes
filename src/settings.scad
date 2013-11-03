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

/* General constants */
TOP    = 0;
RIGHT  = 1;
BOTTOM = 2;
LEFT   = 3;

cylinder_resolution = 180;

/* Settings for the box itself */
box_wall_width = 3;
box_layer_thickness = 3;
box_corner_radius = 2;

/* Small fudge factor to increase holes by in order to take into account
   cooling of the PLA
 */
hole_fudge_factor = 0.2;

pcb_mounting_hole_radius = 1.5; /* Fits an M3 bolt */
pcb_mounting_hole_max_padding = 1.5;
pcb_mounting_hole_to_edge = 1;
pcb_thickness = 2;

wall_mount_screw_hole_cutout_radius = 1.5;
wall_mount_screw_hole_cutout_thickness = 0.5;
wall_mount_screw_hole_cutout_ratio = 1;

prog_cable_radius = 5;
prog_jack_width = 6.2;
prog_jack_depth = 18;
prog_jack_surround_thickness = 2;

usb_connector_width = 8;
usb_connector_height = 3;
usb_cable_width = 13;
usb_cable_height = 7;

