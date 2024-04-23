wipe
#unit m Pa N
model BasicBuilder -ndm 3 -ndf 6
source parameter.tcl
source damaged_section.tcl
puts "damaged"
source frame.tcl
source mass.tcl

#constraints Transformation;  
#numberer RCM;	
#system SparseSYM;
#test NormDispIncr 1.0e-2 200 2; 	
#algorithm NewtonLineSearch 0.75
#integrator LoadControl 0.05;
#analysis Static
#analyze 20
#puts "ANALYSIS OK"
#loadConst -time 0.0;  

set numModes 10
recorder	Node	-file	column_mode1x.txt	-node	1	2	3	4	5	6	7	8	9	10	11	12	13	14	15	16	17	18	19	20	21	22	23	24	25	26	38	39	40	41	42	43	44	45	46	47	48	49	50	-dof	1	eigen1																				
recorder	Node	-file	column_mode2x.txt	-node	1	2	3	4	5	6	7	8	9	10	11	12	13	14	15	16	17	18	19	20	21	22	23	24	25	26	38	39	40	41	42	43	44	45	46	47	48	49	50	-dof	1	eigen2																				
recorder	Node	-file	column_mode3x.txt	-node	1	2	3	4	5	6	7	8	9	10	11	12	13	14	15	16	17	18	19	20	21	22	23	24	25	26	38	39	40	41	42	43	44	45	46	47	48	49	50	-dof	1	eigen3																				
recorder	Node	-file	column_mode4x.txt	-node	1	2	3	4	5	6	7	8	9	10	11	12	13	14	15	16	17	18	19	20	21	22	23	24	25	26	38	39	40	41	42	43	44	45	46	47	48	49	50	-dof	1	eigen4																				
recorder	Node	-file	column_mode5x.txt	-node	1	2	3	4	5	6	7	8	9	10	11	12	13	14	15	16	17	18	19	20	21	22	23	24	25	26	38	39	40	41	42	43	44	45	46	47	48	49	50	-dof	1	eigen5																				
recorder	Node	-file	column_mode6x.txt	-node	1	2	3	4	5	6	7	8	9	10	11	12	13	14	15	16	17	18	19	20	21	22	23	24	25	26	38	39	40	41	42	43	44	45	46	47	48	49	50	-dof	1	eigen6																				
recorder	Node	-file	column_mode7x.txt	-node	1	2	3	4	5	6	7	8	9	10	11	12	13	14	15	16	17	18	19	20	21	22	23	24	25	26	38	39	40	41	42	43	44	45	46	47	48	49	50	-dof	1	eigen7																				
recorder	Node	-file	column_mode8x.txt	-node	1	2	3	4	5	6	7	8	9	10	11	12	13	14	15	16	17	18	19	20	21	22	23	24	25	26	38	39	40	41	42	43	44	45	46	47	48	49	50	-dof	1	eigen8																				
recorder	Node	-file	column_mode9x.txt	-node	1	2	3	4	5	6	7	8	9	10	11	12	13	14	15	16	17	18	19	20	21	22	23	24	25	26	38	39	40	41	42	43	44	45	46	47	48	49	50	-dof	1	eigen9																				
recorder	Node	-file	column_mode10x.txt	-node	1	2	3	4	5	6	7	8	9	10	11	12	13	14	15	16	17	18	19	20	21	22	23	24	25	26	38	39	40	41	42	43	44	45	46	47	48	49	50	-dof	1	eigen10																				
																																																																		
