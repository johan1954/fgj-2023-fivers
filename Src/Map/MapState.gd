class_name MapState

var nodes: Array[MapNode]

func find_closest_node(other_position: Vector2) -> MapNode:
	if nodes.size() == 0:
		return null
	
	var closest_distance = INF
	var closest_node: MapNode
	for node in nodes:
		var distance = node.get_distance(other_position)
		if (distance < closest_distance):
			closest_distance = distance
			closest_node = node
			
	return closest_node
	
func get_nodes_in_distance_order(position: Vector2) -> Array[MapNode]:
	var distances_and_nodes = []
	
	for node in nodes:
		var distance = node.get_distance(position)
		distances_and_nodes.append([distance, node])
		
	distances_and_nodes.sort_custom(Callable(self,"distance_comparison"))
	
	var ordered_nodes: Array[MapNode]
	for node_and_distance in distances_and_nodes:
		ordered_nodes.append(node_and_distance[1])
		
	return ordered_nodes
	
func intersects_with_any_other_edge(position_1: Vector2, position_2: Vector2) -> bool:
	for node in nodes:
		for edge in node.edges:
			if edge.intersect_with(position_1, position_2):
				return true
				
	return false
	
func distance_comparison(distance_and_node_1, distance_and_node_2):
	return distance_and_node_1[0] < distance_and_node_2[0]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
