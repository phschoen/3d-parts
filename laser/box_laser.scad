with_handle= 1; 
with_grip = 0;
boxsize=[50,50,50]; t=3;
boxsize=[260, 305-30 , 345-8]; t=30; // sizes for ikea botom row

//boxsize=[(480-10)/2, 450 , 150]; t=21; // sizes for ikea botom row

wall=3;
$e=0.1;
    

show_box = 0;              // show assembled box
show_projection_bot = 1;   // show bot plates
show_projection_front = 1; // show front plates
show_projection_side = 1;  // show side plates


show_test_clear = 0;       // test for clearence
show_cube = 0;             // test helper cube
show_aligned = 0;          // test for alignment 


//clear=-1*[0.0,0.25,0.5,0.75];
//clear=1*[0.0,0.25,0.5,0.75];
//clear=-1*[0.06,0.07,0.08,0.09];
clear=-1*[0.08,0.08,0.08,0.08];
teathlen_extra=0.2;

edge_clear=[wall*3,wall*3];
edge_clear_4 = [edge_clear,edge_clear,edge_clear,edge_clear];

if(with_grip) {
    w=100;
    h=50;
    d=30;
    //plate
    if(1)
    {
        l =sqrt(h*h+d*d); 
        translate([0,d,0])
        rotate([-59,0,0])
        translate([0,-l,0])
        difference()   {
            translate([w/2,l/2 + wall-1.5,0])
            plates([w,l,wall],edge_clear_4*0.1,[t,-6,0,-6],teathlen_extra,clear*0);
        }
    }
    
    // anglepart
    for (i=[0,w-wall])
    translate([wall+i,0,0])
    rotate([90,0,-90])
    difference() {
        linear_extrude(height = wall)
            polygon(points=[[-d,0],[0,0],[0,h]]);
        translate([$e,-$e,-$e])
        rotate([0,0,90])
        connection(0, h+$e*2, edge_clear*0, t, wall+teathlen_extra+$e, wall+$e*2, clear[2]*0);
        
        translate([$e,-$e,-$e])
        translate([-d+wall,0,0])
        rotate([0,0,-31.5])
        translate([0,-wall,0])
        rotate([0,0,90])
        connection(0, h+wall*2+$e*2, edge_clear*0, 6, wall+teathlen_extra+$e, wall+$e*2, clear[2]*0);

    }
}


