#units m N kg
set l1	[expr	sqrt(abs($parameter6))]
set l2	[expr	sqrt(abs($parameter7))]
set l3	[expr	sqrt(abs($parameter8))]
set l4	[expr	sqrt(abs($parameter9))]
set l5	[expr	sqrt(abs($parameter10))]
set l6	[expr	sqrt(abs($parameter11))]
set l7	[expr	sqrt(abs($parameter12))]
set l8	[expr	sqrt(abs($parameter13))]
puts "$l8"
#node
node	1	0.0000 	-6.0000 	0.0000 
node	2	4.2426 	-4.2426 	0.0000 
node	3	6.0000 	0.0000 	0.0000 
node	4	4.2426 	4.2426 	0.0000 
node	5	0.0000 	6.0000 	0.0000 
node	6	-4.2426 	4.2426 	0.0000 
node	7	-6.0000 	0.0000 	0.0000 
node	8	-4.2426 	-4.2426 	0.0000 
node	9	0.0000 	[expr	-4.0000-$parameter4] 	[expr	4.5000+$parameter5] 
node	10	[expr	2.8284+$parameter4] 	-2.8284	[expr	4.5000+$parameter5] 
node	11	[expr	4.0000+$parameter4] 	0.0000 	[expr	4.5000+$parameter5] 
node	12	[expr	2.8284+$parameter4] 	2.8284 	[expr	4.5000+$parameter5] 
node	13	0.0000 	[expr	4.0000+$parameter4] 	[expr	4.5000+$parameter5] 
node	14	[expr	-2.8284-$parameter4] 	2.8284 	[expr	4.5000+$parameter5] 
node	15	[expr	-4.0000-$parameter4] 	0.0000 	[expr	4.5000+$parameter5]
node	16	[expr	-2.8284-$parameter4] 	-2.8284 	[expr	4.5000+$parameter5]
node	17	0.0000 	[expr	-2.0000-$parameter2] 	[expr	5.7000+$parameter3] 
node	18	[expr	2.0000+$parameter2] 	0.0000 	[expr	5.7000+$parameter3] 
node	19	0.0000 	[expr	2.0000+$parameter2] 	[expr	5.7000+$parameter3] 
node	20	[expr	-2.0000-$parameter2] 	0.0000 	[expr	5.7000+$parameter3] 
node	21	0.0000 	0.0000 	[expr	6.0000+$parameter1] 
puts "nodes"
#fix
fixZ	0.0	1	1	1	1	1	1	
puts "fix"
#material
set E	2.1E+11
set po	0.2
set G [expr	$E/(2*(1+$po))]
set	Ip1	[expr	$parameter6**2/12*2]
uniaxialMaterial Elastic	1	2.1E+11
uniaxialMaterial Elastic	11	[expr	$Ip1*$G]
set	Ip2	[expr	$parameter7**2/12*2]
uniaxialMaterial Elastic	22	[expr	$Ip2*$G]
set	Ip3	[expr	$parameter8**2/12*2]
uniaxialMaterial Elastic	33	[expr	$Ip3*$G]
set	Ip4	[expr	$parameter9**2/12*2]
uniaxialMaterial Elastic	44	[expr	$Ip4*$G]
set	Ip5	[expr	$parameter10**2/12*2]
uniaxialMaterial Elastic	55	[expr	$Ip5*$G]
set	Ip6	[expr	$parameter11**2/12*2]
uniaxialMaterial Elastic	66	[expr	$Ip6*$G]
set	Ip7	[expr	$parameter12**2/12*2]
uniaxialMaterial Elastic	77	[expr	$Ip7*$G]
set	Ip8	[expr	$parameter13**2/12*2]
uniaxialMaterial Elastic	88	[expr	$Ip8*$G]
puts "material"
geomTransf PDelta	1	0	0	1
#section
section Fiber	11	-torsion	11	{
patch rect	1	4	4	[expr	-$l1/2]	[expr -$l1/2]	[expr $l1/2]	[expr	$l1/2]
}
section Fiber	22	-torsion	22	{
patch rect	1	4	4	[expr	-$l2/2]	[expr -$l2/2]	[expr $l2/2]	[expr	$l2/2]
}
section Fiber	33	-torsion	33	{
patch rect	1	4	4	[expr	-$l3/2]	[expr -$l3/2]	[expr $l3/2]	[expr	$l3/2]
}
section Fiber	44	-torsion	44	{
patch rect	1	4	4	[expr	-$l4/2]	[expr -$l4/2]	[expr $l4/2]	[expr	$l4/2]
}
section Fiber	55	-torsion	55	{
patch rect	1	4	4	[expr	-$l5/2]	[expr -$l5/2]	[expr $l5/2]	[expr	$l5/2]
}
section Fiber	66	-torsion	66	{
patch rect	1	4	4	[expr	-$l6/2]	[expr -$l6/2]	[expr $l6/2]	[expr	$l6/2]
}
section Fiber	77	-torsion	77	{
patch rect	1	4	4	[expr	-$l7/2]	[expr -$l7/2]	[expr $l7/2]	[expr	$l7/2]
}
section Fiber	88	-torsion	88	{
patch rect	1	4	4	[expr	-$l8/2]	[expr -$l8/2]	[expr $l8/2]	[expr	$l8/2]
}
puts	"section"
#element
#group1
element dispBeamColumn	1 	20 	21 5		11	1   -mass	[expr	abs($parameter6)*7800]
element dispBeamColumn	2 	17 	21 5		11	1   -mass	[expr	abs($parameter6)*7800]
element dispBeamColumn	3 	18 	21 5		11	1   -mass	[expr	abs($parameter6)*7800]
element dispBeamColumn	4 	19 	21 5		11	1   -mass	[expr	abs($parameter6)*7800]
#group2
element dispBeamColumn	5 	15 	20 5		22	1   -mass	[expr	abs($parameter7)*7800]
element dispBeamColumn	6 	9 	17 5		22	1   -mass	[expr	abs($parameter7)*7800]
element dispBeamColumn	7 	11 	18 5		22	1   -mass	[expr	abs($parameter7)*7800]
element dispBeamColumn	8 	13 	19 5		22	1   -mass	[expr	abs($parameter7)*7800]
#group3
element dispBeamColumn	9 	16 	20 5		33	1   -mass	[expr	abs($parameter8)*7800]
element dispBeamColumn	10 	16 	17 5		33	1   -mass	[expr	abs($parameter8)*7800]
element dispBeamColumn	11 	10 	17 5		33	1   -mass	[expr	abs($parameter8)*7800]
element dispBeamColumn	12 	10 	18 5		33	1   -mass	[expr	abs($parameter8)*7800]
element dispBeamColumn	13 	12 	18 5		33	1   -mass	[expr	abs($parameter8)*7800]
element dispBeamColumn	14 	12 	19 5		33	1   -mass	[expr	abs($parameter8)*7800]
element dispBeamColumn	15 	14 	19 5		33	1   -mass	[expr	abs($parameter8)*7800]
element dispBeamColumn	16 	14 	20 5		33	1   -mass	[expr	abs($parameter8)*7800]
#group4
element dispBeamColumn	17 	20 	17 5		44	1   -mass	[expr	abs($parameter9)*7800]
element dispBeamColumn	18 	17 	18 5		44	1   -mass	[expr	abs($parameter9)*7800]
element dispBeamColumn	19 	18 	19 5		44	1   -mass	[expr	abs($parameter9)*7800]
element dispBeamColumn	20 	19 	20 5		44	1   -mass	[expr	abs($parameter9)*7800]
#group5
element dispBeamColumn	21 	15 	16 5		55	1   -mass	[expr	abs($parameter10)*7800]
element dispBeamColumn	22 	16 	9  5		55	1   -mass	[expr	abs($parameter10)*7800]
element dispBeamColumn	23 	9 	10 5		55	1   -mass	[expr	abs($parameter10)*7800]
element dispBeamColumn	24 	10 	11 5		55	1   -mass	[expr	abs($parameter10)*7800]
element dispBeamColumn	25 	11 	12 5		55	1   -mass	[expr	abs($parameter10)*7800]
element dispBeamColumn	26 	12 	13 5		55	1   -mass	[expr	abs($parameter10)*7800]
element dispBeamColumn	27 	13 	14 5		55	1   -mass	[expr	abs($parameter10)*7800]
element dispBeamColumn	28 	14 	15 5		55	1   -mass	[expr	abs($parameter10)*7800]
#group6
element dispBeamColumn	29 	7 	15 5		66	1   -mass	[expr	abs($parameter11)*7800]
element dispBeamColumn	30 	8 	16 5		66	1   -mass	[expr	abs($parameter11)*7800]
element dispBeamColumn	31 	1 	9  5		66	1   -mass	[expr	abs($parameter11)*7800]
element dispBeamColumn	32 	2 	10 5		66	1   -mass	[expr	abs($parameter11)*7800]
element dispBeamColumn	33 	3 	11 5		66	1   -mass	[expr	abs($parameter11)*7800]
element dispBeamColumn	34 	4 	12 5		66	1   -mass	[expr	abs($parameter11)*7800]
element dispBeamColumn	35 	5 	13 5		66	1   -mass	[expr	abs($parameter11)*7800]
element dispBeamColumn	36 	6 	14 5		66	1   -mass	[expr	abs($parameter11)*7800]
#group7
element dispBeamColumn	37 	8 	15 5		77	1   -mass	[expr	abs($parameter12)*7800]
element dispBeamColumn	38 	8 	9  5		77	1   -mass	[expr	abs($parameter12)*7800]
element dispBeamColumn	39 	2 	9  5		77	1   -mass	[expr	abs($parameter12)*7800]
element dispBeamColumn	40 	2 	11 5		77	1   -mass	[expr	abs($parameter12)*7800]
element dispBeamColumn	41 	4 	11 5		77	1   -mass	[expr	abs($parameter12)*7800]
element dispBeamColumn	42 	4 	13 5		77	1   -mass	[expr	abs($parameter12)*7800]
element dispBeamColumn	43 	6 	13 5		77	1   -mass	[expr	abs($parameter12)*7800]
element dispBeamColumn	44 	6 	15 5		77	1   -mass	[expr	abs($parameter12)*7800]
#group8
element dispBeamColumn	45 	7 	16 5		88	1   -mass	[expr	abs($parameter13)*7800]
element dispBeamColumn	46 	1 	16 5		88	1   -mass	[expr	abs($parameter13)*7800]
element dispBeamColumn	47 	1 	10 5		88	1   -mass	[expr	abs($parameter13)*7800]
element dispBeamColumn	48 	3 	10 5		88	1   -mass	[expr	abs($parameter13)*7800]
element dispBeamColumn	49 	3 	12 5		88	1   -mass	[expr	abs($parameter13)*7800]
element dispBeamColumn	50 	5 	12 5		88	1   -mass	[expr	abs($parameter13)*7800]
element dispBeamColumn	51 	5 	14 5		88	1   -mass	[expr	abs($parameter13)*7800]
element dispBeamColumn	52 	7 	14 5		88	1   -mass	[expr	abs($parameter13)*7800]
puts "element"
#mass of free nodes
mass	9	3.846	3.846	3.846	0.000	0.000	0.000
mass	10	3.846	3.846	3.846	0.000	0.000	0.000
mass	11	3.846	3.846	3.846	0.000	0.000	0.000
mass	12	3.846	3.846	3.846	0.000	0.000	0.000
mass	13	3.846	3.846	3.846	0.000	0.000	0.000
mass	14	3.846	3.846	3.846	0.000	0.000	0.000
mass	15	3.846	3.846	3.846	0.000	0.000	0.000
mass	16	3.846	3.846	3.846	0.000	0.000	0.000
mass	17	3.846	3.846	3.846	0.000	0.000	0.000
mass	18	3.846	3.846	3.846	0.000	0.000	0.000
mass	19	3.846	3.846	3.846	0.000	0.000	0.000
mass	20	3.846	3.846	3.846	0.000	0.000	0.000
mass	21	3.846	3.846	3.846	0.000	0.000	0.000

