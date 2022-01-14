$fn = 500;

translate([0,0,20]){
    projection(cut=false) fuss();
}

module fuss(){
    difference(){
        cylinder(r=47.5, h=20);
        translate([0,0,18]){
            cylinder(r=37.5, h=10);
        }
        cube([60,35,40], center = true);
        translate([33.9,-1.4,13]){
            cylinder(r=1.5, h=7);
        }
        translate([-17.6,-28.9,13]){
            cylinder(r=1.5, h=7);
        }
        translate([-24.2, 23.7,13]){
            cylinder(r=1.5, h=7);
        }
        translate([18.251,21.374,17]){
            cylinder(r=5,h=10);
        }   
    }
}

