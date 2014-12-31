
use <library.scad>


wall = 2;
width = 150;
depth = 90;
floor_height = 10;

ramp_height = 10;
drain_width = 20;
drain_length = 10;

bottom_wall_height = floor_height + ramp_height + 2 * wall;

inner_width = width - wall * 2;
inner_depth = depth - wall * 2;

rack_leg_height = 20;
grid_spacing = 10;


module bottom() {
    tunnel_width_scale = 0.75;
    tunnel_width = sqrt(2 * floor_height * floor_height) * tunnel_width_scale;
    tunnel_count = floor((width - wall) / (tunnel_width + wall));
    
    difference () {
        union () {
            // FLOOR
            cube([width, depth, floor_height]);
            
            // WALLS    
            cube([width - wall * 2 - drain_width, wall, bottom_wall_height]);
            
            translate([inner_width - wall * 2, 0, 0])
            cube([wall * 4, wall, bottom_wall_height]);
            
            translate([0, depth - wall, 0])
            cube([width, wall, bottom_wall_height]);
            
            cube([wall, depth, bottom_wall_height]);
            
            translate([width - wall, 0, 0])
            cube([wall, depth, bottom_wall_height]);
        }
    
        //translate([-width, 0, 0])
        for (i = [0 : (tunnel_count - 1)]) {
            translate([wall + (tunnel_width / 2) + i * (tunnel_width + wall), 0, 0])
            scale([tunnel_width_scale, 1, 1])
            rotate([0, 45, 0])
            translate([-floor_height / 2, 0, -floor_height / 2])
            cube([floor_height, depth, floor_height]);
        }
    }
    
    // RAMPS
    translate([0, 0, floor_height])
    ramp(width, depth, ramp_height);

    translate([width - drain_width - 2 * wall, wall, floor_height])
    rotate([0, 0, 90])
    ramp(depth - 2 * wall, width - drain_width - 2 * wall, ramp_height);
    
    
    
    // DRAIN
    translate([width - wall * 3- drain_width,
               -drain_length,
               3 * floor_height / 4])
    ramp(drain_width, drain_length, floor_height / 4);
    
    translate([width - wall * 3,
               -drain_length,
               3 * floor_height / 4])
    rotate([0, 180, 0])
    ramp(drain_width, drain_length, 3 * floor_height / 4);
    
    translate([width - drain_width - 3 * wall,
               -drain_length,
               3 * floor_height / 4])
    ramp(wall, drain_length, ramp_height + floor_height / 4);
    
    translate([width - 4 * wall,
               -drain_length,
               3 * floor_height / 4])
    //cube([wall, drain_length + wall, ramp_height]);
    ramp(wall, drain_length, ramp_height + floor_height / 4);
    
    translate([width - drain_width - 3 * wall, 0, 0])
    cube([drain_width, 2 * wall, floor_height]);
    
    
    // RACK STANDS
    color("red")
    translate([wall, wall, 0])
    cube([wall * 2, wall * 2, floor_height + ramp_height]);
    
    color("red")
    translate([width - wall * 3, wall, 0])
    cube([wall * 2, wall * 2, floor_height + ramp_height]);
    
    color("red")
    translate([wall, depth - wall * 3, 0])
    cube([wall * 2, wall * 2, floor_height + ramp_height]);
    
    color("red")
    translate([width - wall * 3, depth - wall * 3, 0])
    cube([wall * 2, wall * 2, floor_height + ramp_height]);
}


module rack() {
    // LEGS
    translate([wall, wall, 0])
    cube([wall * 2, wall * 2, rack_leg_height + wall]);
    
    translate([inner_width - wall, wall, 0])
    cube([wall * 2, wall * 2, rack_leg_height + wall]);
    
    translate([inner_width - wall, inner_depth - wall, 0])
    cube([wall * 2, wall * 2, rack_leg_height + wall]);
    
    translate([wall, inner_depth - wall, 0])
    cube([wall * 2, wall * 2, rack_leg_height + wall]);
    
    
    // FRAME
    translate([0, 0, rack_leg_height])
    cube([width, wall, wall]);
    
    translate([0, depth - wall, rack_leg_height])
    cube([width, wall, wall]);
    
    translate([0, 0, rack_leg_height])
    cube([wall, depth, wall]);
    
    translate([width - wall, 0, rack_leg_height])
    cube([wall, depth, wall]);
    
    
    // GRID
    x_count = inner_width / grid_spacing;
    y_count = inner_depth / (grid_spacing * 2);
    
    for (i = [1 : x_count]) {
        translate([i * grid_spacing, 0, rack_leg_height])
        cube([wall, depth, wall]);
    }
    
    for (i = [1 : y_count]) {
        translate([0, i * grid_spacing * 2, rack_leg_height])
        cube([width, wall, wall]);
    }
}


bottom();


color("green")
translate([0, 0, floor_height + ramp_height + 10])
rack();

