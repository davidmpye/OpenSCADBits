$fn=80;

base_width=25.5;
base_length = 37.5;
base_thickness = 2.5;

ledge_width = 16.35;
ledge_length = 22.75;
ledge_thickness = 4;

pin_dia = 12.30;
pin_height = 18;

pin_collar_dia = 8;
pin_collar_height = 2.65;


taper_height = 6;
translate([base_width/2,0,0]) hull(){
    cylinder(r=base_width/2, h=base_thickness);
    translate([base_length - base_width,0,0,]) cylinder(r=base_width/2, h=base_thickness);
}


translate([(base_length - ledge_length)/2,0,base_thickness-0.01])    translate([ledge_width/2  ,0,0]){
 hull(){
    cylinder(r=ledge_width/2, h = ledge_thickness);
    translate([ledge_length - ledge_width,0,0,]) cylinder (r=ledge_width/2, h = ledge_thickness);
}
}

translate([base_length/2, 0, base_thickness+ ledge_thickness - 0.01]) cylinder(r=pin_dia/2, h = pin_height);
translate([base_length/2, 0, base_thickness + ledge_thickness + pin_height - 0.01]) cylinder(r=pin_collar_dia/2, h=pin_collar_height);


translate([base_length/2, 0, base_thickness + ledge_thickness + pin_height + pin_collar_height - 0.01])  {
hull() {
  cylinder(r=pin_dia/2, h=2);
   translate([0,0,9.5]) cylinder(h=0.01,r=2);
}
}
