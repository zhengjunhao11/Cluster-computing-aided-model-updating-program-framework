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
    file_store = [r'G:\0_code_backup\cluster_computing_github\layout_optimization\displacement_element',
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
        ZA = 20 * x[0] - 20
        XB = 20 * x[1] - 20
        ZB = 20 * x[2] - 20
        XF = 20 * x[3] - 20
        ZF = 20 * x[4] - 20
        A1 = 0.0045 * x[5] - 0.00395
        A2 = 0.0045 * x[6] - 0.00395
        A3 = 0.0045 * x[7] - 0.00395
        A4 = 0.0045 * x[8] - 0.00395
        A5 = 0.0045 * x[9] - 0.00395
        A6 = 0.0045 * x[10] - 0.00395
        A7 = 0.0045 * x[11] - 0.00395
        A8 = 0.0045 * x[12] - 0.00395
        # 将变量写入文件
        parameter_old = ['ZA', 'XB', 'ZB', 'XF', 'ZF', 'A1', 'A2', 'A3', 'A4', 'A5', 'A6', 'A7', 'A8']
        parameter_new = [str(ZA), str(XB), str(ZB), str(XF), str(ZF), str(A1),
                         str(A2), str(A3), str(A4), str(A5), str(A6), str(A7), str(A8)]
        for i in range(len(parameter_old)):
            with open('parameter.tcl', 'r+', encoding='utf-8') as f:
                lines = f.readlines()
                f.seek(0)
                for line in lines:
                    if parameter_old[i] in line:
                        lines = "".join(lines).replace(parameter_old[i], parameter_new[i])
                f.write("".join(lines))
        # print('vector', x)
        def Run_OpenSees():
            os.system('opensees.exe p.tcl')
            print('finish running os')
            time.sleep(1)
            def Obj_function():
                distanceB = (ZB ** 2 + XB ** 2) ** 0.5
                distanceF = (ZF ** 2 + ZF ** 2) ** 0.5
                if os.path.exists('reaction.txt') is False or os.path.getsize('reaction.txt') == 0:
                    f = open('reaction.txt', 'a+')
                    f.write('250 250 250 250')
                    f.close()

                reaction = np.loadtxt('reaction.txt', delimiter=' ', dtype=float)
                force = 0
                for i in range(reaction.shape[0]):
                    force += reaction[i]

                if (os.path.exists('EigenVal.txt') is False or os.path.getsize('EigenVal.txt') < 60 or
                        os.path.getsize('EigenVal.txt') == 0):
                    f = open('EigenVal.txt', 'a+')
                    f.write(' lambda          omega           period          frequency\n')
                    f.write(' +1.444995e+02  +1.202080e+01  +5.226930e-01  +50\n')
                    f.write(' +1.444995e+02  +1.202080e+01  +5.226930e-01  +50\n')
                    f.write(' +1.444995e+02  +1.202080e+01  +5.226930e-01  +50\n')
                    f.write(' +1.444995e+02  +1.202080e+01  +5.226930e-01  +50\n')
                    f.close()

                fre = np.loadtxt('EigenVal.txt', skiprows=1, usecols=3, dtype=float)
                # print('fre',fre.shape)
                if fre.shape[0] == 5:
                    if distanceB < 2 and distanceF < 2:
                        if 4.5 + ZF < 5.7 + ZB and 6.0 + ZA > 5.7 + ZB + 0.2:
                            if fre[0] <= 15.196 and fre[1] >= 28.648:
                                obj_fun = force / 9.8 - 50
                            else:
                                obj_fun = 1000
                        else:
                            obj_fun = 1000
                    else:
                        obj_fun = 1000
                else:
                    obj_fun = 1000
                # 读取OS的结果
                # 计算距离OL5K
                # write parameters into file
                file = time_str + ' ' + pid_dir + '_parameter.txt'
                con_input = time_str + ' ' + pid_dir + ' ' + ' con ' + str(parameter_new) + '\n'
                obj_input = time_str + ' ' + pid_dir + ' ' + ' obj ' + str(obj_fun) + '\n'
                f = open(file, 'a+')
                f.write(con_input)
                f.write(obj_input)
                if fre.shape[0] == 5:
                    fre_input = time_str + ' ' + pid_dir + ' ' + ' fre ' + str(fre[0]) + ' ' + str(fre[1]) + ' ' + str(fre[2]) + '\n'
                    f.write(fre_input)
                os.remove('openSees.exe')
                reaction_file = time_str + 'reaction.txt'
                os.rename('reaction.txt', reaction_file)
                fre_file = time_str + 'fre.txt'
                os.rename('EigenVal.txt', fre_file)
                os.remove('openSees.exe')
                os.remove('parameter.tcl')
                return obj_fun
            return Obj_function()
        return Run_OpenSees()
    return modify_tcl()

