
use <library.scad>

radius = 50 / 2;
inner_radius = 32 / 2;

wall = 0.6;
height = 180;
motor_top = 173;
motor_bottom = 10;

rib_count = 12;

// circular grid fins
/*
fin_r = 50;
fin_h = 5;
fin_spacing = 10;
*/

// classic fins
fin_r = radius + 50;
fin_h = 59;
fin_angle = 16;

screw_outer_r = 2.5;
screw_inner_r = 1;
screw_length = 10;


module twisted_ribs(outer_r, inner_r, height, twist, count, wall) {
	angle = 360 / count;
	linear_extrude(height, twist = twist, slices = 20) {
		for (i = [0 : (count - 1)]) {
			rotate([0, 0, i * angle])
			translate([0, inner_r])
			square([wall, outer_r - inner_r]);
		}
	}
}


module motor_holder() {
        rotate([0, 0, 11])
        translate([0, 0, -wall * 3])
        difference () {
            cylinder(r = radius - 2, h = wall * 3, $fn = rib_count);
            translate([0, 0, -1])
            cylinder(r = inner_radius, h = (wall * 3) + 2, $fn = rib_count);
        }
        
        difference () {
            cylinder(r = radius - 2, h = wall * 3);
            
            translate([0, 0, wall * 2])
                cylinder(r = 3, h = wall);
        }
        
        /*
	intersection () {
		for (i = [0 : 1]) {
			rotate([0, 0, i * 180])
			translate([inner_radius * 0.2, -radius, 0])
			cube([radius - inner_radius * 0.2, radius * 2, wall * 4]);

			//rotate([0, 0, 90 + i * 180])
			//translate([inner_radius / 2, -radius, wall * 4])
			//cube([wall * 4, radius * 2, wall * 4]);
		}
                
		cylinder(r = radius - 2, h = height); 
	}
        */
        
}


module inner_ring(angle = 11) {
    rotate([0, 0, angle])
    //translate([0, 0, -wall * 3])
    difference () {
        cylinder(r = inner_radius + wall * 3, h = wall * 3, $fn = rib_count);
        translate([0, 0, -1])
        cylinder(r = inner_radius, h = (wall * 3) + 2, $fn = rib_count);
    }
}


module circular_grid_fin(outer_r, inner_r, wall, spacing, height) {
	ring(outer_r, wall, height);
	
	c = (outer_r * 2) / spacing;
	
	difference () {
	intersection () {
		union () {
			for (i = [1 : (c - 1)]) {
				translate([-outer_r + i * spacing - wall / 2, -outer_r, 0])
				cube([wall, outer_r * 2, height]);

				translate([-outer_r, -outer_r + i * spacing - wall / 2, 0])
				cube([outer_r * 2, wall, height]);
			}
		}
		
		cylinder(r = outer_r, h = height);
	}
	cylinder(r = inner_r, h = height);
	}
}


module classic_fins(outer_r, inner_r, wall, height, angle) {
    for (i = [0 : 3]) {
        rotate([0, 0, i * 90])
        translate([-wall / 2, inner_r, 0])
        difference () {
            cube([wall, outer_r - inner_r, height]);
          
            color("red")
            translate([-1, 0, height])
            rotate([-angle, 0, 0])
            cube([wall + 2, (outer_r - inner_r) + height, height]);
        }
    }
}


module hull(radius, inner_radius, height, wall, motor_bottom) {
	difference () {
		cylinder(r = radius, h = height);
                translate([0, 0, -1])
		cylinder(r = radius - wall, h = height + 2);
	}


	difference () {
		union () {
			twisted_ribs(
				radius - (wall / 2),
				inner_radius,
				height,
				60,
				rib_count,
				wall
			);
			/*
			twisted_ribs(
				radius,
				inner_radius,
				height,
				-10,
				rib_count,
				wall
			);
			*/
		}
		
		cylinder(
			r1 = radius - wall,
			r2 = inner_radius,
			h = motor_bottom
		);
	}
}


module screw_anchor(outer_r, inner_r, depth, height, wall) {
	rotate([30, 0, 0])
	difference () {
		//translate([-outer_r / 2 - wall, outer_r / 2, 0])
		translate([-outer_r - wall, -wall, 0])
		cube([(outer_r + wall) * 2, depth, height]);

		//ccube(outer_r + wall * 2, outer_r + wall * 2, height);
		translate([0, outer_r, 0]) {
		cylinder(r = outer_r, h = height / 2);
		cylinder(r = inner_r, h = height);
		
		translate([-outer_r, 0, 0])
		cube([outer_r * 2, depth, height / 2]);
		}
	}
}


/*
translate([0, 0, height - 20])
intersection () {
	for (i = [0 : 1]) {
		rotate([0, 0, i * 180])
		translate([0, radius, 0])
		screw_anchor(screw_outer_r, screw_inner_r, radius, screw_length * 2, wall * 3);
	}
	translate([0, 0, -height / 2])
	cylinder(r = radius, h = height);
}
*/

//circular_grid_fin(fin_r, radius - wall, wall, fin_spacing, fin_h);
color("red")
classic_fins(fin_r, radius - wall, wall, fin_h, fin_angle);


difference () {
	union () {
		hull(radius, inner_radius, height, wall, motor_bottom);
                
                translate([0, 0, motor_bottom])
                inner_ring(17);
                
                color("blue")
		translate([0, 0, motor_top])
		motor_holder();
	}
	
	/*
	translate([0, 0, height - 20])
	for (i = [0 : 1]) {
		rotate([0, 0, i * 180])
		translate([0, radius, 0])
		translate([0, outer_r, 0])
		cylinder(r = screw_outer_r, h = screw_length);
	}
	*/
}
