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

include <settings-v0p2_rev2.scad>;
include <box-common.scad>;
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
        box_outside_hole(
            usb_connector_side,
            usb_cable_width,
            box_wall_width + 0.1,
            usb_connector_offset,
            thickness
        );
    }
}

module layer_0_2(thickness=layer_0_2_thickness) {
    difference() {
        box_base(thickness);
        pcb_hole(thickness, pcb_fudge_factor);
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
    difference() {
        union() {
            layer_0_0(layer_0_0_thickness);
            translate([0, 0, layer_0_0_thickness - 0.1])
                layer_0_1(layer_0_1_thickness + 0.1);
            translate([0, 0, layer_0_0_thickness + layer_0_1_thickness - 0.1])
                layer_0_2(layer_0_2_thickness + 0.1);
        }
        for ( hoffset = [-16 : 4 : 16] ) {
            ventilation_slit(TOP, 2, layer_0_1_thickness, box_wall_width, hoffset, layer_0_0_thickness);
            ventilation_slit(BOTTOM, 2, layer_0_1_thickness, box_wall_width, hoffset, layer_0_0_thickness);
            ventilation_slit(RIGHT, 2, layer_0_1_thickness, box_wall_width, hoffset, layer_0_0_thickness);
        }
        for ( hoffset = [-16 : 4 :  0] ) {
            ventilation_slit(LEFT, 2, layer_0_1_thickness, box_wall_width, hoffset, layer_0_0_thickness);
        }
    }
}

module layer_1_0(thickness=box_layer_thickness) {
    box_spacer_layer(thickness);
}

module layer_1_1(thickness=box_layer_thickness) {
    difference() {
        box_spacer_layer(thickness);
        box_outside_hole(
            wire_hole_power_side,
            wire_hole_power_width,
            box_wall_width + 0.1,
            wire_hole_power_offset,
            thickness
        );
        box_outside_hole(
            wire_hole_boiler_side,
            wire_hole_boiler_width,
            box_wall_width + 0.1,
            wire_hole_boiler_offset,
            thickness
        );
        box_outside_hole(
            wire_hole_antenna_side,
            wire_hole_antenna_width,
            box_wall_width + 0.1,
            wire_hole_antenna_offset,
            thickness
        );
    }
}

module layer_1() {
    union() {
        layer_1_0(layer_1_0_thickness);
        translate([0, 0, layer_1_0_thickness - 0.1])
            layer_1_1(layer_1_1_thickness + 0.1);
    }
}

module layer_2() {
    box_spacer_layer(layer_2_thickness);
}

module layer_3() {
    difference() {
        union() {
            box_base(layer_3_thickness);
            translate([-red_button_panel_xwidth/2, -red_button_panel_ywidth/2, 0])
            cube(size=[
                red_button_panel_xwidth,
                red_button_panel_ywidth,
                red_button_panel_zoffset + layer_3_thickness]);
        }
        translate([-red_button_xwidth/2, -red_button_ywidth/2, -0.1])
        cube(size=[
            red_button_xwidth,
            red_button_ywidth,
            red_button_panel_zoffset + layer_3_thickness + 0.2]);
        translate([-red_button_clip_xwidth/2, -red_button_clip_ywidth/2, -0.1])
        cube(size=[
            red_button_clip_xwidth,
            red_button_clip_ywidth,
            red_button_clip_height + layer_3_thickness + 0.1]);
        box_mounting_holes(layer_3_thickness);
        /* OpenTRV label */
        translate([
            -label_opentrv_char_count * 3.5 * label_block_size,
            -pcb_length / 4,
            layer_3_thickness - label_recess_depth + 0.1
            ])
        rotate(a = -90, v = [0, 0, 1])
            8bit_str(label_opentrv_chars, label_opentrv_char_count, label_block_size, label_recess_depth + 0.1);
        /* Recesses */
        translate([0, 0, layer_3_thickness - bolt_head_recess_height])
            nut_recesses(bolt_head_recess_height);
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
        0])
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

