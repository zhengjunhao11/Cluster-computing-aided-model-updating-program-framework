#----------��������Ϣ-------------------------------------------------
#����w
set beamw 0.200
#����h
set beamh 0.400
#---------��������Ϣ���ȱߣ�------------------------------------------
#����d
set columnd 0.400

#---------��������������������--------------------------------------
set c 0.020
#-------------����ֽ����----------------------------
#��    ǰ��λ����Ӧ��Ӧ�Ľ���ţ�����λ��0Ϊ�²��ֽ1Ϊ�ϲ��ֽ�  
set	tA1100	4.00E-04
set	tA1101	8.00E-04
set A1100  [expr $tA1100/4]
set A1101  [expr $tA1101/4]
#---------C30��������ģ�����ɱ�---------------------------------------
set Ec 3.00e10
set mu 0.2
set G  [expr $Ec/(2.0*(1.0+$mu))]
#������Ťת�ն�
set beamIp   1.333333e-3
uniaxialMaterial Elastic  7  [expr $G*$beamIp]
#������Ťת�ն�
set columnIp 0.004267
uniaxialMaterial Elastic  8  [expr $G*$columnIp]

#---------�ֽ�뾶,beamrΪ���Ĺ���ֱ��+�ݽ�뾶��columnrΪ���Ĺ���ֱ��+�ݽ�뾶-------------------------
set beamr   0.015
#set beamr   0.010
set columnr 0.017
#---------------------------�������------------------------------
#---������ؼ���---
set ByI  [expr -$beamh/2]
set BzI  [expr -$beamw/2]
set ByJ  [expr  $beamh/2]
set BzJ  [expr  $beamw/2]
#---����ؼ���---
set sByI [expr -$beamh/2+$c+$beamr]
set sBzI [expr -$beamw/2+$c+$beamr]
set sByJ [expr  $beamh/2-$c-$beamr]
set sBzJ [expr  $beamw/2-$c-$beamr]

#-------------����ֽ����----------------------------
#�����˴�������Ϊ���������                    
set A00  0.20e-3
set A01  0.15e-3
set A02  0.10e-3
#---������ؼ���---
set CyI  [expr -$columnd/2] 
set CzI  [expr -$columnd/2] 
set CyJ  [expr  $columnd/2] 
set CzJ  [expr  $columnd/2] 
#---���������ؼ���(sCy4-1Ϊy������µ���)---
set sCy4 [expr -$columnd/2+$c+$columnr]
set sCy3 [expr -$columnd/2+$c+$columnr+($columnd-2*$c-2*$columnr)/3.0]
set sCy2 [expr -$columnd/2+$c+$columnr+2*($columnd-2*$c-2*$columnr)/3.0]
set sCy1 [expr  $columnd/2-$c-$columnr]
set sCyI [expr -$columnd/2+$c+$columnr]
set sCzI [expr -$columnd/2+$c+$columnr]
set sCyJ [expr  $columnd/2-$c-$columnr]
set sCzJ [expr  $columnd/2-$c-$columnr]

#damage section1
#---------��������----------------------------------------------------
#beam
#��&���Ǻ���--  Ӧ��Ϊ2fcu/Ec
uniaxialMaterial Concrete01 3011 [expr $ratio1*-26.1e6] -0.00174  [expr $ratio1*-13.05e6] -0.02
#ֱ��1�ֽ� ����+ֱ��    ���ϱ��
uniaxialMaterial Hysteretic   311 [expr $ratio1*432e6] 0.002   [expr $ratio1*572e6] 0.15 20.0e6 0.20 [expr $ratio1*-432e6]  -0.002 [expr $ratio1*-572e6] -0.15 -20.0e6 -0.20 1.0 1.0 0.0 0.0 0.5
section Fiber 3331 -GJ 7 {
# ---------������ά��Ԫ--------------------------------------------        
#---�����ε�Ԫ ���ֵ�Ԫ����� Y���򻮷ָ���  Z���򻮷ָ���    1��Y��������    1��Z��������   2��Y��������  2��Z�������� 
patch rect          3011              10              5              $ByI            $BzI            $ByJ            $BzJ        
#�ֽ�          
#�ϲ��ֽ� 
layer straight 311 4 $A1101 $sByJ $sBzI $sByJ $sBzJ        
#�²��ֽ�
layer straight 311 4 $A1100 $sByI $sBzI $sByI $sBzJ         
}
#---------------------------
uniaxialMaterial Concrete01 3012 [expr $ratio2*-26.1e6] -0.00174  [expr $ratio2*-13.05e6] -0.02
uniaxialMaterial Hysteretic   312 [expr $ratio2*432e6] 0.002   [expr $ratio2*572e6] 0.15 20.0e6 0.20 [expr $ratio2*-432e6]  -0.002 [expr $ratio2*-572e6] -0.15 -20.0e6 -0.20 1.0 1.0 0.0 0.0 0.5
section Fiber 3332 -GJ 7 {
patch rect          3012              10              5              $ByI            $BzI            $ByJ            $BzJ        
layer straight 312 4 $A1101 $sByJ $sBzI $sByJ $sBzJ        
layer straight 312 4 $A1100 $sByI $sBzI $sByI $sBzJ         
}

