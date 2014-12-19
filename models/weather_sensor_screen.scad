Clear=0.175; // size of tolerance zone
thickness = 2; // global wall thickness
height = 15; 	// height of one screen element
screen_radius = 75/2; // outer radius of screen
tube_radius=30/2; 	// inner radius of the space for a sensor
screen_bevel = 10;		// bevel of outer screen wall
num_ribs = 3;			// number of holding ribs



angle_sep = 360/num_ribs;

translate ([0,0,height])
// screen upper rim
difference () {
cylinder (h=thickness*2,r= screen_radius - screen_bevel,$fn=100);
translate ([0,0,-Clear/2])
cylinder (h=thickness*2 +Clear,r= (screen_radius - screen_bevel)- thickness ,$fn=100);


// screen upper rim gabs for ribs from another screen.
for (i = [0 : (num_ribs-1)]) {
	rotate ([0,0,60 + (angle_sep * i)])
	translate ([(screen_radius - screen_bevel)- thickness - Clear/2 ,-Clear/2,-Clear/2])
	cube(size = [thickness + 2*Clear, thickness + Clear,thickness*2 + Clear]);
}
}

//screen 

difference () {
	cylinder (h=height,r1=screen_radius ,r2=screen_radius - screen_bevel,$fn=100);
	translate ([0,0,-Clear/2])
	cylinder (h=height+Clear,r1=screen_radius  - thickness ,r2=(screen_radius - screen_bevel) - thickness,$fn=100);
}


//inner ring
inner_ring_thickness = thickness *2;

difference () {
	cylinder (h=inner_ring_thickness,r = tube_radius + thickness,$fn=100);
	translate([0,0,-Clear/2])
	cylinder (h=inner_ring_thickness +Clear,r = tube_radius,$fn=100);		
}

// center ribs
for (i = [0 : (num_ribs-1)]) {
	rotate ([90,0,angle_sep * i])
	translate ([0,0,-thickness/2])
	linear_extrude (height = thickness, convexity = 10)
	polygon(points=[[tube_radius + thickness, inner_ring_thickness],[tube_radius + thickness - Clear, 0],[screen_radius - thickness,0],[screen_radius - screen_bevel,height]]);

}
