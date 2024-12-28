thickness = 2;  // thickness of wall
shelf_thickness = 4.05;  // thickness of the shelf glass
under_shelf = 2; // space between bottom of the shelf and refrigerator shelf hook
shelf_extension = 12; // distance between shelf and refrigerator wall
holder_lenght = 55;  // lenght of the shelf holder
holding_shelf_width = 8.5; // lenght or distance of shelf inside in holder



difference () {
	cube([thickness + shelf_thickness +under_shelf,holding_shelf_width+shelf_extension,holder_lenght]);
	translate([thickness,shelf_extension,0]) cube([shelf_thickness,holding_shelf_width,holder_lenght]);

}

