//       ___________________________________________
//      | o                                        |
//      |                                          |
// 75mm |                                          |
//  |                                          |
//  |                                          |
//
//
//
//
//
//
//

$e = 0.1;
$fn=64;


module rumba_screws(h=2, d_extra=0) {
    rumba_screw_d =3;
    rumba_screw_pos= [
        [ (135-128)/2      ,(75-67)/2    ],
        [ (135-128)/2      ,(75-67)/2 +67],
        [ (135-128)/2 + 128,(75-67)/2    ],
        [ (135-128)/2 + 128,(75-67)/2 +36],
    ];
    for (i=rumba_screw_pos) {
        translate(i)
            cylinder(d=rumba_screw_d + d_extra, h = h);
    }
}

module rumba_power_conector() {
    // heatbead power out
    color("blue")
    translate([115,5,0])
        cube([10,5,10]);

    // heatbead power in
    color("blue")
    translate([104,5,0])
        cube([10,5,10]);

    // general power in
    color("blue")
    translate([93,5,0])
        cube([10,5,10]);

    // steper out x
    color("green")
    translate([30,70,0])
        cube([19.5,5,10]);

    // steper out y
    color("green")
    translate([50,70,0])
        cube([19.5,5,10]);

    // steper out z
    color("green")
    translate([70,70,0])
        cube([19.5,5,10]);

    // steper out e1
    color("green")
    translate([90,70,0])
        cube([19.5,5,10]);

    // steper out e2
    color("green")
    translate([110,70,0])
        cube([19.5,5,10]);
}

module rumba_pcb() {
    rumba_pcb_dim=[135,75,2];
    difference(){
        color("white")
        cube(rumba_pcb_dim);

        color("silver")
        translate([0,0,-$e])
            rumba_screws(h=2+2*$e);
    }

    // power connectors
    translate([0,0,rumba_pcb_dim[2]])
        rumba_power_conector();

    // usb
    usb_dim=[7.5+2,7.5+2,5];
    offset_usb=[0,9,0];
    color("gray")
    translate(offset_usb+[0,0,rumba_pcb_dim[2]])
        cube(usb_dim);
}

wall=2;
offset_pcb=[1+wall,10+wall,3+wall];
offset_display=[10,108,50];
rot_display=[40,0,-90];

%if(1)
{
    translate(offset_pcb)
        rumba_pcb();
    translate(offset_display)
    rotate(rot_display)
    display_module();
}

    translate([offset_pcb[0],offset_pcb[1],0] )
        mounting_holes(offset_pcb[2]);

    mounting_plate(wall, offset_pcb);



module xt60()
{

    color("yellow")
    hull() {
        cube([16,7.65,13.25]);
        translate([0,(7.65-2.8)/2,0])
        cube([16,2.8,15.55]);
    }

}


module mounting_holes(h) {
    wall=2;
    color("silver")
    difference() {
        rumba_screws(h=h, d_extra=3*wall );
        translate([0,0,-$e])
            rumba_screws(h=h+2*$e, d_extra=-0.5);
    }
}

