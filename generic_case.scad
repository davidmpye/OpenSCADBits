/* Generic case design - GNU GPL V3.0
   (C) David Pye 2017 davidmpye@gmail.com
*/

//Box definitions.
wall_thickness=2;
corner_radius = 2;
outer_x = 40;
outer_y= 50;
outer_z = 20;


//Define your screw hole diameter and depth for fixing the lid on
screw_hole_dia = 3;
screw_hole_depth = 10;

screw_hole_head_countersink_dia = 6;
screw_hole_head_countersink_depth = 0.5;

//This usually seems sensible, but you might need to adjust it for strange combinations of screw hole and box corner radius to ensure your pillars are 'fused' suitably with the sides of the box. - can go negative as well as positive if needed.
pillar_offset_tweak = 0;


$fn=20;
pillar_dia = screw_hole_dia +3;

//Coordinates for where the four pillar centres should be.
 corner_hole_centres = [ [pillar_dia/2+pillar_offset_tweak + 0.01,pillar_dia/2 + pillar_offset_tweak +0.01,0],
            [outer_x - (pillar_dia/2+ pillar_offset_tweak +  0.01),pillar_dia/2+ pillar_offset_tweak +  0.01,0],
            [pillar_dia/2+ pillar_offset_tweak +0.01, outer_y - (pillar_dia/2+ pillar_offset_tweak +0.01),0],
            [outer_x- (pillar_dia/2+ pillar_offset_tweak +0.01),outer_y- ( pillar_dia/2+ pillar_offset_tweak +0.01),0]
            ];
             
            
echo ( "The INSIDE box diameters are (X:Y)");
echo (outer_x - wall_thickness*2);
echo (outer_y - wall_thickness*2);
echo ( "Hole centres:");
for (i = corner_hole_centres) echo(i);

echo ("Taking into account the pillars, the space between them is:");
echo ("X:");
echo (corner_hole_centres[1][0] - corner_hole_centres[0][0] - pillar_dia);
echo ("Y:");
echo (corner_hole_centres[2][1] - corner_hole_centres[0][1] - pillar_dia);


make_box(outer_x, outer_y, outer_z, screw_hole_dia, screw_hole_depth);
translate([outer_x + 10, 0, 0]) make_lid(outer_x, outer_y, outer_z, screw_hole_dia);


//example internal item to demonstrate fit.
//translate([corner_hole_centres[0][1]+pillar_dia/2 + 0.1,0,wall_thickness+0.1]) cube([28-0.1, 46-0.1, 5]);



module make_box(x,y,z,screw_hole_dia, hole_depth) {
    difference() {
        union() {
            difference() {    
                //First, make a rounded-corners-cube using rectangle + circle + minkowski sum of the two
                translate([ wall_thickness, wall_thickness, wall_thickness]) {
                    minkowski() {
                        cube([x - 2*corner_radius,y - 2*corner_radius ,z - 2*corner_radius]);  
                        sphere(r=corner_radius, center=true);   
                }
            }
    
            //Now hollow it out.
            translate([wall_thickness, wall_thickness, wall_thickness]) 
            cube([x-wall_thickness*2, y-wall_thickness*2, z-wall_thickness]);
        
            //Now chop off the lid.
            translate([0,0,z-wall_thickness]) cube([x,y,wall_thickness+1]);
        }   
        //Union in the screwhole pillars.
        for (i = corner_hole_centres) translate([0,0,wall_thickness-0.1]) translate(i) 
                        cylinder(r=pillar_dia/2, h=0.1 + z-2*wall_thickness);
       
    }
    
    //Subtract out the holes for the screwholes (consider using polyholes depending on your slicer!)
    for (i=corner_hole_centres) translate(0,0,wall_thickness-0.1)
           translate(i) translate([0,0, z - hole_depth]) cylinder(r=screw_hole_dia/2, h=hole_depth+0.1);
    }
 }
    

module make_lid (x,y,z, screw_hole_dia) {
    union() {
        difference() {
            translate([ wall_thickness, wall_thickness, 0]) {
                        minkowski() {
                            cube([x - 2*corner_radius,y - 2*corner_radius , wall_thickness]);  
                            translate([0,0,corner_radius]) sphere(r=corner_radius, center=true);   
                        }
            }
            //chop the lid to the correct thickness (wall thickness!)
            translate([0,0,wall_thickness]) cube([x,y,z]);
            for (i=corner_hole_centres) {
                    //make hole in lid for screw shaft
                    translate(i)  cylinder(r=screw_hole_dia/2, h = wall_thickness+0.1);
                    //countersunk hole for screw head.
                    translate(i) cylinder(r=screw_hole_head_countersink_dia/2, h=screw_hole_head_countersink_depth);
             }
        }
            
        /* Build the lip - corner curve pieces to clear the pillars */
        translate(corner_hole_centres[0])  translate([0,0,wall_thickness-0.01])   rotate(a=90) 
        quarter_hole(pillar_dia/2, wall_thickness);
        translate(corner_hole_centres[1])  translate([0,0,wall_thickness-0.01])   rotate(a=180) 
        quarter_hole(pillar_dia/2, wall_thickness);
        translate(corner_hole_centres[2])  translate([0,0,wall_thickness-0.01])   rotate(a=0) 
        quarter_hole(pillar_dia/2, wall_thickness);
        translate(corner_hole_centres[3])  translate([0,0,wall_thickness-0.01])   rotate(a=-90) 
        quarter_hole(pillar_dia/2, wall_thickness);
        
        /* Wall part of the lip */
        translate([pillar_dia,wall_thickness,wall_thickness]) cube([x - pillar_dia*2 ,wall_thickness, wall_thickness]);
        translate([pillar_dia,y - wall_thickness*2 ,wall_thickness]) cube([x - pillar_dia*2,wall_thickness, wall_thickness]);
        translate([wall_thickness, pillar_dia ,wall_thickness]) cube([wall_thickness, y - pillar_dia*2, wall_thickness]);
        translate([x - wall_thickness*2, pillar_dia , wall_thickness]) cube([wall_thickness, y - pillar_dia*2, wall_thickness]);
    }
}

module quarter_hole(radius, wall_thickness) {
        difference() {
            cylinder (r=radius + wall_thickness, h= wall_thickness+0.01);
            cylinder (r=radius, h= wall_thickness + 0.1);
            translate([-radius*2, 0,0 ]) cube([pillar_dia*2, radius*4, wall_thickness*2]);
            translate([-radius*2,  -radius*2,  0]) cube([radius*2, radius*2, wall_thickness*2]);
        }
    
}