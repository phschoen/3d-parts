use <lib/cube.scad>
use <lib/cylinder.scad>

$e = 0.1;
$fn = 64;

plate_thickness = 22;
game_insert_h =100;
edge_top = 100;

size_max = [900, 1800, 800 ];
leg_size = [100, 100, size_max[2]- plate_thickness];


sideplate_h= game_insert_h + plate_thickness * 2;


module leg()
{
    cube( leg_size);
}

module legs()
{
    color("blue")
    for( x = [0,  size_max[0]-leg_size[0]] )
        for( y = [0,  size_max[1]-leg_size[1]] )
            translate([x,y,0])
                leg();
}

module sideplates()
{
    // front
    color("green")
    translate([leg_size[0],0,leg_size[2]- sideplate_h])
        cube([size_max[0]-leg_size[0]*2, plate_thickness, sideplate_h]);

    // back
    color("green")
    translate([leg_size[0],size_max[1]- plate_thickness,leg_size[2]- sideplate_h])
        cube([size_max[0]-leg_size[0]*2, plate_thickness, sideplate_h]);

    // left
    color("green")
    translate([0,leg_size[1],leg_size[2]- sideplate_h])
        cube([plate_thickness,size_max[1]-leg_size[1]*2,  sideplate_h]);

    // right
    color("green")
    translate([size_max[0]-plate_thickness,leg_size[1],leg_size[2]- sideplate_h])
        cube([plate_thickness,size_max[1]-leg_size[1]*2,  sideplate_h]);
}

module top_plate()
{
    // front
    color("lightgreen")
    translate([edge_top,0,leg_size[2]])
        cube([size_max[0] - edge_top*2, edge_top, plate_thickness]);

    // back
    color("lightgreen")
    translate([edge_top, size_max[1]-edge_top ,leg_size[2]])
        cube([size_max[0] -edge_top*2, edge_top, plate_thickness]);

    // right
    color("lightgreen"*0.1)
    translate([0,0 ,leg_size[2]])
        cube([ edge_top, size_max[1], plate_thickness]);


    // left
    color("lightgreen"*0.1)
    translate([size_max[0]-edge_top ,0 ,leg_size[2]])
        cube([ edge_top, size_max[1], plate_thickness]);

}

module top_inserts(count=5)
{
    w = (size_max[1] -edge_top*2)/count;
    echo(w);

    for( c = [0:count-1])
    // front
    translate([edge_top,edge_top + c*w ,leg_size[2]])
        color([c/count,c/count,c/count])
        cube([size_max[0] - edge_top*2, w, plate_thickness]);
}

module game_deck()
{
    difference() {
        color("orange")
        translate([plate_thickness,plate_thickness,leg_size[2]-plate_thickness*2 - game_insert_h])
            cube([size_max[0] - plate_thickness*2, size_max[1] -plate_thickness*2, plate_thickness]);
        legs();
    }
}
module game_sideplates()
{
    color([0.8,0.4,0.4])
    {
        // front
        translate([leg_size[0],leg_size[1]-plate_thickness,leg_size[2]- sideplate_h])
            cube([size_max[0]-leg_size[0]*2, plate_thickness, sideplate_h]);

        // back
        translate([leg_size[0],size_max[1]-leg_size[1],leg_size[2]- sideplate_h])
            cube([size_max[0]-leg_size[0]*2, plate_thickness, sideplate_h]);
    }
}


game_deck();
game_sideplates();
//top_inserts(3);
//top_plate();
sideplates();
legs();
