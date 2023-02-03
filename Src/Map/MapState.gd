class_name MapState

var nodes = []

func find_closest_node(position: Vector2):
	if nodes.size() == 0:
		return INF
	
	var closest_distance = INF
	var closest_node = nodes[0]
	for node_index in range(1, nodes.size()):
		var node_candidate = nodes[node_index]
		var distance = node_candidate.get_distance(position)
		if (distance < closest_distance):
			closest_distance = distance
			closest_node = node_candidate
			
	return closest_distance
	
func get_nodes_in_distance_order(position: Vector2):
	var distances_and_nodes = []
	
	for node in nodes:
		var distance = node.get_distance(position)
		distances_and_nodes.append([distance, node])
		
	distances_and_nodes.sort_custom(self, "distance_comparison")
	
	var nodes2 = []
	for node_and_distance in distances_and_nodes:
		nodes2.append(node_and_distance[1])
		
	return nodes2
	
func distance_comparison(distance_and_node_1, distance_and_node_2):
	return distance_and_node_1[0] < distance_and_node_2[0]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
