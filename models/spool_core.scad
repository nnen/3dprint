rod_radius = 4.5;
inner_radius = 36;
outer_radius = 50;
thickness = 3;


hole_r = (outer_radius - inner_radius - 2 * thickness) / 2;


module ring(radius, width, height) {
	difference () {
		cylinder(r = radius, h = height);
		translate([0,0,-height/100])
		cylinder(r = radius - width, h = height + height/50);
	}
}


//difference () {
//	union () {
//		cylinder(r = outer_radius, h = thickness);
//		cylinder(r = inner_radius, h = thickness * 3);
//	}
//	
//	translate([0, 0, thickness])
//	cylinder(r = inner_radius - thickness, h = thickness * 2);

//	cylinder(r = rod_radius, h = thickness);
	
//	for (i = [0 : 5]) {
//		translate([0, inner_radius + thickness + hole_r, 0])
//		cylinder(r = hole_r, h = thickness);
//	}
//}


ring(rod_radius + thickness, thickness, thickness * 4);

ring(inner_radius, thickness, thickness * 4);

ring(outer_radius, thickness, thickness);

for (i = [0 : 5]) {
	rotate([0, 0, 60 * i])
	translate([-thickness / 2, rod_radius, 0])
	cube([thickness, outer_radius - rod_radius - thickness / 2, thickness]);
	
	rotate([0, 0, 60 * i])
	translate([-thickness / 2, rod_radius, 0])
	cube([thickness, inner_radius - rod_radius - thickness / 2, thickness * 3]);
}
