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

/*
PCB board measurements

All measurements and placements are taken such that the version number (V0.09)
is facing the right way up.
*/
/* The basic measurements of the PCB */
pcb_width = 47;
pcb_length = 46;
pcb_thickness = 1.7;
/* There are four mounting holes in each corner of the PCB */
pcb_mounting_hole_radius = 1.5; /* Fits an M3 bolt */
pcb_mounting_hole_to_edge = 0.8;
pcb_mounting_hole_max_padding = 1.5;

/* Settings for the box itself */
box_wall_width = 3;
box_layer_thickness = 3;
box_corner_radius = 2;

/*
Valve attachment measurements

All measurements below are used by the test valve connector.
*/

// Screw attributes. At the moment, the only supported combination is:
// diameter: 30, pitch:1.5
screw_diameter=30;
screw_pitch=1.5;
// The screw tolerance allows the screw connector to be scale slightly in order
// to give a bit of tolerance to how snuggly the screw fits the valve
screw_tolerance=0.01;
screw_height=10;
screw_thickness=2;
screw_protusion_number=12;

// Connector attributes
connector_height=15;
connector_slit_number=8; // this has to be an even number (for the moment)
connector_slit_thickness=2;
connector_slit_offset=3;
connector_plate_thickness=1;

