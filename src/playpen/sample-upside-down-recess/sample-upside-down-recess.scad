//Example upside down recess using bridge

include <shapes.scad>;

		union()
		{ 

			difference() 
			{

// Create a box (co-incidentally, the same size as the OpenTRV box)

			translate([0,0,0]) cube([56,56,11]);

//Subtract a 3.1mm diameter hole all the way through  

			translate([5,5,-1]) cylinder(h = 13, r = 1.55);

//Subtract a 6mm diameter recess 4mm high from the bottom

			translate([5,5,-2]) cylinder(h = 6, r = 3.0);

			}

// Put in the bridge to avoid droop 

			translate([0,0,4]) cube([8,8,0.3]);

// Add Lillypad (aka Mouse Ear)

			translate([56,0,0]) cylinder(h = 0.3, r = 7);

		}