{
    if (show_cube) {
        translate([-boxsize[0]/2,-boxsize[1]/2,0])
            % cube(boxsize);
    }

    if (show_aligned) {
        
        boxsize=[50, 80 , 40]; t=5;
        // bot
        //color("red")
        plates([boxsize[0],boxsize[1],wall],edge_clear_4,[-t,-t,-t,-t],teathlen_extra,clear);
        
        translate([0,0,wall*2+1])
        rotate([0,0,180])
        plates([boxsize[0],boxsize[1],wall],edge_clear_4,[-t,-t,-t,-t],teathlen_extra,clear);
        
        translate([0,0,wall+0.5])
        rotate([0,0,180])
        plates([boxsize[0],boxsize[1],wall],edge_clear_4,[t,t,t,t],teathlen_extra,clear);
    }

    if(show_box) {
        
        // bot
        color("green")
        plates([boxsize[0],boxsize[1],wall],edge_clear_4,[t,t,t,t],teathlen_extra,clear);

        // left
        color("blue")
         translate([boxsize[0]/2-wall,0,boxsize[2]/2])rotate([0,90,0])
        plates([boxsize[2]-teathlen_extra,boxsize[1],wall],edge_clear_4,[-t,-t,-t,0],teathlen_extra,clear);

        // right
        color("red")
         translate([-boxsize[0]/2,0,boxsize[2]/2])rotate([0,90,0])
        plates([boxsize[2]-teathlen_extra,boxsize[1],wall],edge_clear_4,[-t,-t,-t,0],teathlen_extra,clear);
                
        // front
        color("orange")
         translate([0,boxsize[1]/2-wall,boxsize[2]/2])rotate([0,0,90])rotate([0,90,0])
        difference(){
            plates([boxsize[2]-teathlen_extra,boxsize[0],wall],edge_clear_4,[t,-t,t,0],teathlen_extra,clear);
            if (with_handle) hull() {
                width=boxsize[0]/2;
                h=boxsize[2]/10;
                translate([-boxsize[2]/2+1.75*h,(width-h)/2,-1])
                cylinder(d=h,h=wall*2);            
                translate([-boxsize[2]/2+1.75*h,-(width-h)/2,-1])
                cylinder(d=h,h=wall*2);
            }else if(with_grip) {
                linear_extrude(height = 5)
                polygon(points=[[0,0],[100,0],[130,50],[30,50]]);
            }
        }
        
        // back
        color("gray")
         translate([0,-boxsize[1]/2,boxsize[2]/2])rotate([0,0,90])rotate([0,90,0])
        plates([boxsize[2]-teathlen_extra,boxsize[0],wall],edge_clear_4,[t,-t,t,0],teathlen_extra,clear);
    } else  if (show_test_clear) {
        
        boxsize=[50, 50 , 50]; t=5;
        // bot
        //color("red")
        projection(cut = false) 
        translate([0,0,10])
        difference() {
            plates([boxsize[0],boxsize[1],wall],edge_clear_4,[t,t,t,t],teathlen_extra,clear);
            for(i=[0:1:3])
                rotate([0,0,270+i*90])linear_extrude(wall*2)text(text = str("  clear"," ",clear[i]), font = font, size = 3);
        }
        
        
        projection(cut = false) 
        translate([boxsize[0]+10,0,10])
        difference() {
            plates([boxsize[0],boxsize[1],wall],edge_clear_4,-1*[t,t,t,t],teathlen_extra,clear);
            for(i=[0:1:3])
                rotate([0,0,270+i*90])linear_extrude(wall*2)text(text = str("  clear"," ",clear[i]), font = font, size = 3);
        }
    }
    else {
        if(show_projection_bot) {
            projection(cut = false)
                translate([0,0,10])
                    plates([boxsize[0],boxsize[1],wall],edge_clear_4,[t,t,t,t],teathlen_extra,clear);
        }
        if(show_projection_front) {
            // left
            projection(cut = false) 
                translate([boxsize[2],0,10])
                    plates([boxsize[2]-teathlen_extra,boxsize[1],wall],edge_clear_4,[-t,-t,-t,0],teathlen_extra,clear);
            
            // right
            //plates([boxsize[2]-teathlen_extra,boxsize[1],wall],edge_clear_4,[-t,-t,-t,0],teathlen_extra,clear);
        }
        if(show_projection_side) {
            projection(cut = false)
                translate([-boxsize[2],0,10]) {        
            // front
                    difference(){
                        plates([boxsize[2]-teathlen_extra,boxsize[0],wall],edge_clear_4,[t,-t,t,0],teathlen_extra,clear);
                        if (with_handle) {
                            hull() {
                                width=boxsize[0]/2;
                                h=boxsize[2]/10;
                                translate([-boxsize[2]/2+1.75*h,(width-h)/2,-1])
                                cylinder(d=h,h=wall*2);            
                                translate([-boxsize[2]/2+1.75*h,-(width-h)/2,-1])
                                cylinder(d=h,h=wall*2);
                            }
                        }
                    }
                    
                    // back
                    //plates([boxsize[2]-teathlen_extra,boxsize[0],wall],edge_clear_4,[t,-t,t,0],teathlen_extra,clear);
                }
        }
    }
}

module plates(size,edge_clear, tooth_number,teethlen_extra,teeth_clear) {
    real_size=[size[0]+teethlen_extra*2,size[1]+teethlen_extra*2,size[2]];

