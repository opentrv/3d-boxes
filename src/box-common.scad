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

include <settings.scad>;

/* Calculated values */
box_total_width = pcb_width + 2 * box_wall_width;
box_cube_width = box_total_width - 2 * box_corner_radius;
box_total_length = pcb_length + 2 * box_wall_width;
box_cube_length = box_total_length - 2 * box_corner_radius;
mounting_hole_pcb_offset = pcb_mounting_hole_to_edge + pcb_mounting_hole_radius;
mounting_hole_box_offset = box_wall_width + mounting_hole_pcb_offset;

module box_mounting_hole(thickness=box_layer_thickness) {
    translate([0, 0, -0.1])
    cylinder(
        r = pcb_mounting_hole_radius + hole_fudge_factor,
        h = thickness + 0.2,
        $fn=cylinder_resolution);
}

module box_mounting_holes(thickness=box_layer_thickness) {
    union() {
        translate([
            -pcb_width / 2 + mounting_hole_pcb_offset,
            -pcb_length / 2 + mounting_hole_pcb_offset,
            0])
        box_mounting_hole(thickness);
        translate([
            +pcb_width / 2 - mounting_hole_pcb_offset,
            -pcb_length / 2 + mounting_hole_pcb_offset,
            0])
        box_mounting_hole(thickness);
        translate([
            +pcb_width / 2 - mounting_hole_pcb_offset,
            +pcb_length / 2 - mounting_hole_pcb_offset,
            0])
        box_mounting_hole(thickness);
        translate([
            -pcb_width / 2 + mounting_hole_pcb_offset,
            +pcb_length / 2 - mounting_hole_pcb_offset,
            0])
        box_mounting_hole(thickness);
    }
}

module box_mounting_hole_surround(thickness=box_layer_thickness) {
    hull_cube_side = box_wall_width - box_corner_radius;
    surround_radius = pcb_mounting_hole_radius + pcb_mounting_hole_max_padding;
    hull() {
        cylinder(
            r = surround_radius,
            h = thickness,
            $fn=cylinder_resolution);
        translate([mounting_hole_pcb_offset, -surround_radius, 0])
            cube(size = [hull_cube_side, hull_cube_side, thickness]);
        translate([-surround_radius, mounting_hole_pcb_offset, 0])
            cube(size = [hull_cube_side, hull_cube_side, thickness]);
        translate([mounting_hole_pcb_offset, mounting_hole_pcb_offset, 0])
            cube(size = [hull_cube_side, hull_cube_side, thickness]);
    }
}

module box_mounting_hole_surrounds(thickness=box_layer_thickness) {
    union() {
        translate([
            -pcb_width / 2 + mounting_hole_pcb_offset,
            -pcb_length / 2 + mounting_hole_pcb_offset,
            0])
        rotate(a = 180, v = [0, 0, 1])
        box_mounting_hole_surround(thickness);
        translate([
            +pcb_width / 2 - mounting_hole_pcb_offset,
            -pcb_length / 2 + mounting_hole_pcb_offset,
            0])
        rotate(a = -90, v = [0, 0, 1])
        box_mounting_hole_surround(thickness);
        translate([
            +pcb_width / 2 - mounting_hole_pcb_offset,
            +pcb_length / 2 - mounting_hole_pcb_offset,
            0])
        box_mounting_hole_surround(thickness);
        translate([
            -pcb_width / 2 + mounting_hole_pcb_offset,
            +pcb_length / 2 - mounting_hole_pcb_offset,
            0])
        rotate(a = 90, v = [0, 0, 1])
        box_mounting_hole_surround(thickness);
    }
}

module box_base(thickness=box_layer_thickness) {
    hull() {
        translate([-box_cube_width / 2, -box_cube_length / 2, 0])
        cylinder(r = box_corner_radius, h = thickness, $fn=cylinder_resolution);
        translate([+box_cube_width / 2, -box_cube_length / 2, 0])
        cylinder(r = box_corner_radius, h = thickness, $fn=cylinder_resolution);
        translate([+box_cube_width / 2, +box_cube_length / 2, 0])
        cylinder(r = box_corner_radius, h = thickness, $fn=cylinder_resolution);
        translate([-box_cube_width / 2, +box_cube_length / 2, 0])
        cylinder(r = box_corner_radius, h = thickness, $fn=cylinder_resolution);
    }
}