#potential damage
uniaxialMaterial Concrete01 3013 [expr $ratio3*-26.1e6] -0.00174  [expr $ratio3*-13.05e6] -0.02
uniaxialMaterial Hysteretic  313 [expr $ratio3*432e6] 0.002   [expr $ratio3*572e6] 0.15 20.0e6 0.20 [expr $ratio3*-432e6]  -0.002 [expr $ratio3*-572e6] -0.15 -20.0e6 -0.20 1.0 1.0 0.0 0.0 0.5

section Fiber 3333 -GJ 7 {
patch rect          3013              10              5              $ByI            $BzI            $ByJ            $BzJ        
layer straight 313 4 $A1101 $sByJ $sBzI $sByJ $sBzJ        
layer straight 313 4 $A1100 $sByI $sBzI $sByI $sBzJ         
}
#---------------------------
uniaxialMaterial Concrete01 3014 [expr $ratio4*-26.1e6] -0.00174  [expr $ratio4*-13.05e6] -0.02
uniaxialMaterial Hysteretic   314 [expr $ratio4*432e6] 0.002   [expr $ratio4*572e6] 0.15 20.0e6 0.20 [expr $ratio4*-432e6]  -0.002 [expr $ratio4*-572e6] -0.15 -20.0e6 -0.20 1.0 1.0 0.0 0.0 0.5
section Fiber 3334 -GJ 7 {
patch rect          3014              10              5              $ByI            $BzI            $ByJ            $BzJ        
layer straight 314 4 $A1101 $sByJ $sBzI $sByJ $sBzJ        
layer straight 314 4 $A1100 $sByI $sBzI $sByI $sBzJ         
}


#column
#damaged section
#���Ǻ���--  Ӧ��Ϊ2fcu/Ec
uniaxialMaterial Concrete01 4112 [expr $ratio5*-26.1e6] -0.00174  [expr $ratio5*-13.05e6] -0.02
#�����Ļ�����   �˷Ŵ�ϵ������1.204��26.1*1.204=31.43
uniaxialMaterial Concrete01 4111 [expr $ratio5*-31.43e6] -0.002095  [expr $ratio5*-15.72e6] -0.02
#steel
#ֱ��1�ֽ� ����+ֱ��    ���ϱ��
uniaxialMaterial Hysteretic   412 [expr $ratio5*432e6] 0.002   [expr $ratio5*572e6] 0.15 20.0e6 0.20 [expr $ratio5*-432e6]  -0.002 [expr $ratio5*-572e6] -0.15 -20.0e6 -0.20 1.0 1.0 0.0 0.0 0.5
section Fiber 4441 -torsion 8 {
#---�����ε�Ԫ �������ò���     Y���򻮷ָ���  Z���򻮷ָ���    1��Y��������    1��Z��������   2��Y��������  2��Z�������� 
patch rect          4111              5             5              $sCyI           $sCzI           $sCyJ           $sCzJ   
patch rect          4112              6             1               $CyI            $CzI            $CyJ            $sCzI  
patch rect          4112              6             1               $CyI            $sCzJ           $CyJ            $CzJ
patch rect          4112              1              5              $CyI            $sCzI           $sCyI            $sCzJ 
patch rect          4112              1              5              $sCyJ            $sCzI           $CyJ            $sCzJ     
#�ֽ�          
#�ϲ��в��ֽ� 
layer straight 412 2 $A02 $sCy1 $sCy2 $sCy1 $sCy3  

#�ϲ��ǽ� 
layer straight 412 2 $A01 $sCy1 $sCzI $sCy1 $sCzJ     

#�ڶ���ֽ�
layer straight 412 2 $A02 $sCy2 $sCzI $sCy2 $sCzJ  

#������ֽ�
layer straight 412 2 $A02 $sCy3 $sCzI $sCy3 $sCzJ       

#�²��в��ֽ�
layer straight 412 2 $A02 $sCy4 $sCy2 $sCy4 $sCy3 

#�²��ǽ�
layer straight 412 2 $A01 $sCy4 $sCzI $sCy4 $sCzJ         

}  


