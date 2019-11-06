

use <lib/cylinder.scad>;
use <lib/cube.scad>;
$pi=3.14159265359;
$fn=64;
$e=0.1;
needle_mat_h=2;
needle_h=10.5;
needle_space=1;
drum_space=needle_mat_h*2+needle_h+needle_space;
echo(drum_space);
roll1_u= 180;
roll1_d= roll1_u/$pi; //U=2·π·r,
roll2_u= 495;
roll2_d= roll2_u/$pi; //U=2·π·r,
rood1_d=8;
rood2_d=3;

roll_w= 130;

// thickness of the wood plates
wood_t=18;
wood_nut=8;
show_mate=1;

module drum(d,h)
{
    difference() {
        count=floor(h/wood_t);
        rest=h-(count*wood_t);
        for ( i = [0 : count] ){
            color([i/6,0.5,i/8])
            translate([0,0,wood_t*i])
            if (count == i) {
                cylinder(d=d,h=rest);
            } else {
                cylinder(d=d,h=wood_t);
            }
        }
    
        // center rood
        translate([0,0,-$e])
        cylinder(d=rood1_d,h=h+2*$e);
    
        // 2 roods for staple the roods
        translate([d/4,0,-$e])
        cylinder(d=rood2_d,h=h+2*$e);
        translate([-d/4,0,-$e])
        cylinder(d=rood2_d,h=h+2*$e);
    }
    
    
}
module needle()
{
    color("silver"){
        //cylinder(d=0.6,h=needle_h);
        a=20;
        s=(needle_h/2)/cos(a);
        rotate([0,a,0])
        cylinder(d=0.6,h=s);
        translate([0,0,needle_h])
        rotate([0,180-a,0])
        cylinder(d=0.6,h=s);
    }
}
module needle_mat(d,h)
{
    color("lightblue")
    difference() {
        cylinder(d=d+2*needle_mat_h,h=h);
        translate([0,0,-$e])
        cylinder(d=d,h=h+2*$e);
        
    }
    count= h/5;
    for ( r = [0 : 10 : 330] )
    for ( i = [0 : count] ) {
        rotate([0,0,r])
        translate([0,-(d+2*needle_mat_h)/2,1+i*5])
        rotate([90,0,0])
        needle();
    }
    
}

plate_l=roll1_d+roll2_d+drum_space*3+wood_t+50;
module bot_plate() {
        translate([-roll2_d-drum_space-wood_t,-wood_t,-wood_nut])
        color("brown")
        cube([plate_l,
              wood_t,
              roll_w+2*wood_nut]);
}

module side_plate() {
        translate([-roll2_d-drum_space-wood_t,-wood_t-10,-wood_t])
        rounded_cube([plate_l,roll2_d,wood_t],r=3,[1,1,0]);
}

translate([roll1_d/2,roll1_d/2+drum_space,0])
{
    if(show_mate) {
        translate([0,0,-$e])
        %needle_mat(roll1_d,roll_w-$e*2);
    }
    drum(roll1_d,roll_w);
}
translate([-roll2_d/2-drum_space/2,roll2_d/2+drum_space,0]) 
{
    if(show_mate) {
        translate([0,0,-$e])
        %needle_mat(roll2_d,roll_w-$e*2);
    }
    drum(roll2_d,roll_w);
}

bot_plate();
side_plate();