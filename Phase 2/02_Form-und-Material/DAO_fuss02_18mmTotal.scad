$fn = 500;

//translate([0,0,20]){
//    projection(cut=false) fuss();
//}
fuss();
module fuss(){
    difference(){
        cylinder(r=42.5, h=18);
        translate([0,0,16]){
            cylinder(r=37.5, h=10);
        }
        cube([60,35,40], center = true);
        translate([33.9,-1.4,11]){
            cylinder(r=1.5, h=7);
        }
        translate([-17.6,-28.9,11]){
            cylinder(r=1.5, h=7);
        }
        translate([-24.2, 23.7,11]){
            cylinder(r=1.5, h=7);
        }
        translate([18.251,21.374,15]){
            cylinder(r=5,h=10);
        }   
    }
}

