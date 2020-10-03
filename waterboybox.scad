
use <lib/OLED_13_128_64.scad>;

use <lib/DHT22.scad>;
use <lib/ESP8266Models.scad>;


module nodeMCU_screwholes(d=3,h=4) {
    
    HD = 3.0;
    XDim = 25.0;
    YDim = 48.0;
    HXO = 2.0;
    HYO = 2.2;
    ZDim=5;
    translate([-XDim/2+HXO, YDim/2-HYO,0])
        cylinder(d=d, h=h, center=true);
    translate([XDim/2-HXO, YDim/2-HYO,0])
        cylinder(d=d, h=h, center=true);
    translate([-XDim/2+HXO, -YDim/2+HYO,0])
        cylinder(d=d, h=h, center=true);
    translate([XDim/2-HXO, -YDim/2+HYO,0])
        cylinder(d=d, h=h, center=true);
}


module mosfet_module() {
    dim_x=16.5;
    dim_y=33.25;
    dim_pcb_z=1.2;
    
    difference() {
        // pcb 
        color("black")
        cube([dim_x,dim_y,dim_pcb_z]);
    
        // screw_holes
        mosfet_module_screw();
    }
    color("white")
    translate([0,0,dim_pcb_z]) 
    linear_extrude(height = 0.3)
    {
        translate([2.3,7,2])     
        rotate([0,0,-90])      
        text("GND", size = 1);
        
        translate([13,7,2])     
        rotate([0,0,-90])                 
        text("PWM", size = 1);
        
        translate([2.3,28,2])     
        rotate([0,0,-90])      
        text("-", size = 3);
        
        translate([8,28,2])     
        rotate([0,0,-90])                 
        text("load", size = 2);
        
        translate([13,28,2])     
        rotate([0,0,-90])                 
        text("+", size = 2);
    }
}

module mosfet_module_screw(h=4,d=3) {
    offset_x=2;
    offset_y=2.4;
    
    dim_x=16.5;
    dim_y=33.25;
    dim_pcb_z=1.2;
    color("silver")
    translate([offset_x,offset_y])
    cylinder(d=d,h=h,center=true);
    
    color("silver")
    translate([dim_x-offset_x,offset_y])
    cylinder(d=d,h=h,center=true);
}

module power_meter_module() {
    dim_x=13;
    dim_y=31.5;
    dim_pcb_z=1.6;
    
    difference() {
        // pcb 
        color("lightblue")
        cube([dim_x,dim_y,dim_pcb_z]);
    
        // screw_holes
        power_meter_module_screw();
    }
    
    color("white")
    translate([0,0,dim_pcb_z]) 
    linear_extrude(height = 0.3)
    {
        translate([2.3,4.6,2])           
        text("vcc", size = 1);
        
        translate([5.4,4.6,2])               
        text("out", size = 1);
                  
        translate([9,4.6,2])        
        text("gnd", size = 1);
    }
}

module power_meter_module_screw(h=4,d=3) {
    offset_x=2;
    offset_y=17.2;
    
    dim_x=13;
    dim_y=31.5;
    dim_pcb_z=1.6;
    color("silver")
    translate([offset_x,offset_y])
    cylinder(d=d,h=h,center=true);
    
    color("silver")
    translate([dim_x-offset_x,offset_y])
    cylinder(d=d,h=h,center=true);
}


module step_down_module() {
    dim_x=21.1;
    dim_y=43.36;
    dim_pcb_z=1.6;
    
    difference() {
        union() {
            // pcb 
            color("lightblue")
            cube([dim_x,dim_y,dim_pcb_z]);
            
            // kondensators 1
            translate([10,5,dim_pcb_z])
            color("silver")
            cylinder(d=8,h=10.6);
            
            // kondensators 2
            translate([10,38.5,dim_pcb_z])
            color("silver")
            cylinder(d=8,h=10.6);
            
            // coil 2
            translate([8,21.5,dim_pcb_z])
            color("black")
            cube([12.2,12.2,7]);
            
            // potti
            translate([1.5,24,dim_pcb_z])
            {
                color("blue")
                cube([4.3,9.5,10]);
                
                
                translate([2.3/2,2.3/2,10])
                color("gold")
                cylinder(d=2.3,h=1.5);
            }
            
            // text in 
            translate([0,0,dim_pcb_z])
            color("black")
            linear_extrude(height = 0.1)
            {
                translate([3+3,0,0])
                rotate([0,0,90])                
                text("in+", size = 2);
                translate([3+14,0,0])
                rotate([0,0,90])                
                text("in-", size = 2);
                
                
                translate([3+3,37,0])
                rotate([0,0,90])                
                text("out+", size = 2);
                translate([3+14,37,0])
                rotate([0,0,90])                
                text("out-", size = 2);
            }
        }
    
        // screw_holes
        step_down_module_screw();
    }
}