module mounting_plate(wall,offset_pcb) {
    text_h=0.5;
    dim=[155,112,40];
    brim=10;
    translate([0,-brim,0])
    cube([dim[0],dim[1]+2*brim,0.3]);
    s=8;
    xt60_y=10;
    xt60_offset =[dim[0]-16-$e,s,20];
    xt60_offset2=[dim[0]-16-$e,s+xt60_y,20];
    xt60_offset3=[dim[0]-16-$e,s+2*xt60_y,20];
    xt60_offset4=[dim[0]-16-$e,s+3*xt60_y,20];
    difference () {
        union() {
            difference()
            {
                cube(dim);
                translate([wall,wall,wall])
                cube([dim[0]-2*wall,dim[1]- 2*wall, dim[2] +$e] );

                // usb cutout
                e=1;
                offset_usb=[0,9,0];
                usb_dim=[20,7.5+2,5];
                translate(offset_pcb)
                translate(offset_usb+[0,0,2] - [0,e,e])
                translate([-usb_dim[0]/2,0,0])
                cube(usb_dim+ [0,2*e,2*e]);

            }
            // backside
            translate([dim[0]-wall*3,0,0])
            cube([wall*2.5,dim[1],dim[2]]);

            //screw stands
            translate([0*(dim[0]-s),0*(dim[1]-s),0*(dim[1]-s)])
            cube([s,s,dim[2]]);
            translate([1*(dim[0]-s),0*(dim[1]-s),0*(dim[1]-s)])
            cube([s,s,dim[2]]);
            translate([0*(dim[0]-s),1*(dim[1]-s),0*(dim[1]-s)])
            cube([s,s,dim[2]]);
            translate([1*(dim[0]-s),1*(dim[1]-s),0*(dim[1]-s)])
            cube([s,s,dim[2]]);
        }

        scale(1.02) {
            translate(xt60_offset)
            xt60();
            translate(xt60_offset2)
            xt60();
            translate(xt60_offset3)
            xt60();
            translate(xt60_offset4)
            xt60();
        }

        // xt60 texts
        {
            translate([ dim[0]-text_h+$e, xt60_offset[1], xt60_offset[2] -5 ])
            rotate([90,0,90])
                own_text("in",4, text_h);
            translate([ dim[0]-text_h+$e, xt60_offset2[1], xt60_offset2[2] -5 ])
            rotate([90,0,90])
                own_text("in",4, text_h);
            translate([ dim[0]-text_h+$e, xt60_offset3[1], xt60_offset3[2] -5 ])
            rotate([90,0,90])
                own_text("bed",4, text_h);
            translate([ dim[0]-text_h+$e, xt60_offset4[1], xt60_offset4[2] -5 ])
            rotate([90,0,90])
                own_text("ext",4, text_h);
        }

        // limit switches
        //x
        translate([ dim[0] - text_h + $e, 48, 30]) {
            translate([-3*wall,6,-2.5])
                scale([2,1,1])
                jst(3);
            translate([-3*wall,6+16,-2.5])
                scale([2,1,1])
                jst(4);
            rotate([90,0,90])
                own_text("X",5, text_h);
        }
        //y
        translate([ dim[0] - text_h + $e, 48, 22]) {
            translate([-3*wall,6,-2.5])
                scale([2,1,1])
                jst(3);
            translate([-3*wall,6+16,-2.5])
                scale([2,1,1])
                jst(4);
            rotate([90,0,90])
                own_text("Y",5, text_h);
        }
        //z
        translate([ dim[0] - text_h + $e, 48, 14]) {
            translate([-3*wall,6,-2.5])
                scale([2,1,1])
                jst(3);
            translate([-3*wall,6+16,-2.5])
                scale([2,1,1])
                jst(4);
            rotate([90,0,90])
                own_text("Z",5, text_h);
        }
        //probe
        translate([ dim[0] - text_h + $e, 48, 6]) {
            translate([-3*wall,6,-2.5])
                scale([2,1,1])
                jst(3);
            translate([-3*wall,6+16,-2.5])
                scale([2,1,1])
                jst(4);
            rotate([90,0,90])
                own_text("P",5, text_h);
        }

        // sw
        translate([ dim[0] - text_h + $e, 46, 37]) {
            rotate([90,0,90])
                own_text("SW",5, text_h);
        }

        // motor
        translate([ dim[0] - text_h + $e, 66, 37]) {
            rotate([90,0,90])
                own_text("MOT",5, text_h);
        }
        //probe temp
        translate([ dim[0] - text_h + $e, 84, 30]) {
            translate([-3*wall,12,-2.5])
                scale([2,1,1])
                jst(2);
            rotate([90,0,90])
                own_text("ext",5, text_h);
        }
        //bed temp
        translate([ dim[0] - text_h + $e, 84, 22]) {
            translate([-3*wall,12,-2.5])
                scale([2,1,1])
                jst(2);
            rotate([90,0,90])
                own_text("bed",5, text_h);
        }
        //fan
        translate([ dim[0] - text_h + $e, 84, 14]) {
            translate([-3*wall,12,-2.5])
                scale([2,1,1])
                jst(2);
            rotate([90,0,90])
                own_text("fan",5, text_h);
        }
        //part
        translate([ dim[0] - text_h + $e, 84, 6]) {
            translate([-3*wall,12,-2.5])
                scale([2,1,1])
                jst(2);
            rotate([90,0,90])
                own_text("part",5, text_h);
        }


        // cooling rips
        for(i=[0:10]) {
            translate([30+i*10,wall,wall])
            cube([wall*2, dim[1]*2, dim[2]*0.3]);
            translate([30+i*10,wall,dim[2]*0.5+wall])
            cube([wall*2, dim[1]*2, dim[2]*0.3]);
        }

        screw_h=3;
        translate([0*(dim[0]-s),0*(dim[1]-s),0*(dim[1]-s)])
            translate([s/2,s/2,dim[2]-screw_h])
            cylinder(d=2.75,h=screw_h*2);
        translate([1*(dim[0]-s),0*(dim[1]-s),0*(dim[1]-s)])
            translate([s/2,s/2,dim[2]-screw_h])
            cylinder(d=2.75,h=screw_h*2);
        translate([0*(dim[0]-s),1*(dim[1]-s),0*(dim[1]-s)])
            translate([s/2,s/2,dim[2]-screw_h])
            cylinder(d=2.75,h=screw_h*2);
        translate([1*(dim[0]-s),1*(dim[1]-s),0*(dim[1]-s)])
            translate([s/2,s/2,dim[2]-screw_h])
            cylinder(d=2.75,h=screw_h*2);
    }


}

