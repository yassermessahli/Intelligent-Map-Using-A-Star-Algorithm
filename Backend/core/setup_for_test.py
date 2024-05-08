from search import *

# you can adjust this whatever you want
graph_dict = {
    "S": [("A", 1), ("B", 4)],
    "A": [("B", 2), ("C", 5), ("G", 12)],
    "B": [("C", 2)],
    "C": [("G", 3)]
}
h_table = {
    "S": 7,
    "A": 6,
    "B": 4,
    "C": 2,
    "G": 0
}

# this code to generate the graph of node objects from the two dictionaries
nodes_list = []

for node_name in h_table.keys():
    new = Node(node_name, [], h_table[node_name])
    nodes_list.append(new)
    
for n in nodes_list:
    for a in graph_dict.get(n.name, []):
        n.add_adj((Node(a[0], [], h_table[a[0]]), a[1]))
        
graph = Graph(nodes_list)


# test the a_star function
start = Node("S", [], h_table["S"])
goal = Node("G", [], h_table["G"])

print([(str(node[0]), node[1]) for node in a_star(graph, start, goal)])