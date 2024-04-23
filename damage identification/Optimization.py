def func(x):
    import os
    import numpy as np
    from shutil import copy
    import time
    from datetime import datetime
    '''
    Parameters
    ----------
    X: updating parameters

    Returns
    -------
    obj_fun: objetive function value
    '''
    cluster_dir = os.getcwd()
    lib_dir = cluster_dir + '\\' + 'lib' + '\\' + 'tcl8.6'
    # define the file store direction in each computing node
    file_store = [r'H:\0_code_backup\cluster_computing_github\damage identification\updated_model_4damage_10poential',
                  r'C:\Users\Administrator\Desktop\linea_updating', r'C:\Users\zyys\Desktop\linea_updating',
                  r'C:\Users\Administrator\Desktop\linear', r'C:\Users\zy\Desktop\linea_updating']
    pid_dir = str(os.getpid())
    time_str = datetime.now().strftime("%m.%d.%H.%M.%S_")
    work_dir = cluster_dir + '\\' + pid_dir
    # establish file direction according to pid
    if not os.path.exists(work_dir):
        os.makedirs(work_dir)
    if not os.path.exists(lib_dir):
        try:
            os.makedirs(lib_dir)
        except:
            pass
    # transfer file to direction
    for i in range(len(file_store)):
        if os.path.exists(file_store[i]):
            for filename in os.listdir(file_store[i]):
                if filename == 'init.tcl':
                    copy(os.path.join(file_store[i], filename), lib_dir)
                    print('complete transfer lib_file')
                else:
                    copy(os.path.join(file_store[i], filename), work_dir)
                    print('complete transfer os_file')
    os.chdir(work_dir)
    def modify_tcl():
        x1 = x[0] * 4.5 - 3.95
        x2 = x[1] * 4.5 - 3.95
        x3 = x[2] * 4.5 - 3.95
        x4 = x[3] * 4.5 - 3.95
        x5 = x[4] * 4.5 - 3.95
        x6 = x[5] * 4.5 - 3.95
        x7 = x[6] * 4.5 - 3.95
        x8 = x[7] * 4.5 - 3.95
        x9 = x[8] * 4.5 - 3.95
        x10 = x[9] * 4.5 - 3.95
        with open('parameter.tcl', 'w+') as para:
            para.write('set ratio1 %f\n' % x1)
            para.write('set ratio2 %f\n' % x2)
            para.write('set ratio3 %f\n' % x3)
            para.write('set ratio4 %f\n' % x4)
            para.write('set ratio5 %f\n' % x5)
            para.write('set ratio6 %f\n' % x6)
            para.write('set ratio7 %f\n' % x7)
            para.write('set ratio8 %f\n' % x8)
            para.write('set ratio9 %f\n' % x9)
            para.write('set ratio10 %f\n' % x10)
        # print('vector', x)
        def Run_OpenSees():
            os.system('opensees.exe model_p.tcl')
            print('finish running os')
            time.sleep(1)
            col_target_shape = np.loadtxt('column_target_shape.txt')
            beam_target_shape = np.loadtxt('beam_target_shape.txt')
            if os.path.exists('EigenVal.txt') is False or os.path.getsize('EigenVal.txt') < 100:
                obj_value = 1000
            else:
                col_Yshape = time_str + '_col_yshape.txt'
                col_Xshape = time_str + '_col_xshape.txt'
                n = 10  # n表示一共有n个模态文件需要合并
                for i in range(n):
                    for filename in os.listdir():
                        if filename == 'column_mode' + str(i + 1) + 'y.txt':
                            # print(filename)
                            f = open(filename).read()
                            merge = open(col_Yshape, 'a+')
                            merge.write(f)
                            merge.close()
                        elif filename == 'column_mode' + str(i + 1) + 'x.txt':
                            f = open(filename).read()
                            merge = open(col_Xshape, 'a+')
                            merge.write(f)
                            merge.close()
            def Obj_function():
                obj_fre = [0.9769607, 2.128018, 4.257252, 5.857629, 7.64164, 10.20953, 11.26049, 15.52634, 2.518195, 9.607347]
                col_Y_simulation = np.array(np.loadtxt(col_Yshape, dtype=float))  # 读入Y方向所有的振型
                col_Y_simulation[abs(col_Y_simulation) < 1e-5] = 0
                col_X_simulation = np.array(np.loadtxt(col_Xshape, dtype=float))  # 读入z方向所有的振型
                col_X_simulation[abs(col_X_simulation) < 1e-5] = 0
                col_Y_Target_shape = col_target_shape[0:8, ...]
                print(col_Y_Target_shape.shape)
                col_X_Target_shape = col_target_shape[8:10, ...]
                print(col_X_Target_shape.shape)
                col_Y_Modal_num = np.zeros(col_Y_Target_shape.shape[0])
                col_X_Modal_num = np.zeros(col_X_Target_shape.shape[0])
                for i in range(col_Y_simulation.shape[0]):
                    for n in range(col_Y_Target_shape.shape[0]):
                        cor = np.corrcoef(col_Y_simulation[i], col_Y_Target_shape[n, ...])
                        Match_level = cor[0, 1]
                        if abs(Match_level) > 0.98 and col_Y_Modal_num[n] == 0:
                            col_Y_Modal_num[n] = i + 1
                            break
                # 识别Z方向振型
                for i in range(col_X_simulation.shape[0]):
                    for n in range(col_X_Target_shape.shape[0]):
                        cor = np.corrcoef(col_X_simulation[i], col_X_Target_shape[n, ...])
                        Match_level = cor[0, 1]
                        if abs(Match_level) > 0.98 and col_X_Modal_num[n] == 0:
                            col_X_Modal_num[n] = i + 1
                            break
                col_Modal_num = np.append(col_Y_Modal_num, col_X_Modal_num)
                col_Modal_num[col_Modal_num == 0] = 1
                print('col_identified_mode',col_Modal_num)
                fre = np.loadtxt('EigenVal.txt', skiprows=1, usecols=3)
                print(fre)
                # print(fre)
                obj_value_1 = 0
                for i in range(10):
                    if col_Modal_num[i] != 0:
                        obj_value_1 = obj_value_1 + ((fre[int(col_Modal_num[i]) - 1] - obj_fre[i]) / obj_fre[i]) ** 2
                        print(fre[int(col_Modal_num[i]) - 1], obj_fre[i])
                print('col_obj_value:', obj_value_1)
                beam_Yshape = time_str + '_beam_yshape.txt'
                beam_Xshape = time_str + '_beam_xshape.txt'
                n = 10  # n表示一共有n个模态文件需要合并
                for i in range(n):
                    for filename in os.listdir():
                        if filename == 'beam_mode' + str(i + 1) + 'y.txt':
                            # print(filename)
                            f = open(filename).read()
                            merge = open(beam_Yshape, 'a+')
                            merge.write(f)
                            merge.close()
                        elif filename == 'beam_mode' + str(i + 1) + 'x.txt':
                            f = open(filename).read()
                            merge = open(beam_Xshape, 'a+')
                            merge.write(f)
                            merge.close()
                beam_Y_simulation = np.array(np.loadtxt(beam_Yshape, dtype=float))  # 读入Y方向所有的振型
                beam_Y_simulation[abs(beam_Y_simulation) < 1e-5] = 0
                beam_X_simulation = np.array(np.loadtxt(beam_Xshape, dtype=float))  # 读入z方向所有的振型
                beam_X_simulation[abs(beam_X_simulation) < 1e-5] = 0
                beam_Y_Target_shape = beam_target_shape[0:8, ...]
                print(beam_Y_Target_shape.shape)
                beam_X_Target_shape = beam_target_shape[8:10, ...]
                print(beam_X_Target_shape.shape)
                beam_Y_Modal_num = np.zeros(beam_Y_Target_shape.shape[0])
                beam_X_Modal_num = np.zeros(beam_X_Target_shape.shape[0])
                for i in range(beam_Y_simulation.shape[0]):
                    for n in range(beam_Y_Target_shape.shape[0]):
                        cor = np.corrcoef(beam_Y_simulation[i], beam_Y_Target_shape[n, ...])
                        Match_level = cor[0, 1]
                        if abs(Match_level) > 0.98 and beam_Y_Modal_num[n] == 0:
                            beam_Y_Modal_num[n] = i + 1
                            break
                # 识别Z方向振型
                for i in range(beam_X_simulation.shape[0]):
                    for n in range(beam_X_Target_shape.shape[0]):
                        cor = np.corrcoef(beam_X_simulation[i], beam_X_Target_shape[n, ...])
                        Match_level = cor[0, 1]
                        if abs(Match_level) > 0.98 and beam_X_Modal_num[n] == 0:
                            beam_X_Modal_num[n] = i + 1
                            break
                beam_Modal_num = np.append(beam_Y_Modal_num, beam_X_Modal_num)
                beam_Modal_num[beam_Modal_num == 0] = 1
                print('beam_identified_mode',beam_Modal_num)
                fre = np.loadtxt('EigenVal.txt', skiprows=1, usecols=3)
                print(fre)
                # print(fre)
                obj_value_2 = 0
                for i in range(10):
                    if beam_Modal_num[i] != 0:
                        obj_value_2 = obj_value_2 + ((fre[int(beam_Modal_num[i]) - 1] - obj_fre[i]) / obj_fre[i]) ** 2
                        print(fre[int(beam_Modal_num[i]) - 1], obj_fre[i])
                print('beam_obj_value:', obj_value_2)
                obj_value = (obj_value_1+obj_value_2)/2
                print('obj_value:', obj_value)
                print('damage ratio:', x1, x2, x3, x4, x5, x6, x7, x8, x9, x10)
                fre_file=time_str+'_'+pid_dir+'_fre.txt'
                os.renames('EigenVal.txt', fre_file)
                recorder_file = time_str + '_' + pid_dir + '_parameter.txt'
                recorder = open(recorder_file, 'a+')
                x_input = time_str + ' ' + pid_dir + ' x ' + str(x) + '\n'
                obj_input = time_str + ' ' + pid_dir + ' obj ' + str(obj_value) + '\n'
                recorder.write(x_input)
                # recorder.write(damage_input)
                recorder.write(obj_input)
                recorder.close()
                os.remove('openSees.exe')
                os.remove('parameter.tcl')
                return obj_value
            return Obj_function()
        return Run_OpenSees()
    return modify_tcl()

