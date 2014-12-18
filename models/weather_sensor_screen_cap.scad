Clear=0.175; // size of tolerance zone
thickness = 2; // global wall thickness
height = 15; 	// height of one screen element
screen_radius = 75/2; // outer radius of screen
tube_radius=30/2; 	// inner radius of the space for a sensor
screen_bevel = 10;		// bevel of outer screen wall
num_ribs = 3;			// number of holding ribs



angle_sep = 360/num_ribs;

translate ([0,0,height])
difference () {
	sphere(screen_radius - screen_bevel, $fn=100);
	sphere(screen_radius - screen_bevel - thickness, $fn=100);
	cube([100,100,height], center = true);
}


//screen 

difference () {
	cylinder (h=height,r1=screen_radius ,r2=screen_radius - screen_bevel,$fn=100);
	translate ([0,0,-Clear/2])
	cylinder (h=height+Clear,r1=screen_radius  - thickness ,r2=(screen_radius - screen_bevel) - thickness,$fn=100);
}


//inner ring
inner_ring_thickness = thickness *2;


// center ribs
for (i = [0 : (num_ribs-1)]) {
	rotate ([90,0,angle_sep * i])
	translate ([0,0,-thickness/2])
	linear_extrude (height = thickness, convexity = 10)
	polygon(points=[[tube_radius + thickness, inner_ring_thickness],[tube_radius + thickness - Clear, 0],[screen_radius - thickness,0],[screen_radius - screen_bevel,height]]);

}
