

module frustum(width, depth, width2, depth2, height) {
    // polyhedron(points = [ [x, y, z], ... ], faces = [ [p1, p2, p3..], ... ], convexity = N);

    polyhedron(
        points = [
            [-width / 2, -depth / 2, 0],
            [width / 2, -depth / 2, 0],
            [width / 2, depth / 2, 0],
            [-width / 2, depth / 2, 0],
            
            [-width2 / 2, -depth2 / 2, height],
            [-width2 / 2, depth2 / 2, height],
            [width2 / 2, depth2 / 2, height],
            [width2 / 2, -depth2 / 2, height]
        ],
        faces = [
            // bottom
            [0, 1, 2, 3],
            // top
            [4, 5, 6, 7],
    
            // front
            [4, 7, 1, 0],
            // back
            [6, 5, 3, 2],
            // left
            [5, 4, 0, 3],
            // right
            [7, 6, 2, 1]
        ]
    );
}


module pyramid(width, depth, height, center = false) {
    if (center) {
    } else {
    }
    
    polyhedron(
        points = [
            [-width / 2, -depth / 2, 0],
            [width / 2, -depth / 2, 0],
            [width / 2, depth / 2, 0],
            [-width / 2, depth / 2, 0],
            
            [0, 0, height]
        ],
        faces = [
            [0, 1, 2, 3],
            
            [0, 4, 1],
            [2, 4, 3],
            [3, 4, 0],
            [1, 4, 2]
        ]
    );
}


module ccube(width, depth, height, center_z = false, corner_cut = 0) {
	if (center_z) {
		translate([-width / 2, -depth / 2, -height / 2]) {
			difference () {
				cube([width, depth, height]);
			}
			
			children();
		}
	} else {
		translate([-width / 2, -depth / 2, 0]) {
			difference () {
				cube([width, depth, height]);
				
				if (corner_cut > 0) {
					//translate([width / 2, height / 2, 0])
					rotate([0, 0, 45])
					ccube(corner_cut, corner_cut, height);

					translate([width, 0, 0])
					rotate([0, 0, 45])
					ccube(corner_cut, corner_cut, height);
					
					translate([width, depth, 0])
					rotate([0, 0, 45])
					ccube(corner_cut, corner_cut, height);

					translate([0, depth, 0])
					rotate([0, 0, 45])
					ccube(corner_cut, corner_cut, height);
				}
			}
			
			children();
		}
	}
}


module ring(radius, width, height) {
	difference () {
		cylinder(r = radius, h = height);
		cylinder(r = radius - width, h = height);
	}
}


module hexagon(side, height) {
	h = sqrt(3) * side;
	
	for (i = [0 : 5]) {
		rotate([0, 0, i * 60])
		translate([-side / 2, -h / 2, 0])
		cube([side, h, height]);
	}
}


module ramp(width, depth, height) {
    angle = atan(height / depth);
    
    difference () {
        cube([width, depth, height]);
    
        //color("red")
        rotate([angle, 0, 0])
        translate([-1, 0, 0])
        cube([width + 2, depth * 2, height]);
    }
}


module round_inner_corner(width, depth) {
	difference() {
		cube([width, depth, width]);
		
		translate([width, 3 * depth / 2, width])
		rotate([90, 0, 0])
		cylinder(r = width, h = depth * 2);
	}
}


module slide_clip(width,
                  depth,
                  height,
                  wall,
                  inner = false,
                  slack = 0) {
    difference () {
        union () {
            if (inner) {
                translate([-wall / 2, 0, 0])
                cube([wall, depth, height - wall]);
                
                translate([-width / 2, depth - wall, 0])
                cube([width, wall, height - wall]);
                
                //translate([-width / 2, 0, height - wall])
                //cube([width, depth, wall]);
            } else {    
                translate([-wall / 2, 0, 0])
                cube([wall, depth, height]);
                
                translate([-width / 2, depth - wall, 0])
                cube([width, wall, height]);
                
                translate([-width / 2, 0, height - wall])
                cube([width, depth, wall]);
            }
        }
        
        if (!inner) {
            translate([wall / 2, depth - wall, 0])
            rotate([0, 30, 0])
            cube([width, wall, height]);
            
            translate([-wall / 2, depth - wall, 0])
            rotate([0, -30, 0])
            translate([-width, 0, 0])
            cube([width, wall, height]);
            
            translate([0, depth - wall / 2, 0])
            rotate([-30, 0, 0])
            translate([-width / 2, 0, 0])
            cube([width, wall, height]);
        }
    }
}


/*
slide_clip(6, 6, 50, 2);

translate([20, 0, 0])
slide_clip(6, 6, 50, 2, true, slack = 0.5);
*/


// ramp(100, 50, 20);

