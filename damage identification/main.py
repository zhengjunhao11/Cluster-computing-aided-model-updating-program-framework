import dispy

from cluster_pso import PSO
from Optimization import func
from cluster_env import create_cluster,cluster_visualization
import time

if __name__=='__main__':
    start_time = time.strftime("%m_%d_%H_%M", time.localtime())
    # define the updating parameter range
    lower = [0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 0.9]
    upper = [1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1]
    # define the computing node ipv4
    nodes = ['172.18.107.103', '172.50.46.132', '172.50.47.110', '172.50.47.127', '172.50.46.104']
    mycluster = create_cluster(func, nodes)
    cluster_visualization(mycluster)
    pso = PSO(func=func, lb=lower, ub=upper, max_iter=30, pop=200, w=0.8, c1=1.49, c2=1.49, dim=10,
              cluster=mycluster, verbose=True)
    pso.record_mode = True
    # define the objective threshold (limit) and precision
    pso.best_x, pso.best_y = pso.run(limit=1e-2, precision=0.0001)
    print('best_x', pso.best_x, 'best_y', pso.best_y)
    end_time = time.strftime("%m_%d_%H_%M", time.localtime())
    print('best', pso.best_y, pso.best_x)
    print('best_1', pso.best_y, pso.best_y)