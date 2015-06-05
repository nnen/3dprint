use <threads.scad>;

rotate([180,0,0]){
    union() {
        difference()
        {
            cylinder(d = 105, h = 30, $fn=100 ); 
            cylinder(d = 95.5, h = 25.5, $fn=100); 
            cylinder(d = 30, h = 35); 
        }


        translate([0,0,20])
        difference()
        {
            cylinder(r = 20, h = 10, $fn=100 ); 
            english_thread(1.0, 14, 2, internal=true);
        }

        DN_thread(96, 8, 20, internal=true);
    }
}