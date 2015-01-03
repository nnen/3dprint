//translate([0, sqrt(3) * 40 / sqrt(4), 0])

MAIN_MODEL = 0;
ARMS = 1;

mode = MAIN_MODEL;

if (mode == MAIN_MODEL) {
	translate([0, 15, 0])
	rotate([30, 0, 0])
	translate([-2, -2, 0])
	cube([4, 4, 31]);

	rotate([0, 0, 180])
	translate([0, 15, 0])
	rotate([30, 0, 0])
	translate([-2, -2, 0])
	cube([4, 4, 31]);


	translate([-5, -20, -1])
	cube([10, 40, 2]);

/*
	color("green")
	translate([-5, -20, 1])
	cube([10, 40, 40]);
*/

} else if (mode == ARMS) {
	translate([-5, -20, 1])
	cube([10, 40, 40]);
}
