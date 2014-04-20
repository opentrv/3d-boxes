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

include <boiler_control_relay-rev1-settings.scad>;
include <common.scad>;
include <bitmap.scad>;

module layer_0_0(thickness=layer_0_0_thickness) {
    union() {
        difference() {
            box_base(thickness);
            box_mounting_holes(thickness);
            box_wall_mount_screw_holes(thickness);
            translate([0, 0, -0.1])
                nut_recesses(nut_recess_height + cylinder_bridge_height);
        }
        translate([0, 0, nut_recess_height])
            cylinder_bridges(pcb_mounting_hole_radius + hole_fudge_factor, nut_recess_radius);
    }
}

module layer_0_1(thickness=layer_0_1_thickness) {
    difference() {
        box_spacer_layer(thickness, thickness / 2, 1.2);
        
    }
}

module layer_0_2(thickness=layer_0_2_thickness) {
    difference() {
        box_base(thickness);
        pcb_hole(thickness, pcb_fudge_factor);
     
    }
}

module layer_0() {
    difference() {
        union() {
            layer_0_0(layer_0_0_thickness);
            translate([0, 0, layer_0_0_thickness - 0.1])
                layer_0_1(layer_0_1_thickness + 0.1);
            translate([0, 0, layer_0_0_thickness + layer_0_1_thickness - 0.1])
                layer_0_2(layer_0_2_thickness + 0.1);
        }
        for ( hoffset = [-16 : 4 : 16] ) {
            
            
            
        }
        for ( hoffset = [-16 : 4 :  0] ) {
            
        }
    }
}

module layer_1_0(thickness=box_layer_thickness) {
    difference() {
        box_spacer_layer(thickness);
        /* Wire hole for boiler and power */
        box_outside_hole(
            wire_hole_boiler_power_side,
            wire_hole_boiler_power_width,
            box_wall_width + 0.1,
            wire_hole_boiler_power_offset,
            thickness
        );
       /* Wire hole for boiler and power 2*/
        box_outside_hole(
            wire_hole_boiler_power_side2,
            wire_hole_boiler_power_width2,
            box_wall_width + 0.1,
            wire_hole_boiler_power_offset2,
            thickness
        );
    }
}

module layer_1_1(thickness=box_layer_thickness) {
    difference() {
        box_spacer_layer(thickness);
    }
}

module layer_1() {
    difference() {
        union() {
            layer_1_0(layer_1_0_thickness);
            translate([0, 0, layer_1_0_thickness - 0.1])
                layer_1_1(layer_1_1_thickness + 0.1);
        }
       
       

    }
}

module layer_2() {
    difference() {
        box_spacer_layer(layer_2_thickness);
       
        
    }
}

module layer_3() {
    difference() {
        union() {
            box_base(layer_3_thickness);
            
        }
       
        
           
        box_mounting_holes(layer_3_thickness);
        /* OpenTRV Boiler Control label */
        translate([
            -label_opentrv_char_count * 3.5 * label_block_size,
            pcb_length / 8,
            layer_3_thickness - label_recess_depth + 0.1
            ])
        rotate(a = -90, v = [0, 0, 1])
            8bit_str(label_opentrv_chars, label_opentrv_char_count, label_block_size, label_recess_depth + 0.1);
        translate([
            -label_boiler_char_count * 3.5 * label_block_size,
            0,
            layer_3_thickness - label_recess_depth + 0.1
            ])
        rotate(a = -90, v = [0, 0, 1])
            8bit_str(label_boiler_chars, label_boiler_char_count, label_block_size, label_recess_depth + 0.1);
        translate([
            -label_control_char_count * 3.5 * label_block_size,
            -pcb_length / 8,
            layer_3_thickness - label_recess_depth + 0.1
            ])
        rotate(a = -90, v = [0, 0, 1])
            8bit_str(label_control_chars, label_control_char_count, label_block_size, label_recess_depth + 0.1);
        /* Recesses */
        translate([0, 0, layer_3_thickness - bolt_head_recess_height])
            nut_recesses(bolt_head_recess_height);
         /* LED hole */
        translate([led_hole_xoffset, led_hole_yoffset, -0.1])
        cylinder (
            h = layer_3_thickness + 0.2,
            r = led_hole_radius + hole_fudge_factor,
            $fn = cylinder_resolution);
    }
}

module print_layer(n) {
    if ( n == 0 ) {
        layer_0();
    }
    if ( n == 1 ) {
        translate([0, 0, layer_1_thickness])
        rotate(v=[1,0,0], a=180)
        layer_1();
    }
    if ( n == 2 ) {
        translate([0, 0, layer_2_thickness])
        rotate(v=[1,0,0], a=180)
        layer_2();
    }
    if ( n == 3 ) {
        layer_3();
    }
}

if(box_layout == BOX_LAYOUT_STACKED) {
    layer_0();

    translate([0, 0, layer_0_thickness + box_layout_vspacing])
    layer_1();

    translate([0, 0, layer_0_thickness + layer_1_thickness + 2 * box_layout_vspacing])
    layer_2();

    translate([0, 0, layer_0_thickness + layer_1_thickness + layer_2_thickness + 3 * box_layout_vspacing])
    layer_3();
}
if(box_layout == BOX_LAYOUT_PRINT) {
    translate([
        -(box_total_width + box_layout_hspacing) / 2,
        -(box_total_length + box_layout_hspacing) / 2,
        0])
    layer_0();

    translate([
         (box_total_width + box_layout_hspacing) / 2,
        -(box_total_length + box_layout_hspacing) / 2,
        layer_1_thickness])
    rotate(v=[1,0,0], a=180)
    layer_1();

    translate([
        -(box_total_width + box_layout_hspacing) / 2,
         (box_total_length + box_layout_hspacing) / 2,
        layer_2_thickness])
    rotate(v=[1,0,0], a=180)
    layer_2();

    translate([
         (box_total_width + box_layout_hspacing) / 2,
         (box_total_length + box_layout_hspacing) / 2,
        0])
    layer_3();
    
    if(use_lilypads == true) {
        lilypads(2, 2, box_total_width, box_total_length);
    }
}
if(box_layout == BOX_LAYOUT_1LAYER_PRINT) {
    for ( dx = [ -(n_prints_x - 1) / 2 : (n_prints_x - 1) / 2 ] ) {
        for ( dy = [ -(n_prints_y - 1) / 2 : (n_prints_y - 1) / 2 ] ) {
            translate([
                dx * (box_total_width + box_layout_hspacing),
                dy * (box_total_length + box_layout_hspacing),
                0
            ])
            print_layer(layer_to_print);
        }
    }
    
    if(use_lilypads == true) {
        lilypads(n_prints_x, n_prints_y, box_total_width, box_total_length);
    }
}
