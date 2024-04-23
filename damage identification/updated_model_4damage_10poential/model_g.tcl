wipe
#unit m Pa N
model BasicBuilder -ndm 3 -ndf 6
source frame.tcl
source mass.tcl

constraints Transformation;  
numberer RCM;	
system SparseSYM;
test NormDispIncr 1.0e-2 200 2; 	
algorithm NewtonLineSearch 0.75
integrator LoadControl 0.05;
analysis Static
analyze 20
puts "ANALYSIS OK"
loadConst -time 0.0;  