module own_text(text="asdf", size=3, text_h=0.2) {
    font="Lberation Sans";
    color("red")
    linear_extrude(height = text_h) {
        text(text = text, font = font, size = size, valign = "center");
    }
}

module jst(pol=2)
{
    color("lightgray")
    cube([7, 2.5*(1+pol) ,5.7]);
}


module display_module() {
    // pcb
    pcb = [105, 47, 1.65];

    difference() {
        union() {
            color("darkgray")
            cube(pcb);

            // sd card slot
            display_module_sd_card(19);

            // display
            color("black")
            translate([13, 3.6, 1.65])
            cube([58.25, 39, 7.8-1.65]);

            display_cut(0.1);

            // nub

            // button
            display_sw_cut(extendlength = 0);

            display_encoder_cut(extendlength = 0);
        }

        translate([0,0,-$e])
        display_screw_cut( extendlength = 2*$e);
    }

}
module display_module_sd_card(extendlength = 0) {
    color("orange")
    translate([-extendlength, 13.1,-2.90])
    cube ( [16.65+extendlength, 26.6, 2.90] );
}

module display_cut(extendlength = 0) {
    color("green")
    translate([15, 10.75 ,7.8])
    cube ( [53.5, 28.7, 1 + extendlength] );
}
module display_sw_cut(extendlength = 0) {
    color("black")
    translate([92,8.75, 1.65]) {
        translate([-5.95/2, -6/2, 0])
            cube ( [5.95, 6, 3.82]);
        cylinder(d=3.45, h= 10+extendlength);
    }
}
module display_encoder_cut(extendlength = 0) {
    color("silver")
    translate([92, 26.6, 1.65]) {
        translate([-12/2, -12/2, 0])
            cube ( [12, 12, 4.5]);
        cylinder(d=6.85, h= 19.5+ extendlength);
    }
}

module display_screw_cut(extendlength = 0) {
    d=3.1;
    r=d/2;
    h=1.65+ extendlength;

    // bot left
    color("silver")
    translate([7.5+r, 1.5+r, 0]) {
        cylinder(d=d, h=h);
    }
    // top left
    color("silver")
    translate([7.5+r, 42.13+r, 0]) {
        cylinder(d=d, h=h);
    }
    // bot right
    color("silver")
    translate([100.5+r, 1.5+r, 0]) {
        cylinder(d=d, h=h);
    }
    // top right
    color("silver")
    translate([100.5+r, 42.13+r, 0]) {
        cylinder(d=d, h=h);
    }
}

module top_cover() {

}
