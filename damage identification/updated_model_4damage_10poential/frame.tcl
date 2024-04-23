
node	1	0.0	0	0.0
node	2	0.0	0	0.5
node	3	0.0	0	1.0
node	4	0.0	0	1.5
node	5	0.0	0	2.0
node	6	0.0	0	2.5
node	7	0.0	0	3.0
node	8	0.0	0	3.5
node	9	0.0	0	4.0
node	10	0.0	0	4.5
node	11	0.0	0	5.0
node	12	0.0	0	5.5
node	13	0.0	0	6.0
				
				
node	14	3.0	0	0.0
node	15	3.0	0	0.5
node	16	3.0	0	1.0
node	17	3.0	0	1.5
node	18	3.0	0	2.0
node	19	3.0	0	2.5
node	20	3.0	0	3.0
node	21	3.0	0	3.5
node	22	3.0	0	4.0
node	23	3.0	0	4.5
node	24	3.0	0	5.0
node	25	3.0	0	5.5
node	26	3.0	0	6.0

node	38	6.0	0	0.0
node	39	6.0	0	0.5
node	40	6.0	0	1.0
node	41	6.0	0	1.5
node	42	6.0	0	2.0
node	43	6.0	0	2.5
node	44	6.0	0	3.0
node	45	6.0	0	3.5
node	46	6.0	0	4.0
node	47	6.0	0	4.5
node	48	6.0	0	5.0
node	49	6.0	0	5.5
node	50	6.0	0	6.0

# beam node

node	27	0.5	0.0	3.0
node	28	1.0	0.0	3.0
node	29	1.5	0.0	3.0
node	30	2.0	0.0	3.0
node	31	2.5	0.0	3.0
				
				
node	33	0.5	0.0	6.0
node	34	1.0	0.0	6.0
node	35	1.5	0.0	6.0
node	36	2.0	0.0	6.0
node	37	2.5	0.0	6.0

node	51	3.5	0.0	3.0
node	52	4.0	0.0	3.0
node	53	4.5	0.0	3.0
node	54	5.0	0.0	3.0
node	55	5.5	0.0	3.0
				
				
node	56	3.5	0.0	6.0
node	57	4.0	0.0	6.0
node	58	4.5	0.0	6.0
node	59	5.0	0.0	6.0
node	60	5.5	0.0	6.0


puts "node"
fix 1 1 1 1 1 1	1
fix 14	1	1	1	1	1	1
fix 38 	1	1	1	1	1	1




#---------材料属性----------------------------------------------------
#梁&柱非核心--  应变为2fcu/Ec
#uniaxialMaterial Concrete01 101 -29.64e6 -0.00198  -14.82e6 -0.02
uniaxialMaterial Concrete01 101 -26.1e6 -0.00174  -13.05e6 -0.02

#柱核心混凝土   乘放大系数——1.204；26.1*1.204=31.43
#uniaxialMaterial Concrete01 111 -35.568e6 -0.00237  -17.784e6 -0.02
uniaxialMaterial Concrete01 111 -31.43e6 -0.002095  -15.72e6 -0.02
#steel
#直径1钢筋 材性+直径    材料编号
uniaxialMaterial Hysteretic   1 432e6 0.002   572e6 0.15 20.0e6 0.20 -432e6  -0.002 -572e6 -0.15 -20.0e6 -0.20 1.0 1.0 0.0 0.0 0.5


#-----------------------------------------------------梁截面--------------------------------------------------------------------------------

section Fiber 110 -GJ 7 {
# ---------划分纤维单元--------------------------------------------        
#---梁矩形单元 划分单元截面号 Y方向划分个数  Z方向划分个数    1点Y方向坐标    1点Z方向坐标   2点Y方向坐标  2点Z方向坐标 
patch rect          101              10              5              $ByI            $BzI            $ByJ            $BzJ        
#钢筋          
#上部钢筋 
layer straight 1 4 $A1101 $sByJ $sBzI $sByJ $sBzJ        

#下部钢筋
layer straight 1 4 $A1100 $sByI $sBzI $sByI $sBzJ         

}