recorder	Node	-file	column_mode1y.txt	-node	1	2	3	4	5	6	7	8	9	10	11	12	13	14	15	16	17	18	19	20	21	22	23	24	25	26	38	39	40	41	42	43	44	45	46	47	48	49	50	-dof	2	eigen1																				
recorder	Node	-file	column_mode2y.txt	-node	1	2	3	4	5	6	7	8	9	10	11	12	13	14	15	16	17	18	19	20	21	22	23	24	25	26	38	39	40	41	42	43	44	45	46	47	48	49	50	-dof	2	eigen2																				
recorder	Node	-file	column_mode3y.txt	-node	1	2	3	4	5	6	7	8	9	10	11	12	13	14	15	16	17	18	19	20	21	22	23	24	25	26	38	39	40	41	42	43	44	45	46	47	48	49	50	-dof	2	eigen3																				
recorder	Node	-file	column_mode4y.txt	-node	1	2	3	4	5	6	7	8	9	10	11	12	13	14	15	16	17	18	19	20	21	22	23	24	25	26	38	39	40	41	42	43	44	45	46	47	48	49	50	-dof	2	eigen4																				
recorder	Node	-file	column_mode5y.txt	-node	1	2	3	4	5	6	7	8	9	10	11	12	13	14	15	16	17	18	19	20	21	22	23	24	25	26	38	39	40	41	42	43	44	45	46	47	48	49	50	-dof	2	eigen5																				
recorder	Node	-file	column_mode6y.txt	-node	1	2	3	4	5	6	7	8	9	10	11	12	13	14	15	16	17	18	19	20	21	22	23	24	25	26	38	39	40	41	42	43	44	45	46	47	48	49	50	-dof	2	eigen6																				
recorder	Node	-file	column_mode7y.txt	-node	1	2	3	4	5	6	7	8	9	10	11	12	13	14	15	16	17	18	19	20	21	22	23	24	25	26	38	39	40	41	42	43	44	45	46	47	48	49	50	-dof	2	eigen7																				
recorder	Node	-file	column_mode8y.txt	-node	1	2	3	4	5	6	7	8	9	10	11	12	13	14	15	16	17	18	19	20	21	22	23	24	25	26	38	39	40	41	42	43	44	45	46	47	48	49	50	-dof	2	eigen8																				
recorder	Node	-file	column_mode9y.txt	-node	1	2	3	4	5	6	7	8	9	10	11	12	13	14	15	16	17	18	19	20	21	22	23	24	25	26	38	39	40	41	42	43	44	45	46	47	48	49	50	-dof	2	eigen9																				
recorder	Node	-file	column_mode10y.txt	-node	1	2	3	4	5	6	7	8	9	10	11	12	13	14	15	16	17	18	19	20	21	22	23	24	25	26	38	39	40	41	42	43	44	45	46	47	48	49	50	-dof	2	eigen10																				
																																																																		
																																																																		
																																																																		
																																																																		
recorder	Node	-file	beam_mode1x.txt	-node	27	28	29	30	31	33	34	35	36	37	51	52	53	54	55	56	57	58	59	60	-dof	1	eigen1																																							
recorder	Node	-file	beam_mode2x.txt	-node	27	28	29	30	31	33	34	35	36	37	51	52	53	54	55	56	57	58	59	60	-dof	1	eigen2																																							
recorder	Node	-file	beam_mode3x.txt	-node	27	28	29	30	31	33	34	35	36	37	51	52	53	54	55	56	57	58	59	60	-dof	1	eigen3																																							
recorder	Node	-file	beam_mode4x.txt	-node	27	28	29	30	31	33	34	35	36	37	51	52	53	54	55	56	57	58	59	60	-dof	1	eigen4																																							
recorder	Node	-file	beam_mode5x.txt	-node	27	28	29	30	31	33	34	35	36	37	51	52	53	54	55	56	57	58	59	60	-dof	1	eigen5																																							
recorder	Node	-file	beam_mode6x.txt	-node	27	28	29	30	31	33	34	35	36	37	51	52	53	54	55	56	57	58	59	60	-dof	1	eigen6																																							
recorder	Node	-file	beam_mode7x.txt	-node	27	28	29	30	31	33	34	35	36	37	51	52	53	54	55	56	57	58	59	60	-dof	1	eigen7																																							
recorder	Node	-file	beam_mode8x.txt	-node	27	28	29	30	31	33	34	35	36	37	51	52	53	54	55	56	57	58	59	60	-dof	1	eigen8																																							
recorder	Node	-file	beam_mode9x.txt	-node	27	28	29	30	31	33	34	35	36	37	51	52	53	54	55	56	57	58	59	60	-dof	1	eigen9																																							
recorder	Node	-file	beam_mode10x.txt	-node	27	28	29	30	31	33	34	35	36	37	51	52	53	54	55	56	57	58	59	60	-dof	1	eigen10																																							
																																																																		
recorder	Node	-file	beam_mode1y.txt	-node	27	28	29	30	31	33	34	35	36	37	51	52	53	54	55	56	57	58	59	60	-dof	2	eigen1																																							
recorder	Node	-file	beam_mode2y.txt	-node	27	28	29	30	31	33	34	35	36	37	51	52	53	54	55	56	57	58	59	60	-dof	2	eigen2																																							
recorder	Node	-file	beam_mode3y.txt	-node	27	28	29	30	31	33	34	35	36	37	51	52	53	54	55	56	57	58	59	60	-dof	2	eigen3																																							
recorder	Node	-file	beam_mode4y.txt	-node	27	28	29	30	31	33	34	35	36	37	51	52	53	54	55	56	57	58	59	60	-dof	2	eigen4																																							
recorder	Node	-file	beam_mode5y.txt	-node	27	28	29	30	31	33	34	35	36	37	51	52	53	54	55	56	57	58	59	60	-dof	2	eigen5																																							
recorder	Node	-file	beam_mode6y.txt	-node	27	28	29	30	31	33	34	35	36	37	51	52	53	54	55	56	57	58	59	60	-dof	2	eigen6																																							
recorder	Node	-file	beam_mode7y.txt	-node	27	28	29	30	31	33	34	35	36	37	51	52	53	54	55	56	57	58	59	60	-dof	2	eigen7																																							
recorder	Node	-file	beam_mode8y.txt	-node	27	28	29	30	31	33	34	35	36	37	51	52	53	54	55	56	57	58	59	60	-dof	2	eigen8																																							
recorder	Node	-file	beam_mode9y.txt	-node	27	28	29	30	31	33	34	35	36	37	51	52	53	54	55	56	57	58	59	60	-dof	2	eigen9																																							
recorder	Node	-file	beam_mode10y.txt	-node	27	28	29	30	31	33	34	35	36	37	51	52	53	54	55	56	57	58	59	60	-dof	2	eigen10																																							
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

