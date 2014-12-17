Clear=0.175; // size of tolerance zone
thickness = 2;
height = 15;
screen_radius = 85/2;
tube_radius=35/2;
screen_bevel = 15;

translate ([0,0,-thickness*4])
// screen upper rim
difference () {
cylinder (h=thickness*4,r= screen_radius - screen_bevel,$fn=100);
translate ([0,0,-Clear/2])
cylinder (h=thickness*4 +Clear,r= (screen_radius - screen_bevel)- thickness ,$fn=100);


// screen upper rim gabs for ribs from another screen.
rotate ([90,0,60])
translate ([(screen_radius - screen_bevel)- thickness - Clear/2 ,-Clear/2,-thickness/2])
cube(size = [thickness + Clear,thickness*4 + Clear, thickness]);

rotate ([90,0,180])
translate ([(screen_radius - screen_bevel)- thickness - Clear/2 ,-Clear/2,-thickness/2])
cube(size = [thickness + Clear,thickness*4 + Clear, thickness]);

rotate ([90,0,300])
translate ([(screen_radius - screen_bevel)- thickness - Clear/2 ,-Clear/2,-thickness/2])
cube(size = [thickness + Clear,thickness*4 + Clear, thickness]);


}

//screen 

difference () {
cylinder (h=height,r1= screen_radius - screen_bevel,r2=screen_radius,$fn=100);
translate ([0,0,-Clear/2])
cylinder (h=height+Clear,r1=(screen_radius - screen_bevel) - thickness ,r2=screen_radius - thickness,$fn=100);
}


//inner ring

translate([0,0,height - thickness *2])

difference () {
	cylinder (h=thickness *2,r = tube_radius + thickness,$fn=100);
	translate([0,0,-Clear/2])
	cylinder (h=thickness *2 +Clear,r = tube_radius,$fn=100);		
}

// center ribs

rotate ([90,0,0])
translate ([0,0,-thickness/2])
linear_extrude (height = thickness, convexity = 10)
polygon(points=[[tube_radius + thickness - Clear, height - thickness *2],[tube_radius + thickness, height],[screen_radius - thickness, height],[screen_radius - screen_bevel,0]]);

rotate ([90,0,120])
translate ([0,0,-thickness/2])
linear_extrude (height = thickness, convexity = 10)
polygon(points=[[tube_radius + thickness - Clear, height - thickness *2],[tube_radius + thickness, height],[screen_radius - thickness, height],[screen_radius - screen_bevel,0]]);

rotate ([90,0,240])
translate ([0,0,-thickness/2])
linear_extrude (height = thickness, convexity = 10)
polygon(points=[[tube_radius + thickness - Clear, height - thickness *2],[tube_radius + thickness, height],[screen_radius - thickness, height],[screen_radius - screen_bevel,0]]);
