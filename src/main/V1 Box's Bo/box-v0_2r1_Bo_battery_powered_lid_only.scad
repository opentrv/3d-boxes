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

include <settings-v0_2r1_Bo_battery_powered.scad>;
include <box-common.scad>;
include <bitmap.scad>;



module spacer() {
    cylinder(
        r1 = 2nd_board_spacer_radius,
        r2 = 2nd_board_spacer_radius * 1.5,
        h = 2nd_board_spacer_height + 0.1,
        $fn=cylinder_resolution);
}

module spacers() {
    corner_offset = 2nd_board_spacer_radius * sqrt(2) / 2;
    difference() {
        union() {
            translate([
                    -2nd_board_spacer_distance_x / 2,
                     2nd_board_spacer_distance_y / 2,
                     0])
                spacer();
            translate([
                     2nd_board_spacer_distance_x / 2,
                     2nd_board_spacer_distance_y / 2,
                     0])
                spacer();
            translate([
                    -2nd_board_spacer_distance_x / 2,
                    -2nd_board_spacer_distance_y / 2,
                     0])
                spacer();
            translate([
                     2nd_board_spacer_distance_x / 2,
                    -2nd_board_spacer_distance_y / 2,
                     0])
                spacer();
        }
        translate([
                -2nd_board_spacer_distance_x / 2 + corner_offset,
                -2nd_board_spacer_distance_y / 2 + corner_offset,
                -0.1])
            cube(size = [
                2nd_board_spacer_distance_x - corner_offset * 2,
                2nd_board_spacer_distance_y - corner_offset * 2,
                2nd_board_spacer_height + 0.3]);
    }
}

module spacer_hole() {
    translate([0, 0, -0.1])
        cylinder(
            r = 2nd_board_spacer_hole_radius,
            h = 2nd_board_spacer_hole_height + 0.1,
            $fn=cylinder_resolution);
}

module spacer_holes() {
    translate([
            -2nd_board_spacer_distance_x / 2,
             2nd_board_spacer_distance_y / 2,
             0])
        spacer_hole();
    translate([
             2nd_board_spacer_distance_x / 2,
             2nd_board_spacer_distance_y / 2,
             0])
        spacer_hole();
    translate([
            -2nd_board_spacer_distance_x / 2,
            -2nd_board_spacer_distance_y / 2,
             0])
        spacer_hole();
    translate([
             2nd_board_spacer_distance_x / 2,
            -2nd_board_spacer_distance_y / 2,
             0])
        spacer_hole();
}

module layer_3() {
    corner_offset = 2nd_board_spacer_radius * sqrt(2) / 2;
    difference() {
        union() {
            difference() {
                box_base(layer_3_thickness);
                box_mounting_holes(layer_3_thickness);
                /* Hole for buttons and LED */
                
                /* LED hole */
                translate([14, 10.5, -0.1])
                cylinder (
                    h = layer_3_thickness + 0.2,
                    r = led_hole_radius + hole_fudge_factor,
                    $fn = cylinder_resolution);

                /* LDR hole */
                translate([-6.5, 10.5, -0.1])
                cylinder (
                    h = layer_3_thickness + 0.2,
                    r = ldr_hole_radius + hole_fudge_factor,
                    $fn = cylinder_resolution);

                /* Learn hole */
                translate([7.9, 10.1, -0.1])
                cylinder (
                    h = layer_3_thickness + 0.2,
                    r = learn_hole_radius + hole_fudge_factor,
                    $fn = cylinder_resolution);

                /* Mode hole */
                translate([0.1, 10.1, -0.1])
                cylinder (
                    h = layer_3_thickness + 0.2,
                    r = mode_hole_radius + hole_fudge_factor,
                    $fn = cylinder_resolution);

                /* Learn label */
                translate([
                    2nd_board_spacer_distance_x / 5.8 + 2nd_board_offset_x,
                    2nd_board_spacer_distance_y / 1.5 + 2nd_board_offset_y,
                    layer_3_thickness - label_recess_depth + 0.5
                    ])
                rotate(a = -90, v = [0, 0, 1])
                    8bit_str(label_learn_chars, label_learn_char_count, label_block_size, label_recess_depth + 0.1);
                /* Model label */
                translate([
                    -2nd_board_spacer_distance_x / 9.5 + 2nd_board_offset_x,
                    2nd_board_spacer_distance_y / 1.5 + 2nd_board_offset_y,
                    layer_3_thickness - label_recess_depth + 0.1
                    ])
                rotate(a = -90, v = [0, 0, 1])
                    8bit_str(label_mode_chars, label_mode_char_count, label_block_size, label_recess_depth + 0.1);
                
                /* Recesses */
                translate([0, 0, layer_3_thickness - bolt_head_recess_height - cylinder_bridge_height])
                    nut_recesses(bolt_head_recess_height + cylinder_bridge_height);
            }
            translate([2nd_board_offset_x, 2nd_board_offset_y, -2nd_board_spacer_height])
                spacers();
            translate([0, 0, layer_3_thickness - bolt_head_recess_height])
            rotate(v=[1, 0, 0], a=180)
                cylinder_bridges(pcb_mounting_hole_radius + hole_fudge_factor, nut_recess_radius);
        }
        translate([2nd_board_offset_x, 2nd_board_offset_y, -2nd_board_spacer_height])
            spacer_holes();
    }
}

