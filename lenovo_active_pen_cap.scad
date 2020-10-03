$fn=64;
$e=0.1;

pen_d=9.5;
pen_h=15;
cap_clearence=0.1;
wall=2;

difference()
{
    hull()
    {
        cylinder(d=pen_d + 2* wall, h =pen_h);
        translate([0,0,pen_h+20])
        sphere(d=6);
    }

    translate([0,0,-$e])
    cylinder(d=pen_d, h =pen_h);

    translate([0,0,pen_h-2*$e])
    cylinder(d1=pen_d, d2=1, h =pen_d+8);
}
