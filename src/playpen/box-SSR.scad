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

Author(s) / Copyright (s): Bo Herrmannsen, Bruno Girin 2013
*/

include <settings-SSR.scad>;
include <../main/box-common.scad>;
include <../main/bitmap.scad>;


module layer_0_0(thickness=layer_0_0_thickness) {
    difference() {
        box_base(thickness);
        box_mounting_holes(thickness);
        box_wall_mount_screw_holes(thickness);
        translate([0, 0, -0.1])
            nut_recesses(nut_recess_height);
    }
}

module layer_0_1(thickness=layer_0_1_thickness) {
    difference() {
        box_spacer_layer(thickness);
    }
}

module layer_0_2(thickness=layer_0_2_thickness) {
    difference() {
        box_spacer_layer(thickness);
    }
}

module layer_0_3(thickness=box_layer_thickness) {
    box_spacer_layer(thickness);
}

module layer_0_4(thickness=box_layer_thickness) {
    difference() {
        box_spacer_layer(thickness);
        
        box_outside_hole(
            wire_hole_controller_side,
            wire_hole_controller_width,
            box_wall_width + 0.1,
            wire_hole_controller_offset,
            thickness
        );
        
    }
}

module layer_0_5(thickness=box_layer_thickness) {
    box_spacer_layer(layer_0_5_thickness);
}

module layer_0() {
    difference() {
        union() {
            layer_0_0(layer_0_0_thickness);
            translate([0, 0, layer_0_0_thickness - 0.1])
                layer_0_1(layer_0_1_thickness + 0.1);
            translate([0, 0, layer_0_0_thickness + layer_0_1_thickness - 0.1])
                layer_0_2(layer_0_2_thickness + 0.1);
            translate([0, 0, layer_0_0_thickness + layer_0_1_thickness + layer_0_2_thickness - 0.1])
                layer_0_3(layer_0_3_thickness + 0.1);
            translate([0, 0, layer_0_0_thickness + layer_0_1_thickness + layer_0_2_thickness + layer_0_3_thickness - 0.1])
                layer_0_4(layer_0_4_thickness + 0.1);
            translate([0, 0, layer_0_0_thickness + layer_0_1_thickness + layer_0_2_thickness + layer_0_3_thickness + layer_0_4_thickness - 0.1])
                layer_0_5(layer_0_5_thickness + 0.1);
        }
        for ( hoffset = [-10 : 5 : 10] ) {
            ventilation_slit(TOP, layer_0_5_thickness - 4, box_wall_width, hoffset, layer_0_thickness_base + 2);
            ventilation_slit(BOTTOM, layer_0_5_thickness - 4, box_wall_width, hoffset, layer_0_thickness_base + 2);
            ventilation_slit(RIGHT, layer_0_5_thickness - 4, box_wall_width, hoffset, layer_0_thickness_base + 2);
            ventilation_slit(LEFT, layer_0_5_thickness - 4, box_wall_width, hoffset, layer_0_thickness_base + 2);
        }
        translate ([
                wire_hole_mains_offset_x,
                -box_total_length / 2 + box_wall_width / 2,
                layer_0_0_thickness + wire_hole_mains_offset_z + wire_hole_mains_radius]) {
            rotate (a = 90, v = [1,0,0])
            cylinder (
                h = box_wall_width + 0.2,
                r=wire_hole_mains_radius,
                $fn=cylinder_resolution, center = true);
        }
    }
}


module layer_1() {
    difference() {
        union() {
            difference() {
                box_base(layer_1_thickness);
                box_mounting_holes(layer_1_thickness);
                
                /* SSR label */
                translate([
                    -label_ssr_char_count * 3 * label_block_size,
                    central_hole_radius * 5,
                    layer_1_thickness - label_recess_depth + 0.1
                    ])
                rotate(a = -90, v = [0, 0, 1])
                    8bit_str(label_ssr_chars, label_ssr_char_count, label_block_size, label_recess_depth + 0.1);
                /* OpenTRV label */
                translate([
                    -label_opentrv_char_count * 3.5 * label_block_size,
                    -pcb_length / 4,
                    layer_1_thickness - label_recess_depth + 0.1
                    ])
                rotate(a = -90, v = [0, 0, 1])
                    8bit_str(label_opentrv_chars, label_opentrv_char_count, label_block_size, label_recess_depth + 0.1);
                /* Recesses */
                translate([0, 0, layer_1_thickness - bolt_head_recess_height])
                    nut_recesses(bolt_head_recess_height);

                /* LED hole */
                translate([0, 0, -0.1])
                cylinder (h = layer_1_thickness + 0.2, r=led_hole_radius, $fn=cylinder_resolution);
            }
        }
        
    }
}

if(box_layout == BOX_LAYOUT_STACKED) {
    layer_0();

    translate([0, 0, layer_0_thickness + box_layout_spacing])
    layer_1();
} else {
    translate([
        -(box_total_width + box_layout_spacing) / 2,
        0,
        0])
    layer_0();

    translate([
         (box_total_width + box_layout_spacing) / 2,
        0,
        0])
    layer_1();
    
    if(use_lilypads == true) {
        /* Side lilypads (elliptical) */
        translate([0, box_total_length/2, 0])
        scale([1, 0.5, 1])
        cylinder(h = lilypad_height, r = lilypad_large_radius);
        
        translate([0, -box_total_length/2, 0])
        scale([1, 0.5, 1])
        cylinder(h = lilypad_height, r = lilypad_large_radius);
        
        /* Corner lilypads */
        translate([
            box_total_width + box_layout_spacing/2,
            box_total_length/2,
            0])
        cylinder(h = lilypad_height, r = lilypad_small_radius);

        translate([
            box_total_width + box_layout_spacing/2,
            -box_total_length/2,
            0])
        cylinder(h = lilypad_height, r = lilypad_small_radius);

        translate([
            -box_total_width - box_layout_spacing/2,
            box_total_length/2,
            0])
        cylinder(h = lilypad_height, r = lilypad_small_radius);

        translate([
            -box_total_width - box_layout_spacing/2,
            -box_total_length/2,
            0])
        cylinder(h = lilypad_height, r = lilypad_small_radius);
    }
}

