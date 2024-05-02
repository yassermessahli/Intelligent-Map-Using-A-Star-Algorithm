from django.http import JsonResponse
from core.search import Node, Graph, a_star
from django.views.decorators.csrf import csrf_exempt
from core.heuristic import calculate_heuristic , city_coordinates
from core.case import graph_dict
import json

@csrf_exempt
def calculate_path(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            city1_name = data.get('city1')
            city2_name = data.get('city2')
        except json.JSONDecodeError:
            return JsonResponse({'error': 'Invalid JSON format in request body'}, status=400)

        # Define the graph as dictionaries
        # graph_dict = {
        #     "S": [("A", 1), ("B", 4)],
        #     "A": [("B", 2), ("C", 5), ("G", 12)],
        #     "B": [("C", 2)],
        #     "C": [("G", 3)]
        # }

        h_table = {
        "EL Kseur centre": calculate_heuristic(city_coordinates["EL Kseur centre"][0], city_coordinates["EL Kseur centre"][1], city_coordinates[city2_name][0], city_coordinates[city2_name][1]),
        "Amizour": calculate_heuristic(city_coordinates["Amizour"][0], city_coordinates["Amizour"][1], city_coordinates[city2_name][0], city_coordinates[city2_name][1]),
        "Ilmaten":calculate_heuristic(city_coordinates["Ilmaten"][0], city_coordinates["Ilmaten"][1], city_coordinates[city2_name][0], city_coordinates[city2_name][1]),
        "Tifra": calculate_heuristic(city_coordinates["Tifra"][0], city_coordinates["Tifra"][1], city_coordinates[city2_name][0], city_coordinates[city2_name][1]),
        "Adekkar": calculate_heuristic(city_coordinates["Adekkar"][0], city_coordinates["Adekkar"][1], city_coordinates[city2_name][0], city_coordinates[city2_name][1]),
        "Barbacha":  calculate_heuristic(city_coordinates["Barbacha"][0], city_coordinates["Barbacha"][1], city_coordinates[city2_name][0], city_coordinates[city2_name][1]),
        "Toudja":   calculate_heuristic(city_coordinates["Toudja"][0], city_coordinates["Toudja"][1], city_coordinates[city2_name][0], city_coordinates[city2_name][1]),
        "Oued Ghir": calculate_heuristic(city_coordinates["Oued Ghir"][0], city_coordinates["Oued Ghir"][1], city_coordinates[city2_name][0], city_coordinates[city2_name][1]),
        "Seddouk":  calculate_heuristic(city_coordinates["Seddouk"][0], city_coordinates["Seddouk"][1], city_coordinates[city2_name][0], city_coordinates[city2_name][1]),
        "Sidi Aich": calculate_heuristic(city_coordinates["Sidi Aich"][0], city_coordinates["Sidi Aich"][1], city_coordinates[city2_name][0], city_coordinates[city2_name][1])
        }
        

        # Generate the graph of node objects from the dictionaries
        nodes_list = [Node(node_name, [], h_table[node_name]) for node_name in h_table.keys()]

        for n in nodes_list:
            for a in graph_dict.get(n.name, []):
                n.add_adj((Node(a[0], [], h_table[a[0]]), a[1]))

        graph = Graph(nodes_list)

        # Get the start and goal nodes from the graph
        city1_node = graph.get_node(city1_name)
        city2_node = graph.get_node(city2_name)
        
        if city1_node and city2_node:
            # Test the a_star function
            path = a_star(graph, city1_node, city2_node)
            if path:
                path_names = {str(node[0]): node[1] for node in path}
                return JsonResponse(path_names)
            else:
                return JsonResponse({'error': 'No path found'}, status=404)
        else:
            return JsonResponse({'error': 'City not found'}, status=404)

    else:
        # Return error response for other request methods
        return JsonResponse({'error': 'Only POST requests are allowed'}, status=405)