module step_down_module_screw(d=3, h=4) {
    offset_x=2.5;
    offset_y=6.6;
    
    dim_x=21.1;
    dim_y=43.36;
    dim_pcb_z=1.6;
    color("silver")
    translate([offset_x,offset_y])
    cylinder(d=d,h=h,center=true);
    
    color("silver")
    translate([dim_x-offset_x,dim_y-offset_y])
    cylinder(d=d,h=h,center=true);
}

module oled_screw_pos(d=2.75,h=10) {

    color("silver")
    translate([0,-1.25,-5])
    {
      translate([4,3,-1])
        rotate([0,0,0])
          cylinder(d=d,h=h);
        translate([4,33,-1])
          rotate([0,0,0])
            cylinder(d=d,h=h);
        translate([32,3,-1])
          rotate([0,0,0])
            cylinder(d=d,h=h);
        translate([32,33,-1])
          rotate([0,0,0])
            cylinder(d=d,h=h);
     }
}

module case_bot() {
    screw_m3_d      = 2.75;
    screw_m3_d_loos = 3.25;
    screw_m2_d      = 1.75;
    screw_m2_d_loos = 2.25;
    dim_x=83;
    dim_y=50;
    dim_z=17;
            d=3;
    difference() {
        translate([d/2,d/2,d/2])
        minkowski() { 
                cube([dim_x+wall*2-d,dim_y+wall*2-d,wall*2+dim_z-d]);
                sphere(d=d);
        }
        
        // top planecut
        translate([0,0,dim_z])
        cube([dim_x+wall*2,dim_y+wall*2,dim_z]);
        
        // inner cutout 
        
        translate([wall,wall,wall])
        cube([dim_x,dim_y,dim_z]);
        
        // usb cutout
        translate([11,0,5]){
            // hole
            cube([9,4,4]);
            // plugplace
            translate([-1.5,-2-0.8,-0.5])
            cube([9+3,4,4+1]);
        }
    }
    translate([-8,dim_y-10,0])
    difference() {
        cube([10,10,wall]);
        translate([5,5,-0.1])
        cylinder(d=4,h=wall*2);
    }
    translate([dim_x+wall,dim_y-10,0])
    difference() {
        cube([10,10,wall]);
        translate([5,5,-0.1])
        cylinder(d=4,h=wall*2);
    }
    
    // lcd
    translate([3,15,17])
    translate([0.75,35.5,0])
    rotate([0,0,-90]) {
        //OLED_13_128_64_I2C(0,0);
        //oled_screw_pos(with_screw_mount);
    }
    
    // esp
    translate([12.5+wall+1,24+wall+.5,0.8+wall]) rotate([0,0,0]){
        %translate([0,0,wall]) NodeMCU(pins=0, phmc="Red", phfc="DarkGrey");
        
        difference() {
            nodeMCU_screwholes(d=screw_m3_d+wall*2,h=2);
            nodeMCU_screwholes(d=screw_m3_d,h=4);
        }
    }
    
    
    translate([26.5+wall,wall+17,wall+wall]) rotate([0,0,-90]){
        %translate([0,0,wall]) mosfet_module();
        difference() {
            mosfet_module_screw(d=screw_m2_d+wall*2,h=3);
            mosfet_module_screw(d=screw_m2_d,h=4);
        }
        translate([8-5,20-5,0])
        cube([10,10,3]);
    }

    translate([26+0.5+wall,35+wall,wall]) rotate([0,0,-90]){
        % translate([0,0,wall]) power_meter_module();
        difference() {
            power_meter_module_screw(d=screw_m3_d+wall*2,h=3);
            power_meter_module_screw(d=screw_m3_d,h=4);
        }
    }

    translate([50+wall,30+wall,wall]) rotate([0,0,180]){
       %translate([0,0,22])DHT22();
    }

    translate([63,wall+0.5,wall]){
        % translate([0,0,wall]) step_down_module();
        
        difference() {
            step_down_module_screw(d=screw_m3_d+wall*2,h=3);
            step_down_module_screw(d=screw_m3_d,h=4);
        }
    }
    
