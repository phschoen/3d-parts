$e=0.01;
$fn=64;
module plug () {
    d=19.6;
    color("darkgray")
    minkowski() {
        translate([0,0,1])
        cylinder (d=d-2,h=5.75);
        sphere(d=2);
    }

    color("darkgray")
    cylinder (d2=d-0.1,d1=d+0.1,h=5.75);
    color("darkgray")
    translate([0,0,-2])
    cylinder (d=23,h=2);
}


module leveler () {
    
    // top
    color("white")
    translate([0,0,195])
    cylinder (d2=12,d1=4,h=6);
    
    // dots
    color("red")
    for(i=[10:20:150]) {
        translate([0,0,195-i]){
                cylinder (d2=7,d1=4,h=3);
            translate([0,0,3])
            cylinder (d1=7,d2=4,h=3);
        }
    }
    // staf
    color("white")
    translate([0,0,0.5])
    cylinder (d=4,h=200);
    
    // swimmer
    color("white")
    hull() {
        translate([0,0,0])
            cylinder(d=19);
        translate([0,0,45])
            sphere(d=19);
    }
}
module levelerplug () {
    color("darkgray")
    difference() {
        union() {
            cylinder (d=10,h=7.5+20);
            cylinder (d1=19.9,d2=20.1,h=5.75);
            translate([0,0,5.75])
                cylinder (d=23,h=2);
        }
        translate([0,0,-2])
        cylinder (d=8,h=30);
    }
}
//translate([50,0,0])
plug();
//
//levelerplug();
//
//translate([0,0,-55])
//if ($t<0.5)
//    translate([0,0,-115*$t*2])
//    leveler ();
//else
//    translate([0,0,-115+($t-0.5)*115*2])
//    leveler ();
//filler();


module filler () {
    color("darkgray")
    difference() {
        union() {
            difference() {
                union() {
                    cylinder (d=10,h=7.5+20);
                    cylinder (d1=19.9,d2=20.1,h=5.75);
                }
                translate([0,0,-2])
                cylinder (d=16,h=30);
             }
                    
            difference() {
                translate([0,0,5.75])
                    cylinder (d1=20,d2=75,h=45);
                translate([0,0,5.75+3])
                    cylinder (d1=20,d2=75,h=45);
                translate([0,0,-2])
                    cylinder (d=16,h=30);
            }
                
            translate([6,0,0])
            difference() {
                union() {
                    cylinder (d=8,h=7);
                    
                    translate([0,0,7])
                    rotate([0,42,0])
                    {
                       sphere(d=8);
                       cylinder (d=8,h=40);
                    }
                }
            }
        }
            translate([6,0,0]) {
            translate([0,0,-$e])
            cylinder (d=6,h=7+$e);
            
            translate([0,0,7])
            rotate([0,42,0])
            {
               sphere(d=6);
               cylinder (d=6,h=40+$e);
            }
        }
    }
}