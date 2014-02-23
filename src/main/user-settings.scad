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

/*
This file stores basic settings that users can change to adapt the render to
their 3D printer.
*/

/*
Specify how the different layers of the box should be laid out:
- BOX_LAYOUT_PRINT is the default setting and used to lay out all layers side
  by side so that they can all be printed in one go.
- BOX_LAYOUT_STACKED lays out the different layers one on top of each other
  with a small space in between: this is useful to show how the box is
  assembled.
- BOX_LAYOUT_1LAYER_PRINT is used to lay out several copies of a single layer
  side by side so that a given printer can be dedicated to a specific layer.
*/
BOX_LAYOUT_PRINT = 0;
BOX_LAYOUT_STACKED = 1;
BOX_LAYOUT_1LAYER_PRINT = 2;
box_layout = BOX_LAYOUT_PRINT;

/*
Parameters specific to the BOX_LAYOUT_1LAYER_PRINT option
- layer_to_print is the number of the layer to print, starting with 0 for the
  bottom layer.
- n_prints_x is the number of prints in the X dimension.
- n_prints_y is the number of prints in the Y dimension.
*/
layer_to_print = 0;
n_prints_x = 3;
n_prints_y = 2;

/*
Specify the fudge ratio for the screw holes and the PCB hole. This is a value
between 0 and 1 with 0 meaning no fudge and 1 meaning maximum fudge.
A value of 0 would typically be used when printing with a high quality printer
while a value of 1 ensures more tolerance around holes.
*/
fudge_ratio = 1;

/*
Specify whether to use lilypads to prevent warping when printing.
*/
use_lilypads = true;


