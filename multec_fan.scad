use <lib/path_extrude.scad>;
$fn=32;
$e =0.1;
module fan()
{
    l= 75;
    screw_l=66;
    h=11;
    l_tot=86;
    off=l_tot-l;


    difference()
    {
        color("darkgray")
        hull() {
            cube([l,off,h]);
            translate([l/2,l/2+off,0])
            cylinder(d=l,h=h);
        }

        // screw
        color("orange")
        for( i=[1,-1]) {
            translate([i*screw_l/2,0])
            translate([l/2,$e,h/2]) {

                rotate([90,0,0])
                cylinder(d=3,h=h);
            }
        }
    }

}

%fan();
//fan_connector();


module fan_connector()
{
    l= 75;
    screw_l=66;
    screw_l_mul=46;
    h=11;
    l_tot=86;
    off=l_tot-l;

    fan_w=56;
    fan_h=6.5;

    fan_w_end=20;
    fan_h_end=3;
    dist=5;
    mount=10;

    screw_thickness=5;
    difference()
    {
        union() {
            // main mount plate
            translate([0,-screw_thickness,0])
            cube([l,screw_thickness,h+dist+mount]);

            // middle support part
            translate([l/2,-screw_thickness-2,0])
            translate([-38/2,0,h+dist])
            cube([38,screw_thickness,mount]);
        }


        //screw fan
        color("orange")
        for( i=[1,-1]) {
            translate([i*screw_l/2,0])
            translate([l/2,$e,h/2]) {

                rotate([90,0,0])
                cylinder(d=3,h=h);
            }
        }

        //screw multec
        color("orange")
        for( i=[1,-1]) {
            translate([i*screw_l_mul/2,0,h/2+dist+mount/2])
            translate([l/2,$e,h/2]) {

                rotate([90,0,0])
                cylinder(d=3,h=h);
            }
        }

        //fan openening
        translate([l/2,$e,h/2])
        {
            translate([-fan_w/2,-screw_thickness-$e*2,-fan_h/2])
            cube([fan_w,screw_thickness*2,fan_h]);
        }
    }


    // fan reduce pice
    cube([fan_w,screw_thickness*2,fan_h]);
    translate([-fan_w/2,-screw_thickness-$e*2,-fan_h/2])
    cube([fan_w,screw_thickness*2,fan_h]);

}


module fan_inner() {

    fan_w=56;
    fan_h=6.5;

    fan_w_end=20;
    fan_h_end=3;
    linear_extrude(height = 40, scale=[fan_w_end/fan_w,fan_h_end/fan_h], $fn=100)
    square([fan_w, fan_h]);

    translate([0, -7, 40])
    for(i=[0:10:90])
        {
            rotate([i+90,0,0])
            translate([0, 0, -10])
            cube([fan_w_end, fan_h_end,3]);
        }
        /* translate([-$e,0,0]) */
        /* path_extrude(exShape=fan_inner, exPath=myPath); */
}


    difference()
    {
        translate([0,0,0])
        fan_inner();
        translate([2,2,0])
        scale([0.8,0.1,1])
        fan_inner();
    }
