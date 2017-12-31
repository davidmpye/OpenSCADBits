/* This thing describes a Honda outboard motor 'kill cord' clip 
 * Author : David Pye
 * Email :  davidmpye@gmail.com
 * Licence: Creative Commons Attribute-Share-Alike
 * Date: 22/7/2012 
 
 * Details:   There are two sets of dimensions - the 'correct ones' measured from a killcord, and 
 *            the fudged ones which are because my printer prints holes a bit smaller than desired
 *            If your printer is better behaved, uncomment 'correct dimensions' and comment out 
 *            fudged dimensions 
*/

/* Outer sizes of the block */
killcord_x = 20;
killcord_y = 30;
killcord_z = 4;

/* Correct dimensions */
/*centre_hole_diameter = 9.25;
open_slot_width = 7;
closed_slot_diameter = 6;
keyring_hole_diameter = 2.5;
closed_slot_width = 5.75;*/

/* Fudged dimensions for my printer */
centre_hole_diameter = 9.5;
open_slot_width = 7.5;
closed_slot_diameter = 6.25;
keyring_hole_diameter = 3.25;
closed_slot_width = 6.25;



difference() {
	cube([killcord_x,killcord_y, killcord_z]); //The outline of the object
	translate([killcord_x/2, 9.5, -0.001]) cylinder(r=centre_hole_diameter/2, h = 5, $fn=50);  //The main centre hole
	
	translate([(killcord_x/2) - open_slot_width/2,-0.001,-0.001])cube([open_slot_width,9.5,5]); //The open-end of the centre hole
	translate([killcord_x/2, 16,-0.001]) cylinder(r=closed_slot_diameter/2, h = 5, $fn=50); //The closed end
	translate([(killcord_x/2) - closed_slot_width/2 ,10,-0.001]) cube(closed_slot_width,5,5);

	translate([killcord_x / 2, 25,-0.001]) cylinder(r=keyring_hole_diameter/2, h = 5, $fn=50); //Key ring hole

	translate([0,0,0.7]) rotate([30,0,0]) cube([killcord_x, 10, killcord_z]); //Bevel the front edges so it slides into place.
}