    translate([3.5,3.5,dim_z-3.6])
    case_screw_mount();
    
    
    translate([dim_x+0.5,3.5,dim_z-3.6])
    case_screw_mount();
    
    
    translate([3.5,dim_y+0.5,dim_z-3.6])
    case_screw_mount();
    
    
    translate([dim_x+0.5,dim_y+0.5,dim_z-3.6])
    case_screw_mount();

    
}
    screw_m3_d      = 2.75;
    screw_m3_d_loos = 3.25;
    screw_m2_d      = 1.75;
    screw_m2_d_loos = 2.25;

module top_plate() {
    dim_x=83;
    dim_y=50;
    dim_z=17;
    d=3;
    
    difference() {
        union() {
            difference() {
                intersection() {
                    translate([d/2,d/2,d/2])
                    minkowski() { 
                            cube([dim_x+wall*2-d,dim_y+wall*2-d,wall*2+dim_z-d]);
                            sphere(d=d);
                    }
                    
                    // top planecut
                    translate([0,0,dim_z])
                    cube([dim_x+wall*2,dim_y+wall*2,dim_z]);
                }        
                
                // inner cutout 
                translate([wall,wall,wall])
                cube([dim_x,dim_y,dim_z]);
            }
            
            // dht22 step
            translate([50+wall,30+wall,dim_z]) rotate([0,0,180]){
               %translate([0,0,2.5])DHT22();
            
               translate([0,-13,0])
                difference() {
                    cylinder(d=screw_m3_d+wall*2,h=3);
                }
            }
            
            // LED step
            color("green")
                translate([7,15,dim_z]){
                    h=4;
                    translate([0.75,35.5,h+wall]) {
                        rotate([0,0,-90]) {
                            difference()  {
                                oled_screw_pos(d=screw_m3_d+wall,h=4);
                                color("gray")
                                oled_screw_pos(d=screw_m3_d,h=3);
                            }
                        }
                    }
                }
            
        }
        
        
        //dht22 cut
        translate([50+wall,30+wall,dim_z]) rotate([0,0,180]){
           translate([-8,-10.25,0])cube([16,20.5,5]);
        }
       % translate([50+wall,30+wall,dim_z-wall]) rotate([0,0,180]){
        
           translate([0,-13,0])
                cylinder(d=screw_m3_d,h=4);
        }
        
        // LCD cut
        translate([7,15,dim_z])
        translate([0.75,35.5,0]) {
            translate([0,0,-0.8])
            rotate([0,0,-90]) {
                %OLED_13_128_64_I2C(0,0);
            }
            translate([3,-29,0])cube([28,19,10]);
        }
            
    color("green")
        translate([7,15,dim_z])
        translate([0.75,35.5,7.5]) {
            rotate([0,0,-90]) {
                difference()  {
                    oled_screw_pos(d=screw_m3_d,h=2);
                }
            }
        }
        
        // plate mount 
            
        translate([3.5,3.5,16.5])
        case_screw_mount(diff_only=1,h=200);
        
        
        translate([dim_x+0.5,3.5,16.5])
        case_screw_mount(diff_only=1,h=200);
        
        
        translate([3.5,dim_y+0.5,16.5])
        case_screw_mount(diff_only=1,h=200);
        
        
        translate([dim_x+0.5,dim_y+0.5,16.5])
        case_screw_mount(diff_only=1,h=200);
    }

    
}
module screw_mount(h=20) {
    
    screw_m3_d      = 2.75;
    screw_m3_d_loos = 3.25;
    screw_m2_d      = 1.75;
    screw_m2_d_loos = 2.25;
    difference() {
        cylinder(d=screw_m3_d+wall*2,h=h);
        translate([0,0,-0.01])
        cylinder(d=screw_m3_d,h=h+0.02);
    }

}

module case_screw_mount(diff_only=0,h=3.5){
    
    screw_m3_d      = 2.75;
    screw_m3_d_loos = 3.25;
    screw_m2_d      = 1.75;
    screw_m2_d_loos = 2.25;
    
    if(diff_only == 0) {
        difference() {
            union() {
                cylinder(d=screw_m3_d+wall*2,h=h);
                sphere(d=screw_m3_d+wall*2);
            }
            translate([0,0,-0.01])
            cylinder(d=screw_m3_d,h=h+0.02);
        }
    } else {
        translate([0,0,-0.01])
        cylinder(d=screw_m3_d,h=h+0.02);
    }
}

$fn=32;




wall=2;

//case_bot();


translate([0,0,50])
top_plate();