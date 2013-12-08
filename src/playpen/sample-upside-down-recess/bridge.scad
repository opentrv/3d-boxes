small_hole_radius = 1;
large_hole_radius = 2;
cube_side = large_hole_radius * 4;
large_hole_height = cube_side / 2;
bridge_layer_height = 0.3;

difference() {
    translate([0, 0, 4])
    cube(size=[cube_side, cube_side, cube_side], center=true);
    
    translate([0, 0, -0.1])
    cylinder(r=small_hole_radius, h=cube_side + 0.2, $fn=50);
    
    translate([0, 0, -0.1])
    cylinder(r=large_hole_radius, h=large_hole_height + bridge_layer_height * 3, $fn=50);
}

/* bridge #1 */
translate([0, 0, large_hole_height + ((bridge_layer_height * 3 + 0.1) / 2)])
difference() {
    cube(size=[large_hole_radius * 2 + 0.2, large_hole_radius * 2 + 0.2, bridge_layer_height * 3 + 0.1], center=true);
    cube(size=[small_hole_radius * 2      , large_hole_radius * 2 + 0.2, bridge_layer_height * 3 + 0.3], center=true);
}

/* bridge #2 */
translate([0, 0, large_hole_height + bridge_layer_height + ((bridge_layer_height * 2 + 0.1) / 2)])
difference() {
    cube(size=[large_hole_radius * 2 + 0.2, large_hole_radius * 2 + 0.2, bridge_layer_height * 2 + 0.1], center=true);
    cube(size=[large_hole_radius * 2 + 0.2, small_hole_radius * 2      , bridge_layer_height * 2 + 0.3], center=true);
}

/* bridge #3 */
translate([0, 0, large_hole_height + 2 * bridge_layer_height + ((bridge_layer_height + 0.1) / 2)])
rotate(v=[0, 0, 1], a=45)
difference() {
    cube(size=[large_hole_radius * 2 + 0.2, large_hole_radius * 2 + 0.2, bridge_layer_height + 0.1], center=true);
    cube(size=[small_hole_radius * 2      , small_hole_radius * 2      , bridge_layer_height + 0.3], center=true);
}

