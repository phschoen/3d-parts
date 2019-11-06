use <WriteScad/Write.scad>

// The dimensions given below are perfect for a botte of Club-Mate.

// The first five parameters can be used to adjust the text;
// the last four to adjust the size and shape of the name tag.
// All measurements are in millimeters (that includes size, thickness, radius, etc.)

create_name_tag(
	name 		= "John Doe",
	font 		= "Arial Rounded MT Bold:style=Bold",
	text_size 	= 9,
	text_thickness 	= 1.5,	// The "height" of the relief of the letters.
	text_offset_y 	= 0,	// Use this to adjust the vertical position of the text. Positive is up, negative down.
	height 			= 26,	// Height of the entire name tag.
	radius_bottom 	= 17.5,	// Inner radius at the base of the name tag.
	radius_top 		= 13,	// Inner radius at the top of the name tag.
	thickness 		= 2		// The thickness of the name tag.
);

// -------------------------------------------------------------------//

module create_name_tag(
	name,
	font,
	text_size,
	text_thickness,
	text_offset_y,
	height,
	radius_bottom,
	radius_top,
	thickness) {

	outer_radius_bottom = radius_bottom + thickness;
	outer_radius_top = radius_top + thickness;
	cube_size = max(outer_radius_bottom, outer_radius_top);

	difference() {
		union () {
			cylinder(r1=outer_radius_bottom, r2=outer_radius_top, h=height, $fa=1);
			rotate([0, 0, -45]) writecylinder(name, [0,0,0], 15, height+text_offset_y, h=text_size, t=text_thickness*10, font=font);
		}
		translate([0,0,-0.01]) cylinder(r1=radius_bottom, r2=radius_top, h=height+0.02, $fa=1);
		difference () {
			cylinder(r1=outer_radius_bottom+(text_thickness*10), r2=outer_radius_top+(text_thickness*10), h=height);
			translate([0,0,-0.01]) cylinder(r1=outer_radius_bottom+text_thickness, r2=outer_radius_top+text_thickness, h=height+0.02, $fa=1);
		}
		translate([0,0,-0.01]) cube([cube_size, cube_size, height+0.02]);
	}
}