module pcb_hole(thickness=box_layer_thickness, padding=0) {
    translate([-pcb_width / 2 - padding, -pcb_length / 2 - padding, -0.1])
    cube(size = [pcb_width + padding * 2, pcb_length + padding * 2, thickness + 0.2]);
}

module box_inside_tab(side, width, depth, offset, thickness=box_layer_thickness) {
    if(side == TOP) {
        translate([offset - width / 2, pcb_length / 2 - depth, 0])
        cube(size = [width, depth, thickness]);
    }
    if(side == BOTTOM) {
        translate([offset - width / 2, -pcb_length / 2 - 0.1, 0])
        cube(size = [width, depth + 0.1, thickness]);
    }
    if(side == LEFT) {
        translate([-pcb_width / 2 - 0.1, offset - width / 2, 0])
        cube(size = [depth + 0.1, width, thickness]);
    }
    if(side == RIGHT) {
        translate([pcb_width / 2 - depth, offset - width / 2, 0])
        cube(size = [depth + 0.1, width, thickness]);
    }
}

module box_outside_hole(side, width, depth, offset, thickness=box_layer_thickness) {
    if(side == TOP) {
        translate([offset - width / 2, box_total_length / 2 - depth, -0.1])
        cube(size = [width, depth + 0.1, thickness + 0.2]);
    }
    if(side == BOTTOM) {
        translate([offset - width / 2, -box_total_length / 2 - 0.1, -0.1])
        cube(size = [width, depth + 0.1, thickness + 0.2]);
    }
    if(side == LEFT) {
        translate([-box_total_width / 2 - 0.1, offset - width / 2, -0.1])
        cube(size = [depth + 0.1, width, thickness + 0.2]);
    }
    if(side == RIGHT) {
        translate([box_total_width / 2 - depth, offset - width / 2, -0.1])
        cube(size = [depth + 0.1, width, thickness + 0.2]);
    }
}

module box_spacer_layer(thickness=box_layer_thickness) {
    difference() {
        union() {
            difference() {
                box_base(thickness);
                pcb_hole(thickness);
            }
            box_mounting_hole_surrounds(thickness);
        }
        box_mounting_holes(thickness);
    }
}

module box_wall_mount_screw_hole_shape(thickness, padding=0) {
    translate([0, -pcb_width / 10, -0.1])
        cylinder(
            r = wall_mount_screw_hole_cutout_radius * 2 + padding,
            h = thickness + 0.2,
            $fn=cylinder_resolution);
    translate([0,  pcb_width / 10, -0.1])
        cylinder(
            r = wall_mount_screw_hole_cutout_radius + padding,
            h = thickness + 0.2,
            $fn=cylinder_resolution);
    translate([
            -wall_mount_screw_hole_cutout_radius - padding, 
            -pcb_width/10,
            -0.1])
        cube(size = [
            (wall_mount_screw_hole_cutout_radius + padding) * 2,
            pcb_width / 5,
            thickness + 0.2]);
}

module box_wall_mount_screw_hole(thickness=box_layer_thickness) {
    union() {
        box_wall_mount_screw_hole_shape(thickness);
        translate([0, 0, thickness - wall_mount_screw_hole_cutout_thickness])
            box_wall_mount_screw_hole_shape(
                wall_mount_screw_hole_cutout_thickness + 0.1,
                wall_mount_screw_hole_cutout_radius * wall_mount_screw_hole_cutout_ratio);
    }
}

module box_wall_mount_screw_holes(thickness=box_layer_thickness) {
    union() {
        translate([-pcb_width * 3 / 10, 0, 0])
            box_wall_mount_screw_hole(thickness);
        translate([ pcb_width * 3 / 10, 0, 0])
            box_wall_mount_screw_hole(thickness);
    }
}