    difference()
    {
        color("gray") {
            translate([-real_size[0]/2,-real_size[1]/2,0])
                cube(real_size);
        }
        
        translate([0,0,-$e]) {
            // xy bot
            translate([-real_size[0]/2-$e,-real_size[1]/2-$e,0]) {
                if(tooth_number[0] < 0) {
                    connection(1, real_size[0]+$e*2, edge_clear[0], abs(tooth_number[0]), size[2]+teethlen_extra+$e, size[2]+$e*2, teeth_clear[0]);
                }
                if(tooth_number[0] > 0)  {
                    connection(0, real_size[0]+$e*2, edge_clear[0], abs(tooth_number[0]), size[2]+teethlen_extra+$e, size[2]+$e*2, teeth_clear[0]);
                }
            }
            
            // xy right
            rotate([0,0,90])
            translate([-real_size[1]/2-$e,-real_size[0]/2-$e,0]) {
                if(tooth_number[1] < 0) {
                    connection(1, real_size[1]+$e*2, edge_clear[1], abs(tooth_number[1]), size[2]+teethlen_extra+$e, size[2]+$e*2, teeth_clear[1]);
                }
                if(tooth_number[1] > 0)  {
                    connection(0, real_size[1]+$e*2, edge_clear[1], abs(tooth_number[1]), size[2]+teethlen_extra+$e, size[2]+$e*2, teeth_clear[1]);
                }
            }
            
            // xy top
            rotate([0,0,180])
            translate([-real_size[0]/2-$e,-real_size[1]/2-$e,0]) {
                if(tooth_number[2] < 0) {
                    connection(1, real_size[0]+$e*2, edge_clear[2], abs(tooth_number[2]), size[2]+teethlen_extra+$e, size[2]+$e*2, teeth_clear[2]);
                }
                if(tooth_number[2] > 0)  {
                    connection(0, real_size[0]+$e*2, edge_clear[2], abs(tooth_number[2]), size[2]+teethlen_extra+$e, size[2]+$e*2, teeth_clear[2]);
                }
            }
            
            // xy left
            rotate([0,0,270])
            translate([-real_size[1]/2-$e,-real_size[0]/2-$e,0]) {
                if(tooth_number[3] < 0) {
                    connection(1, real_size[1]+$e*2, edge_clear[3], abs(tooth_number[3]), size[2]+teethlen_extra+$e, size[2]+$e*2, teeth_clear[3]);
                }
                if(tooth_number[3] > 0)  {
                    connection(0, real_size[1]+$e*2, edge_clear[3], abs(tooth_number[3]), size[2]+teethlen_extra+$e, size[2]+$e*2, teeth_clear[3]);
                }
            }
            
        }
    }
}

module connection(is_fether, length, edge_clear, tooth_number, tooth_len, tooth_h, tooth_clear) {
    tooth_width = (length -edge_clear[0] - edge_clear[1]-tooth_clear*2) / (tooth_number*2-1);
    echo (length);
    echo (edge_clear);
    echo (tooth_clear);
    echo (tooth_number);
    echo (tooth_width);

    translate([0,0,0]) {
        translate([edge_clear[0]+tooth_clear,0,0])
        for( i = [0:1:tooth_number-1]) {
            if(is_fether)
                color ("blue")
                translate([tooth_width*i*2-tooth_clear,0,0])
                    cube([tooth_width+tooth_clear*2, tooth_len, tooth_h]);
            else if (i < tooth_number-1)
                color ("green")
                translate([tooth_width+tooth_width*(i)*2-tooth_clear,0,0])
                    cube([tooth_width+tooth_clear*2, tooth_len, tooth_h]);
        }

        color ("orange")
        if(0==is_fether) {
            cube([edge_clear[0]+tooth_clear*2,tooth_len ,tooth_h]);
            translate([length-edge_clear[1]-2*tooth_clear,0,0])
            cube([edge_clear[1]+tooth_clear*2,tooth_len ,tooth_h]);
        }
    }
}
