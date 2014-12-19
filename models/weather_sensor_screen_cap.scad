Clear=0.175; // size of tolerance zone
thickness = 2; // global wall thickness
height = 15; 	// height of one screen element
screen_radius = 75/2; // outer radius of screen
tube_radius=30/2; 	// inner radius of the space for a sensor
screen_bevel = 10;		// bevel of outer screen wall
num_ribs = 3;			// number of holding ribs
cap_radius = screen_radius * 1.5;
inner_ring_thickness = thickness *2;


angle_sep = 360/num_ribs;

cap_height = cap_radius - sqrt(cap_radius*cap_radius - (screen_radius - screen_bevel)*(screen_radius - screen_bevel));

difference () {

    union() {
	    //cap outer shell
	    intersection () {
		    translate ([0,0,-cap_radius + height + cap_height])
     			sphere(cap_radius, $fn=100);

	        //screen outer shell 
	        cylinder (h=screen_radius*(height/screen_bevel),r1=screen_radius ,r2=0,$fn=100);
	    }

	    // cap hook
	    translate ([0,0,height + (cap_height-thickness)])
	    difference () {
		    cylinder (h=height/2,r1=screen_radius/4,r2=screen_radius/4 - thickness,$fn=100);

		    translate ([0,screen_radius/4,2.5])
			    rotate ([90,0,0])
				    cylinder (h=screen_radius/2,r=3, $fn=100);

		    translate ([-screen_radius/4,0,2.5])
			    rotate ([0,90,0])
				    cylinder (h=screen_radius/2,r=3, $fn=100);
	    }


    }

	union() {
		intersection () {
		//cap inner cavity 
		translate ([0,0,-cap_radius + height + cap_height  ]) 
			sphere(cap_radius-thickness, $fn=100);

		//screen  inner cavity  (height is solved by triangle similarity)
		translate ([0,0, -Clear/2 ]) 
		cylinder (h=(screen_radius  - thickness)*(height/screen_bevel),r1=screen_radius  - thickness ,r2=0,$fn=100);
		}
	}
}



	// center ribs
	for (i = [0 : (num_ribs-1)]) {
		rotate ([90,0,angle_sep * i])
		translate ([0,0,-thickness/2])
		linear_extrude (height = thickness, convexity = 10)
		polygon(points=[[0, cap_height + height],[tube_radius + thickness - Clear, 0],[screen_radius - thickness,0],[screen_radius - screen_bevel - thickness,height]]);

}
