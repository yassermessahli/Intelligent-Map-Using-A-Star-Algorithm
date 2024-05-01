class Node:
    name = None
    heuristic = None
    adjacency_list = None # list of tuples (node, cost)
    
    def __init__(self, name, adj: list, h: int):
        self.name = name
        self.heuristic = h
        self.adjacency_list = adj
        
    def add_adj(self, adj):
        self.adjacency_list.append(adj) 
        
    def __str__(self):
        return self.name


class Graph:
    graph_nodes = {}
    
    def __init__(self, nodes_list: list):
        for node in nodes_list:
            self.graph_nodes[node.name] = node
            
    def get_node(self, name):
        return self.graph_nodes.get(name, None)
    
    def __str__(self):
        return str(self.graph_nodes)


class CustomizableQueue:
    """
    Customizable queue for A* algorithm.
    The queue is a list of paths, where each path is a list of tuples (node, cost).
    sort the queue based on type parameter. it can be "f", "g" or any other custom function
    """
    queue = None
    type = None
    
    def get_g_cost(self, path:list):
        return sum(p[1] for p in path)

    def get_f_cost(self, path: list):
        g_cost = self.get_g_cost(path)
        h_cost = path[-1][0].heuristic
        return  g_cost + h_cost
    
    def perform_sort(self, type):
        if type == None:
            self.queue.sort(key=lambda x: self.get_g_cost(x))
        elif type == "f":
            self.queue.sort(key=lambda x: self.get_f_cost(x))
        else:
            self.queue.sort(key=type)
    
    def __init__(self, type=None, queue=[]):
        self.type = type
        self.queue = queue
        self.perform_sort(type)
        
    def pop(self):
        return self.queue.pop(0)
    
    def push(self, path):      
        self.queue.append(path)
        self.perform_sort(self.type)
        
    def __str__(self):
        return str(self.queue)





def a_star(graph:Graph, start:Node, goal:Node):
    priority_queue = CustomizableQueue("f", [[(start, 0)]])
    visited = set()
    
    while priority_queue.queue:
        path = priority_queue.pop()
        last_node = path[-1][0]
        
        if last_node in visited:
            continue
        visited.add(last_node)
        
        if last_node.name == goal.name:
            return path
        
        for adjacent in graph.get_node(last_node.name).adjacency_list:
            priority_queue.push(path + [adjacent])
    return None