text="4";


keyring_hole_dia = 3;
tag_thickness=5;
text_depth = 1.5;
$fn=30;

difference() {
    hull() {
    
    cylinder(r=5,tag_thickness);
    translate([0,15,0]) cylinder(r=10, h=tag_thickness);
}
translate([0,1.5,-0.1]) cylinder(r=keyring_hole_dia/2, h=tag_thickness+0.2);


translate([5,10,tag_thickness-text_depth]) linear_extrude(height=text_depth+0.1)  rotate([0,0,0],a=90) text(text,$fn=50);
translate([-5,10,-0.01]) mirror([0.01,0,0])  linear_extrude(height=text_depth)  rotate([0,0,0],a=90) text(text,$fn=50);

}

