outer_dia = 110;
centre_hole_dia = 17;

distance_from_centre = 15;
//large hole
large_tube_hole_dia = 30;
large_tube_cutout_width = 28.5; 

//medium hole
m_small_hole_dia = 18.5;
m_large_hole_dia = 22;
m_cutout_width =20;

//tiny hole
s_small_hole_dia =  3;
s_large_hole_dia = 5;
s_cutout_width = 3;

difference() {
	cylinder(h=10,d=outer_dia, $fn=100);

	translate([0,0,-1]) cylinder(h=20, d=centre_hole_dia, $fn=100);	

	rotate([0,0,0]) medium_hole();
	rotate([0,0,70]) medium_hole();
	rotate([0,0,150]) medium_hole();
	rotate([0,0,220]) medium_hole();

	rotate([0,0,290]) large_hole();

    
	rotate([0,0,35]) small_hole();
	rotate([0,0,185]) small_hole();

}

module medium_hole() {
translate([20 + m_small_hole_dia/2,0,-1]) cylinder(h=20, d=m_small_hole_dia, $fn=100);		
		translate([28 + m_large_hole_dia/2,0,-1]) cylinder(h=20, d=m_large_hole_dia, $fn=100);	
		translate([35,-m_cutout_width/2,-1]) cube([30, m_cutout_width, 20]);
}

module large_hole() {translate([20 + large_tube_hole_dia/2,0,-1]) cylinder(h=20, d=large_tube_hole_dia, $fn=100);	
translate([30,-large_tube_cutout_width/2,-1]) cube([30, large_tube_cutout_width, 20]);	
}

module small_hole() {
		translate([40 + s_small_hole_dia/2,0,-1]) cylinder(h=20, d=s_small_hole_dia, $fn=100);	
		
		translate([42 + s_large_hole_dia/2,0,-1]) cylinder(h=20, d=s_large_hole_dia, $fn=100);	
		translate([45,-s_cutout_width/2,-1]) cube([30, s_cutout_width, 20]);
	
}