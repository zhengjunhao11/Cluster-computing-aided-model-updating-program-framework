import dispy
from dispy import httpd,logger

def create_cluster(method, nodes):
    """
    Start a new Dispy cluster on 'nodes' to execute the method 'method'
    :param method: function to be executed on each cluster node
    :param nodes: list of node names or IP's.
    :return: the dispy cluster instance and the http_server for monitoring
    """

    cluster = dispy.JobCluster(method, nodes=nodes, loglevel=logger.DEBUG, ping_interval=1000,cleanup=False)


    return cluster

def cluster_visualization(cluster):

    return httpd.DispyHTTPServer(cluster)