if(box_layout == BOX_LAYOUT_STACKED) {
    layer_0();

    translate([0, 0, layer_0_thickness + box_layout_spacing])
    layer_1();

    translate([0, 0, layer_0_thickness + layer_1_thickness + 2 * box_layout_spacing])
    layer_2();

    translate([0, 0, layer_0_thickness + layer_1_thickness + layer_2_thickness + 3 * box_layout_spacing])
    layer_3();
} else {
    translate([
        -(box_total_width + box_layout_spacing) / 2,
        -(box_total_length + box_layout_spacing) / 2,
        0])
    layer_0();

    translate([
         (box_total_width + box_layout_spacing) / 2,
        -(box_total_length + box_layout_spacing) / 2,
        0])
    layer_1();

    translate([
        -(box_total_width + box_layout_spacing) / 2,
         (box_total_length + box_layout_spacing) / 2,
        0])
    layer_2();

    translate([
         (box_total_width + box_layout_spacing) / 2,
         (box_total_length + box_layout_spacing) / 2,
        layer_3_thickness])
    rotate(a = 180, v = [1, 0, 0])
    layer_3();
    
    if(use_lilypads == true) {
        /* Center lilypad */
        cylinder(h = lilypad_height, r = lilypad_large_radius);
        
        /* Side lilypads (elliptical) */
        translate([box_total_width + box_layout_spacing/2, 0, 0])
        scale([0.5, 1, 1])
        cylinder(h = lilypad_height, r = lilypad_large_radius);
        
        translate([-box_total_width - box_layout_spacing/2, 0, 0])
        scale([0.5, 1, 1])
        cylinder(h = lilypad_height, r = lilypad_large_radius);
        
        translate([0, box_total_width + box_layout_spacing/2, 0])
        scale([1, 0.5, 1])
        cylinder(h = lilypad_height, r = lilypad_large_radius);
        
        translate([0, -box_total_width - box_layout_spacing/2, 0])
        scale([1, 0.5, 1])
        cylinder(h = lilypad_height, r = lilypad_large_radius);
        
        /* Corner lilypads */
        translate([
            box_total_width + box_layout_spacing/2,
            box_total_width + box_layout_spacing/2,
            0])
        cylinder(h = lilypad_height, r = lilypad_small_radius);

        translate([
            box_total_width + box_layout_spacing/2,
            -box_total_width - box_layout_spacing/2,
            0])
        cylinder(h = lilypad_height, r = lilypad_small_radius);

        translate([
            -box_total_width - box_layout_spacing/2,
            box_total_width + box_layout_spacing/2,
            0])
        cylinder(h = lilypad_height, r = lilypad_small_radius);

        translate([
            -box_total_width - box_layout_spacing/2,
            -box_total_width - box_layout_spacing/2,
            0])
        cylinder(h = lilypad_height, r = lilypad_small_radius);
    }
}

