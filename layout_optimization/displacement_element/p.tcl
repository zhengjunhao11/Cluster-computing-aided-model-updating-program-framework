wipe
model BasicBuilder -ndm 3 -ndf 6

#source 52_bar_1.tcl
source parameter.tcl
source 52_bar_1.tcl

test NormDispIncr 0.01 200 2; 
algorithm KrylovNewton
constraints Transformation; 
numberer RCM;	
system BandGeneral;
integrator LoadControl 0.1;
analysis Static
analyze 10
loadConst -time 0.0;
recorder Node -file reaction.txt	-nodeRange	1	8	-dof 3	reaction

set numModes 5

set pi [expr acos(-1.0)]
set eigFID [open EigenVal.txt w]
set lambda [eigen $numModes]
puts $eigFID " lambda          omega           period          frequency"
foreach lambda $lambda {
    set omega [expr sqrt($lambda)]
    set period [expr 2.0*$pi/$omega]
    set frequ [expr 1.0/$period]
    puts $eigFID [format " %+1.6e  %+1.6e  %+1.6e  %+1.6e" $lambda $omega $period $frequ]
}
close $eigFID
record