pattern	Plain	2	Linear	{
load	9	0.0000 	0.0000 	-37.6923 	0.0000 	0.0000 	0.0000 
load	10	0.0000 	0.0000 	-37.6923 	0.0000 	0.0000 	0.0000 
load	11	0.0000 	0.0000 	-37.6923 	0.0000 	0.0000 	0.0000 
load	12	0.0000 	0.0000 	-37.6923 	0.0000 	0.0000 	0.0000 
load	13	0.0000 	0.0000 	-37.6923 	0.0000 	0.0000 	0.0000 
load	14	0.0000 	0.0000 	-37.6923 	0.0000 	0.0000 	0.0000 
load	15	0.0000 	0.0000 	-37.6923 	0.0000 	0.0000 	0.0000 
load	16	0.0000 	0.0000 	-37.6923 	0.0000 	0.0000 	0.0000 
load	17	0.0000 	0.0000 	-37.6923 	0.0000 	0.0000 	0.0000 
load	18	0.0000 	0.0000 	-37.6923 	0.0000 	0.0000 	0.0000 
load	19	0.0000 	0.0000 	-37.6923 	0.0000 	0.0000 	0.0000 
load	20	0.0000 	0.0000 	-37.6923 	0.0000 	0.0000 	0.0000 
load	21	0.0000 	0.0000 	-37.6923 	0.0000 	0.0000 	0.0000 
}
puts	"mass of free node"
pattern	Plain	4	Linear	{
#group1
eleLoad	-ele	1	-type -beamUniform	0	0	[expr -9.8*abs($parameter6)*7800]
eleLoad	-ele	2	-type -beamUniform	0	0	[expr -9.8*abs($parameter6)*7800]
eleLoad	-ele	3	-type -beamUniform	0	0	[expr -9.8*abs($parameter6)*7800]
eleLoad	-ele	4	-type -beamUniform	0	0	[expr -9.8*abs($parameter6)*7800]
#group2
eleLoad	-ele	5	-type -beamUniform	0	0	[expr -9.8*abs($parameter7)*7800]
eleLoad	-ele	6	-type -beamUniform	0	0	[expr -9.8*abs($parameter7)*7800]
eleLoad	-ele	7	-type -beamUniform	0	0	[expr -9.8*abs($parameter7)*7800]
eleLoad	-ele	8	-type -beamUniform	0	0	[expr -9.8*abs($parameter7)*7800]
#group3
eleLoad	-ele	9	-type -beamUniform	0	0		[expr -9.8*abs($parameter8)*7800]
eleLoad	-ele	10	-type -beamUniform	0	0	[expr -9.8*abs($parameter8)*7800]
eleLoad	-ele	11	-type -beamUniform	0	0	[expr -9.8*abs($parameter8)*7800]
eleLoad	-ele	12	-type -beamUniform	0	0	[expr -9.8*abs($parameter8)*7800]
eleLoad	-ele	13	-type -beamUniform	0	0	[expr -9.8*abs($parameter8)*7800]
eleLoad	-ele	14	-type -beamUniform	0	0	[expr -9.8*abs($parameter8)*7800]
eleLoad	-ele	15	-type -beamUniform	0	0	[expr -9.8*abs($parameter8)*7800]
eleLoad	-ele	16	-type -beamUniform	0	0	[expr -9.8*abs($parameter8)*7800]
#group4
eleLoad	-ele	17	-type -beamUniform	0	[expr -9.8*abs($parameter9)*7800]	
eleLoad	-ele	18	-type -beamUniform	0	[expr -9.8*abs($parameter9)*7800]	
eleLoad	-ele	19	-type -beamUniform	0	[expr -9.8*abs($parameter9)*7800]	
eleLoad	-ele	20	-type -beamUniform	0	[expr -9.8*abs($parameter9)*7800]
#group5	
eleLoad	-ele	21	-type -beamUniform	0	[expr -9.8*abs($parameter10)*7800]	
eleLoad	-ele	22	-type -beamUniform	0	[expr -9.8*abs($parameter10)*7800]	
eleLoad	-ele	23	-type -beamUniform	0	[expr -9.8*abs($parameter10)*7800]	
eleLoad	-ele	24	-type -beamUniform	0	[expr -9.8*abs($parameter10)*7800]	
eleLoad	-ele	25	-type -beamUniform	0	[expr -9.8*abs($parameter10)*7800]	
eleLoad	-ele	26	-type -beamUniform	0	[expr -9.8*abs($parameter10)*7800]	
eleLoad	-ele	27	-type -beamUniform	0	[expr -9.8*abs($parameter10)*7800]	
eleLoad	-ele	28	-type -beamUniform	0	[expr -9.8*abs($parameter10)*7800]
#group6	
eleLoad	-ele	29	-type -beamUniform	0	0	[expr -9.8*abs($parameter11)*7800]
eleLoad	-ele	30	-type -beamUniform	0	0	[expr -9.8*abs($parameter11)*7800]
eleLoad	-ele	31	-type -beamUniform	0	0	[expr -9.8*abs($parameter11)*7800]
eleLoad	-ele	32	-type -beamUniform	0	0	[expr -9.8*abs($parameter11)*7800]
eleLoad	-ele	33	-type -beamUniform	0	0	[expr -9.8*abs($parameter11)*7800]
eleLoad	-ele	34	-type -beamUniform	0	0	[expr -9.8*abs($parameter11)*7800]
eleLoad	-ele	35	-type -beamUniform	0	0	[expr -9.8*abs($parameter11)*7800]
eleLoad	-ele	36	-type -beamUniform	0	0	[expr -9.8*abs($parameter11)*7800]
#group7
eleLoad	-ele	37	-type -beamUniform	0	0	[expr -9.8*abs($parameter12)*7800]
eleLoad	-ele	38	-type -beamUniform	0	0	[expr -9.8*abs($parameter12)*7800]
eleLoad	-ele	39	-type -beamUniform	0	0	[expr -9.8*abs($parameter12)*7800]
eleLoad	-ele	40	-type -beamUniform	0	0	[expr -9.8*abs($parameter12)*7800]
eleLoad	-ele	41	-type -beamUniform	0	0	[expr -9.8*abs($parameter12)*7800]
eleLoad	-ele	42	-type -beamUniform	0	0	[expr -9.8*abs($parameter12)*7800]
eleLoad	-ele	43	-type -beamUniform	0	0	[expr -9.8*abs($parameter12)*7800]
eleLoad	-ele	44	-type -beamUniform	0	0	[expr -9.8*abs($parameter12)*7800]
#group8
eleLoad	-ele	45	-type -beamUniform	0	0	[expr -9.8*abs($parameter13)*7800]
eleLoad	-ele	46	-type -beamUniform	0	0	[expr -9.8*abs($parameter13)*7800]
eleLoad	-ele	47	-type -beamUniform	0	0	[expr -9.8*abs($parameter13)*7800]
eleLoad	-ele	48	-type -beamUniform	0	0	[expr -9.8*abs($parameter13)*7800]
eleLoad	-ele	49	-type -beamUniform	0	0	[expr -9.8*abs($parameter13)*7800]
eleLoad	-ele	50	-type -beamUniform	0	0	[expr -9.8*abs($parameter13)*7800]
eleLoad	-ele	51	-type -beamUniform	0	0	[expr -9.8*abs($parameter13)*7800]
eleLoad	-ele	52	-type -beamUniform	0	0	[expr -9.8*abs($parameter13)*7800]
}

