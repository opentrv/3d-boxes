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
pcb_width = 47;
pcb_length = 46;
pcb_thickness = 1.7;
/* There are four mounting holes in each corner of the PCB */
pcb_mounting_hole_to_edge = 0.8;

/* Programming jack position */
prog_jack_side = LEFT;
prog_jack_offset = -5.5;