#column
#damaged section
uniaxialMaterial Concrete01 4113 [expr $ratio6*-26.1e6] -0.00174  [expr $ratio6*-13.05e6] -0.02
uniaxialMaterial Concrete01 4114 [expr $ratio6*-31.43e6] -0.002095  [expr $ratio6*-15.72e6] -0.02
uniaxialMaterial Hysteretic   413 [expr $ratio6*432e6] 0.002   [expr $ratio6*572e6] 0.15 20.0e6 0.20 [expr $ratio6*-432e6]  -0.002 [expr $ratio6*-572e6] -0.15 -20.0e6 -0.20 1.0 1.0 0.0 0.0 0.5
section Fiber 4442 -torsion 8 {
patch rect          4113              5             5              $sCyI           $sCzI           $sCyJ           $sCzJ   
patch rect          4114              6             1               $CyI            $CzI            $CyJ            $sCzI  
patch rect          4114              6             1               $CyI            $sCzJ           $CyJ            $CzJ
patch rect          4114              1              5              $CyI            $sCzI           $sCyI            $sCzJ 
patch rect          4114              1              5              $sCyJ            $sCzI           $CyJ            $sCzJ     
layer straight 413 2 $A02 $sCy1 $sCy2 $sCy1 $sCy3  
layer straight 413 2 $A01 $sCy1 $sCzI $sCy1 $sCzJ     
layer straight 413 2 $A02 $sCy2 $sCzI $sCy2 $sCzJ  
layer straight 413 2 $A02 $sCy3 $sCzI $sCy3 $sCzJ       
layer straight 413 2 $A02 $sCy4 $sCy2 $sCy4 $sCy3 
layer straight 413 2 $A01 $sCy4 $sCzI $sCy4 $sCzJ         
}

#potential
uniaxialMaterial Concrete01 4115 [expr $ratio7*-26.1e6] -0.00174  [expr $ratio7*-13.05e6] -0.02
uniaxialMaterial Concrete01 4116 [expr $ratio7*-31.43e6] -0.002095  [expr $ratio7*-15.72e6] -0.02
uniaxialMaterial Hysteretic   414 [expr $ratio7*432e6] 0.002   [expr $ratio7*572e6] 0.15 20.0e6 0.20 [expr $ratio7*-432e6]  -0.002 [expr $ratio7*-572e6] -0.15 -20.0e6 -0.20 1.0 1.0 0.0 0.0 0.5
section Fiber 4443 -torsion 8 {
patch rect          4115              5             5              $sCyI           $sCzI           $sCyJ           $sCzJ   
patch rect          4116              6             1               $CyI            $CzI            $CyJ            $sCzI  
patch rect          4116              6             1               $CyI            $sCzJ           $CyJ            $CzJ
patch rect          4116              1              5              $CyI            $sCzI           $sCyI            $sCzJ 
patch rect          4116              1              5              $sCyJ            $sCzI           $CyJ            $sCzJ     
layer straight 414 2 $A02 $sCy1 $sCy2 $sCy1 $sCy3  
layer straight 414 2 $A01 $sCy1 $sCzI $sCy1 $sCzJ     
layer straight 414 2 $A02 $sCy2 $sCzI $sCy2 $sCzJ  
layer straight 414 2 $A02 $sCy3 $sCzI $sCy3 $sCzJ       
layer straight 414 2 $A02 $sCy4 $sCy2 $sCy4 $sCy3 
layer straight 414 2 $A01 $sCy4 $sCzI $sCy4 $sCzJ         
}

