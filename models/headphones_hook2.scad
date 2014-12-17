base_width = 80;
thickness = 30;
wall_thickness = 5;
length = 100;

//circle([50, 100]);


module base(width, height, wall_thickness) {
	linear_extrude (height) {
	polygon(
		[
			[0, 0],
			[width, 0],
			[width - wall_thickness, wall_thickness],
			[wall_thickness, wall_thickness]
		],
		[[0, 1, 2, 3]]
	);
	}
}


module half_tube(length, width, wall_thickness) {
	rotate([-90, 0, 0]) linear_extrude (length) {
	difference () {
		circle(width / 2);
		circle(width / 2 - wall_thickness);
		
		translate([-(width / 2), 0]) square([thickness * 2, thickness]);
	}
	
	translate([(width / 2) - wall_thickness, 0]) square([wall_thickness, width / 2]);
	translate([-(width / 2), 0]) square([wall_thickness, width / 2]);
	}
}

base(base_width, thickness, wall_thickness);
translate([base_width / 2, wall_thickness, thickness / 2]) half_tube(length, thickness, wall_thickness);

translate([base_width / 2 - (thickness / 2), length, 0]) cube([thickness, wall_thickness, thickness]);
translate([base_width / 2, length + wall_thickness, thickness]) rotate([90, 0, 0]) cylinder(wall_thickness, thickness / 2, thickness / 2);
