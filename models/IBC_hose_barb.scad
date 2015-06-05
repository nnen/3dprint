use <threads.scad>

module outerthread(height, outerdia, rising, fine, angle, direction) {
	assign(innerdia=outerdia-rising/sin(angle/2))
		assign(s=outerdia*tan(180/fine))
		assign(polygonR=s/(2*sin(180/fine))) {
		difference() {
			rotate([0,0,(360/fine)/2]) cylinder(r=(outerdia-(2*polygonR-outerdia))/2, h=height, $fn=fine);
			for(n=[0:(floor(height/rising))]) translate([0,0,n*rising-rising/2]) {
				//einen gewindegang erzeugen
				for(a=[0:360/fine:360]) {
					translate([cos(a)*(outerdia-(2*polygonR-outerdia))/2, sin(a)*(outerdia-(2*polygonR-outerdia))/2, direction*a/360*rising]) {
						rotate([90,-90,a]) rotate([0,-direction*asin(rising/(outerdia*PI)),0]) {
							linear_extrude(height=(outerdia)*sin(180/fine), center=true) scale(rising) {
								polygon(points=[[-0.5,0],[0.5,0],[0,1/(2*sin(angle/2))]]);
							}
						}
					}
				}
			}
		}
	}
}

module innerthread(height, outerdia, innerdia=0, rising, fine, angle, direction, dia) {
	assign(trueinnerdia=outerdia-rising/sin(angle/2))
		assign(s=outerdia*tan(180/fine))
		assign(polygonR=s/(2*sin(180/fine))) {
		difference() {
			rotate([0,0,(360/fine)/2]) cylinder(r=dia/2, h=height, $fn=fine);
			for(n=[0:(floor(height/rising))]) translate([0,0,n*rising-rising/2]) {
				//einen gewindegang erzeugen
				for(a=[0:360/fine:360]) {
					translate([cos(a)*(outerdia/2-2*rising*sin(angle/2)), sin(a)*(outerdia/2-2*rising*sin(angle/2)), direction*a/360*rising]) {
						rotate([90,90,a]) rotate([0,direction*asin(rising/(outerdia*PI)),0]) {
							linear_extrude(height=(outerdia)*tan(180/fine), center=true) scale(rising) {
								polygon(points=[[-0.5,0],[0.5,0],[0,1/(2*sin(angle/2))]]);
							}
						}

					}
				}
			}
			translate([0,0,-1]) rotate([0,0,(360/fine)/2]) cylinder(r=polygonR-2*rising*sin(angle/2), h=height+2, $fn=fine);
			translate([0,0,-1]) cylinder(r=innerdia/2, h=height+2, $fn=fine*2);
		}
	}
}

dummy=0.01;
$fn=100;

// diameter
hosedia=38;
dia1=54;

//thickness
t=3;

// correction factor
// printed with ABS in 0.15 layers
cFact1=1.0340425532;
cFact2=1.0102040816;

// height
h1=22;
h2=35;
redh=15;
/*
difference() {
	union() {
		// G 1 1/2 ''
		
//		innerthread(height=h1, innerdia=44.846*cFact1, outerdia=47.803*cFact1, rising=2.309, angle=55, fine=100, direction=1, dia=dia1*cFact2);
		difference() { cylinder(h=h1, r=dia1*cFact2/2); cylinder(h=h1, r=44.846*cFact1/2); }
		
		difference() {
			translate([0,0,h1-dummy]) cylinder(r1=dia1/2*cFact2, r2=hosedia/2*cFact2, h=redh+2*dummy);
			translate([0,0,h1-2*dummy]) cylinder(r1=dia1/2*cFact2-t, r2=hosedia/2*cFact2-t, h=redh+4*dummy);
		}

		translate([0,0,h1+redh-dummy]) cylinder(r=hosedia/2*cFact2, h=h2);
		// part to prevent hose from slipping off
		for(i=[1:5]) {
			translate([0,0,h1+redh-dummy+i*5]) cylinder(r1=hosedia/2*cFact2+1, r2=hosedia/2*cFact2, h=5);
		}

	}
	translate([0,0,h1+redh-2*dummy]) cylinder(r=hosedia/2*cFact2-t, h=h2+2*dummy);
	
	// knurling
	for(r=[0:360/18:360]) {
		rotate([0,0,r]) translate([(dia1*cFact2)/2-1,-4.5/2,0]) cube([1,4.5,h1-1]);
	}
}




*/

DN_thread(96, 8, 10, internal=true);