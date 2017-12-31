
capsuleholder(5);

module capsuleholder (num_capsules)
{
	//Info about nespresso capsules.
	//Nespresso capsule 'flange' is 37mm in diameter.
	capsule_diameter=38.5;
	//Capsule flange thickness
	capsule_flange_thickness=2.2;

	//How thick the plastic walls should be.
	wall_thickness = 2;
	//Thickness of the side retaining lugs
	side_lug_thickness = 1;
	//How much of a capsule height the opening at the bottom to take the capsule out should be
	capsule_removal_gap = 0.55;
	//bottom lug height
	bottom_lug_height = 3.5;


	overall_width = capsule_diameter + wall_thickness * 2;
	overall_thickness = capsule_flange_thickness + wall_thickness * 2 + side_lug_thickness;
	overall_height = num_capsules * capsule_diameter + wall_thickness; //Wall thickness is for bottom lug

	//Print some object info
	echo("Overall width of holder is" , overall_width, "mm");
	echo ("Overall height is ", overall_height, "mm");
	echo ("Overall thickness is ", overall_thickness, "mm");

	rotate ([90,0,0]) {  //Lie the object down so we can print it in a sensible orientation.
		
		union() {//to put the bottom lug in
			difference() {
		
				//Capsule holder main section
				linear_extrude(height = overall_height){
					difference() {
						//Main outline
						square([overall_width,overall_thickness]);
		
						//Take out a capsule-flange sized slot.
						translate([wall_thickness,wall_thickness])square([capsule_diameter, capsule_flange_thickness]);
		
						//Take out the front wall.
						translate([wall_thickness*2, wall_thickness]) square(capsule_diameter - wall_thickness*2, wall_thickness);
			
						//Remove two triangle-shaped polygons to leave the retaining lugs in a way that they can print
						 translate([wall_thickness, wall_thickness+capsule_flange_thickness]) polygon([[0,0],[wall_thickness,0], [wall_thickness,	 wall_thickness]]);

						translate([capsule_diameter, wall_thickness+capsule_flange_thickness]) polygon([[0,0],[0,wall_thickness], [wall_thickness,0]]);
					}
				}
				//Cut out the retaining lugs at the bottom of the holder so the capsules can be removed
				linear_extrude(height = capsule_diameter * capsule_removal_gap) translate([wall_thickness, wall_thickness]) 
						square([capsule_diameter, wall_thickness+capsule_flange_thickness + side_lug_thickness]);
		
				//Put in screw holes
			}
			//Bottom lug (unioned with the structure above.	
			linear_extrude(height = wall_thickness)  square ([overall_width, wall_thickness + bottom_lug_height]);
		}
	}
}