uniaxialMaterial Concrete01 4117 [expr $ratio8*-26.1e6] -0.00174  [expr $ratio8*-13.05e6] -0.02
uniaxialMaterial Concrete01 4118 [expr $ratio8*-31.43e6] -0.002095  [expr $ratio8*-15.72e6] -0.02
uniaxialMaterial Hysteretic   415 [expr $ratio8*432e6] 0.002   [expr $ratio8*572e6] 0.15 20.0e6 0.20 [expr $ratio8*-432e6]  -0.002 [expr $ratio8*-572e6] -0.15 -20.0e6 -0.20 1.0 1.0 0.0 0.0 0.5
section Fiber 4444 -torsion 8 {
patch rect          4117              5             5              $sCyI           $sCzI           $sCyJ           $sCzJ   
patch rect          4118              6             1               $CyI            $CzI            $CyJ            $sCzI  
patch rect          4118              6             1               $CyI            $sCzJ           $CyJ            $CzJ
patch rect          4118              1              5              $CyI            $sCzI           $sCyI            $sCzJ 
patch rect          4118              1              5              $sCyJ            $sCzI           $CyJ            $sCzJ     
layer straight 415 2 $A02 $sCy1 $sCy2 $sCy1 $sCy3  
layer straight 415 2 $A01 $sCy1 $sCzI $sCy1 $sCzJ     
layer straight 415 2 $A02 $sCy2 $sCzI $sCy2 $sCzJ  
layer straight 415 2 $A02 $sCy3 $sCzI $sCy3 $sCzJ       
layer straight 415 2 $A02 $sCy4 $sCy2 $sCy4 $sCy3 
layer straight 415 2 $A01 $sCy4 $sCzI $sCy4 $sCzJ         
}

uniaxialMaterial Concrete01 4119 [expr $ratio9*-26.1e6] -0.00174  [expr $ratio9*-13.05e6] -0.02
uniaxialMaterial Concrete01 4120 [expr $ratio9*-31.43e6] -0.002095  [expr $ratio9*-15.72e6] -0.02
uniaxialMaterial Hysteretic   416 [expr $ratio9*432e6] 0.002   [expr $ratio9*572e6] 0.15 20.0e6 0.20 [expr $ratio9*-432e6]  -0.002 [expr $ratio9*-572e6] -0.15 -20.0e6 -0.20 1.0 1.0 0.0 0.0 0.5
section Fiber 4445 -torsion 8 {
patch rect          4119              5             5              $sCyI           $sCzI           $sCyJ           $sCzJ   
patch rect          4120              6             1               $CyI            $CzI            $CyJ            $sCzI  
patch rect          4120              6             1               $CyI            $sCzJ           $CyJ            $CzJ
patch rect          4120              1              5              $CyI            $sCzI           $sCyI            $sCzJ 
patch rect          4120              1              5              $sCyJ            $sCzI           $CyJ            $sCzJ     
layer straight 416 2 $A02 $sCy1 $sCy2 $sCy1 $sCy3  
layer straight 416 2 $A01 $sCy1 $sCzI $sCy1 $sCzJ     
layer straight 416 2 $A02 $sCy2 $sCzI $sCy2 $sCzJ  
layer straight 416 2 $A02 $sCy3 $sCzI $sCy3 $sCzJ       
layer straight 416 2 $A02 $sCy4 $sCy2 $sCy4 $sCy3 
layer straight 416 2 $A01 $sCy4 $sCzI $sCy4 $sCzJ         
}

uniaxialMaterial Concrete01 4121 [expr $ratio10*-26.1e6] -0.00174  [expr $ratio10*-13.05e6] -0.02
uniaxialMaterial Concrete01 4122 [expr $ratio10*-31.43e6] -0.002095  [expr $ratio10*-15.72e6] -0.02
uniaxialMaterial Hysteretic   417 [expr $ratio10*432e6] 0.002   [expr $ratio10*572e6] 0.15 20.0e6 0.20 [expr $ratio10*-432e6]  -0.002 [expr $ratio10*-572e6] -0.15 -20.0e6 -0.20 1.0 1.0 0.0 0.0 0.5
section Fiber 4446 -torsion 8 {
patch rect          4121              5             5              $sCyI           $sCzI           $sCyJ           $sCzJ   
patch rect          4122              6             1               $CyI            $CzI            $CyJ            $sCzI  
patch rect          4122              6             1               $CyI            $sCzJ           $CyJ            $CzJ
patch rect          4122              1              5              $CyI            $sCzI           $sCyI            $sCzJ 
patch rect          4122              1              5              $sCyJ            $sCzI           $CyJ            $sCzJ     
layer straight 417 2 $A02 $sCy1 $sCy2 $sCy1 $sCy3  
layer straight 417 2 $A01 $sCy1 $sCzI $sCy1 $sCzJ     
layer straight 417 2 $A02 $sCy2 $sCzI $sCy2 $sCzJ  
layer straight 417 2 $A02 $sCy3 $sCzI $sCy3 $sCzJ       
layer straight 417 2 $A02 $sCy4 $sCy2 $sCy4 $sCy3 
layer straight 417 2 $A01 $sCy4 $sCzI $sCy4 $sCzJ         
}