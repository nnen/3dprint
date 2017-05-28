use <threads.scad>;

rotate([180,0,0]){
    intersection() {
        cylinder(r2 = 106/2, r1 = 106/2+30,  h = 30, $fn=100 ); 
        union() {
            difference()
            {
                cylinder(d = 110, h = 30, $fn=15 ); 
                cylinder(d = 95.5, h = 25.5, $fn=100); 
                cylinder(d = 30, h = 35); 
            }


            translate([0,0,20])
            difference()
            {
                cylinder(r = 20, h = 10, $fn=10 ); 
                english_thread(1.0, 16, 2, internal=true);
            }

            DN_thread(96, 8, 20, internal=true);
        }
    }
}