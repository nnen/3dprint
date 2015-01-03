

function sq(x) = x * x;


module ogive(height, width, slices = 10, thickness = -1) {
    radius = (height * height + width * width) / (2 * width);
    
    center_x = -radius + width;
    center_y = 0;
    
    d = height / slices;
    
    echo("radius = ", radius);
    echo("d = ", d);
    
    function w(y, r) = center_x + sqrt(
        (r * r) - (y * y)
    );
    
    difference () {
        polygon(
            points = concat([
                [0, height],
                [0, 0],
                [width, 0]
            ],
            [ for (i = [0 : (slices - 1)]) [w(i * d, radius), i * d] ]),
            paths = [ [ for (i = [0 : (slices + 2)]) i ] ]
        );
        
        if (thickness > 0) {
            polygon(
                points = concat([
                    [0, sqrt(sq(radius - thickness) - sq(radius - width))],
                    [0, 0],
                    [width - thickness, 0]
                ],
                [ for (i = [0 : (slices - 1)]) [w(i * d, radius - thickness), i * d] ]),
                paths = [ [ for (i = [0 : (slices + 2)]) i ] ]
            );
        }
    }
}


module ogive_nose_cone(radius, height, slices = 10, thickness = -1) {
    rotate_extrude ()
    ogive(radius, height, slices = slices, thickness = thickness);
}


//ogive(200, 50, slices = 5, thickness = 5);
ogive_nose_cone(20, 5, slices = 20, thickness = 0.6);
