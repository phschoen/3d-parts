$fn=36;


module traks()
  translate([0.15,0,0])
  {
  color("Silver")
    hull()
      {
        translate([1.9,0,1.95])
          cylinder(d=0.2,h=0.1);
        translate([-1.9,0,1.95])
          cylinder(d=0.2,h=0.1);
      }

  translate([0,0.5,0])
    color("Silver")
      hull()
        {
        translate([1.8,0,1.95])
          cylinder(d=0.2,h=0.1);
        translate([-1.8,0,1.95])
          cylinder(d=0.2,h=0.1);
        }
translate([0,-0.5,0])
    color("Silver")
      hull()
        {
        translate([1.8,0,1.95])
          cylinder(d=0.2,h=0.1);
        translate([-1.8,0,1.95])
          cylinder(d=0.2,h=0.1);
        }
  
  translate([0,1,0])
    color("Silver")
      hull()
        {
        translate([1.65,0,1.95])
          cylinder(d=0.2,h=0.1);
        translate([-1.55,0,1.95])
          cylinder(d=0.2,h=0.1);
        }
translate([0,-1,0])
    color("Silver")
      hull()
        {
        translate([1.65,0,1.95])
          cylinder(d=0.2,h=0.1);
        translate([-1.65,0,1.95])
          cylinder(d=0.2,h=0.1);
        }

  translate([0,1.5,0])
    color("Silver")
      hull()
        {
        translate([1.4,0,1.95])
          cylinder(d=0.2,h=0.1);
        translate([-1.4,0,1.95])
          cylinder(d=0.2,h=0.1);
        }
translate([0,-1.5,0])
    color("Silver")
      hull()
        {
        translate([1.4,0,1.95])
          cylinder(d=0.2,h=0.1);
        translate([-1.4,0,1.95])
          cylinder(d=0.2,h=0.1);
        }

translate([0,-1.5,0])
    color("Silver")
      hull()
        {
        translate([1.4,0,1.95])
          cylinder(d=0.2,h=0.1);
        translate([1.7,0.5,1.95])
          cylinder(d=0.2,h=0.1);
        }
translate([0,-1,0])
    color("Silver")
      hull()
        {
        translate([1.7,0,1.95])
          cylinder(d=0.2,h=0.1);
        translate([1.85,0.5,1.95])
          cylinder(d=0.2,h=0.1);
        }
translate([0,-0.5,0])
    color("Silver")
      hull()
        {
        translate([1.85,0,1.95])
          cylinder(d=0.2,h=0.1);
        translate([1.9,0.5,1.95])
          cylinder(d=0.2,h=0.1);
        }
translate([0,1.5,0])
    color("Silver")
      hull()
        {
        translate([1.4,0,1.95])
          cylinder(d=0.2,h=0.1);
        translate([1.7,-0.5,1.95])
          cylinder(d=0.2,h=0.1);
        }
translate([0,1,0])
    color("Silver")
      hull()
        {
        translate([1.7,0,1.95])
          cylinder(d=0.2,h=0.1);
        translate([1.85,-0.5,1.95])
          cylinder(d=0.2,h=0.1);
        }
translate([0,0.5,0])
    color("Silver")
      hull()
        {
        translate([1.85,0,1.95])
          cylinder(d=0.2,h=0.1);
        translate([1.9,-0.5,1.95])
          cylinder(d=0.2,h=0.1);
        }
  }

module LDR()
difference()
  {
  union()
    {
    color("SaddleBrown")
    translate([0,0,0])
      cylinder(d=5,h=2);

    color("Silver")
      translate([1.27,0,-40])
        cylinder(d=0.6,h=40);
    color("Silver")
      translate([-1.27,0,-40])
        cylinder(d=0.6,h=40);

    }
color("SaddleBrown")
  translate([0,7,0])
    cube([10,10,10],center=true);
color("SaddleBrown")
  translate([0,-7,0])
    cube([10,10,10],center=true);

  color("Silver")
    translate([0,0.126,0])
      traks();

color("Silver")
  translate([0,-0.126,0])
    rotate([0,0,180])
      traks();
  }


LDR();