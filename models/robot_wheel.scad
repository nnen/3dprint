prumer = 100;
rafek = 10;
tloustka_rafku = 10;
tloustka_zebrovani = 5;
tloustka_stredu = 7;
prumer_stredu = 20;
prumer_hridele = 4;
polomer_zakriveni = 15;
dokonalost_kruhu = 100;

pocet_vykrojeni = 6;
vnitrni_polomer_zebrovani = 10;


difference() {
	kolo();
	difference() {
		for (i=[0:pocet_vykrojeni-1]){
				rotate([0,0,i * 360/pocet_vykrojeni]){
					scale([1,1,3]) {
						vykrojeni(360/pocet_vykrojeni,10,37,10,3);
					}
				}
			}

		translate([0,0,-tloustka_zebrovani*2]) {cylinder(r=vnitrni_polomer_zebrovani, h=tloustka_zebrovani*3, center=false, $fn=dokonalost_kruhu);}
	}

}

module kolo(){
	intersection() {
		difference() {
			cylinder(r=prumer/2, h=tloustka_rafku, center=true, $fn=dokonalost_kruhu);
			cylinder(r=prumer/2-rafek, h=tloustka_rafku*2, center=true, $fn=dokonalost_kruhu);
		}
		rotate_extrude(convexity=10, $fn=dokonalost_kruhu){translate([prumer/2-polomer_zakriveni, 0, 0]){circle(r = polomer_zakriveni, $fn=dokonalost_kruhu);}}
	}

	difference() {
		union() {
			translate([0,0,-(tloustka_rafku-tloustka_zebrovani)/2]) cylinder(r=prumer/2-tloustka_rafku, h=tloustka_zebrovani, center=true, $fn=dokonalost_kruhu);
			translate([0,0,-(tloustka_rafku- tloustka_stredu)/2]) cylinder(r=prumer_stredu/2, h=tloustka_stredu, center=true, $fn=dokonalost_kruhu);
		}
		
		cylinder(r=prumer_hridele/2, h=tloustka_stredu*2, center=true, $fn=dokonalost_kruhu);	
	}
}


module vykrojeni(alfa,vnitrni_polomer,r,tloustka,sirka_okraje,polomer_rohu){
	b = sin(alfa/2) * r;

	intersection() {
		translate([r/2 + sirka_okraje/sin(alfa/2),0,0]){
			difference(){
				cube([r, 2*b, tloustka], center=true);
				union(){
					translate([-r/2,0,-tloustka]){
						rotate([0,0,alfa/2]){
							cube([r, b, tloustka*2], center=false);
						}
					}
					translate([-r/2 - sin(alfa/2) * b,-cos(alfa/2) * b,-tloustka]){
						rotate([0,0,-alfa/2]){
							cube([r, b, tloustka*2], center=false);
						}
					}
				}
			}
		}

		difference() {
			cylinder(r=r, h=tloustka, center=true,$fn=dokonalost_kruhu);
			cylinder(r=vnitrni_polomer, h=tloustka*2, center=true,$fn=dokonalost_kruhu);
		}
	}
}