#普通柱
section Fiber 1 -torsion 8 {
#---柱矩形单元 截面所用材料     Y方向划分个数  Z方向划分个数    1点Y方向坐标    1点Z方向坐标   2点Y方向坐标  2点Z方向坐标 
patch rect          111              5             5              $sCyI           $sCzI           $sCyJ           $sCzJ   
patch rect          101              6             1               $CyI            $CzI            $CyJ            $sCzI  
patch rect          101              6             1               $CyI            $sCzJ           $CyJ            $CzJ
patch rect          101              1              5              $CyI            $sCzI           $sCyI            $sCzJ 
patch rect          101              1              5              $sCyJ            $sCzI           $CyJ            $sCzJ     
#钢筋          
#上部中部钢筋 
layer straight 1 2 $A02 $sCy1 $sCy2 $sCy1 $sCy3  

#上部角筋 
layer straight 1 2 $A01 $sCy1 $sCzI $sCy1 $sCzJ     

#第二层钢筋
layer straight 1 2 $A02 $sCy2 $sCzI $sCy2 $sCzJ  

#第三层钢筋
layer straight 1 2 $A02 $sCy3 $sCzI $sCy3 $sCzJ       

#下部中部钢筋
layer straight 1 2 $A02 $sCy4 $sCy2 $sCy4 $sCy3 

#下部角筋
layer straight 1 2 $A01 $sCy4 $sCzI $sCy4 $sCzJ         

}   
geomTransf PDelta 1  1  0  0
geomTransf Corotational 2  0 -1  0
puts "section"

# column element
#damaged
element	dispBeamColumn	1	1	2	5	4441	1
element	dispBeamColumn	2	2	3	5	4441	1
element	dispBeamColumn	3	3	4	5	4441	1
element	dispBeamColumn	4	4	5	5	4441	1
element	dispBeamColumn	5	5	6	5	4441	1
element	dispBeamColumn	6	6	7	5	4441	1
#-----------------
element	dispBeamColumn	7		7		8		5	4444	1
element	dispBeamColumn	8		8		9		5	4444	1
element	dispBeamColumn	9		9		10	5	4444	1
element	dispBeamColumn	10	10	11	5	4444	1
element	dispBeamColumn	11	11	12	5	4444	1
element	dispBeamColumn	12	12	13	5	4444	1
							
							
element	dispBeamColumn	13	14	15	5 4442	1	
element	dispBeamColumn	14	15	16	5 4442	1	
element	dispBeamColumn	15	16	17	5 4442	1	
element	dispBeamColumn	16	17	18	5 4442	1	
element	dispBeamColumn	17	18	19	5 4442	1	
element	dispBeamColumn	18	19	20	5 4442	1	
#----------------------
element	dispBeamColumn	19	20	21	5	4445	1
element	dispBeamColumn	20	21	22	5	4445	1
element	dispBeamColumn	21	22	23	5	4445	1
element	dispBeamColumn	22	23	24	5	4445	1
element	dispBeamColumn	23	24	25	5	4445	1
element	dispBeamColumn	24	25	26	5	4445	1

element	dispBeamColumn	49	38	39	5	4443	1
element	dispBeamColumn	50	39	40	5	4443	1
element	dispBeamColumn	51	40	41	5	4443	1
element	dispBeamColumn	52	41	42	5	4443	1
element	dispBeamColumn	53	42	43	5	4443	1
element	dispBeamColumn	54	43	44	5	4443	1  
#---------------------------
element	dispBeamColumn	55	44	45	5 4446	1	
element	dispBeamColumn	56	45	46	5 4446	1	
element	dispBeamColumn	57	46	47	5 4446	1	
element	dispBeamColumn	58	47	48	5 4446	1	
element	dispBeamColumn	59	48	49	5 4446	1	
element	dispBeamColumn	60	49	50	5 4446	1	


#beam

element	dispBeamColumn	25	7		27	5	3331	2
element	dispBeamColumn	26	27	28	5	3331	2
element	dispBeamColumn	27	28	29	5	3331	2
element	dispBeamColumn	28	29	30	5	3331	2
element	dispBeamColumn	29	30	31	5	3331	2
element	dispBeamColumn	30	31	20	5	3331	2
#-------------------							
element	dispBeamColumn	31	13	33	5	3333	2
element	dispBeamColumn	32	33	34	5	3333	2
element	dispBeamColumn	33	34	35	5	3333	2
element	dispBeamColumn	34	35	36	5	3333	2
element	dispBeamColumn	35	36	37	5	3333	2
element	dispBeamColumn	36	37	26	5	3333	2

element	dispBeamColumn	37	20	51	5	3332	2
element	dispBeamColumn	38	51	52	5	3332	2
element	dispBeamColumn	39	52	53	5	3332	2
element	dispBeamColumn	40	53	54	5	3332	2
element	dispBeamColumn	41	54	55	5	3332	2
element	dispBeamColumn	42	55	44	5	3332	2
							
element	dispBeamColumn	43	26	56	5	3334	2
element	dispBeamColumn	44	56	57	5	3334	2
element	dispBeamColumn	45	57	58	5	3334	2
element	dispBeamColumn	46	58	59	5	3334	2
element	dispBeamColumn	47	59	60	5	3334	2
element	dispBeamColumn	48	60	50	5	3334	2

puts "element"