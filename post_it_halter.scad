
thickness=1.75;
post_it_width=76;
post_it_hight=44;
pen_width=20;

module post_it_box() {
    cube([post_it_width, post_it_width, post_it_hight]);
}

module post_it_holder() {
    difference() {
        union() {
            translate([-thickness,-thickness,0])
                cube([thickness, post_it_width+thickness*2, post_it_hight+20]);
            translate([-thickness,-thickness,-thickness*2])
                cube([post_it_width+thickness*2, post_it_width+thickness*2, post_it_hight+thickness*2]);
        }
        union() {
            translate([-10,10,post_it_hight+10])
                rotate([0,90,0])
                    cylinder(h=10, d=4);
            translate([-10,post_it_width+thickness-10,post_it_hight+10])
                rotate([0,90,0])
                    cylinder(h=10, d=4);
            translate([post_it_width,post_it_width/2-12.5,0])
                cube([thickness,25,post_it_hight]);
            post_it_box();
        }
    }
}
module pen_holder()
{
    difference() {
        union() {
            translate([-thickness,-thickness*2,-thickness*2])
                cube([post_it_width+thickness*2, pen_width+thickness*2, post_it_hight+thickness*2]);
        }
        union() {
            for (i=[0,1,2,3]) {
                translate([i*(post_it_width/5+thickness)+thickness*2,-thickness,thickness])
                    cube([(post_it_width+thickness)/5, pen_width, post_it_hight+thickness*2]);
            }
        }
    }
}



post_it_holder();

translate([0, -pen_width,0])
    pen_holder();
translate([0, post_it_width+thickness,0])
    pen_holder();
