extends Node

const DESIRED_NODE_COUNT = 100
const MIN_X = -300
const MAX_X = 300
const MIN_Y = -300
const MAX_Y = 300
const MIN_DISTANCE = 5
const MIN_EDGES = 3
const MAX_EDGES = 5
const MAX_NODE_LOOKUP = 10

var rng = RandomNumberGenerator.new()
var map_node = preload("res://Src/Objects/MapNode.tscn")
var map_edge = preload("res://Src/Objects/MapEdge.tscn")
func _ready():
	generate_map()
	
func generate_map():
	var map_state = MapState.new()
	rng.randomize()
	generate_nodes(map_state)
	generate_edges(map_state)
		
func generate_nodes(map_state):
	var generated_nodes = 0
	while (generated_nodes < DESIRED_NODE_COUNT):
		var new_x = rng.randf_range(MIN_X, MAX_X)
		var new_y = rng.randf_range(MIN_Y, MAX_Y)
		var new_location = Vector2(new_x, new_y)
		
		var shortest_distance = map_state.find_closest_node(new_location)
		if shortest_distance < MIN_DISTANCE:
			continue
		var new_node = map_node.instance()
		add_child(new_node)
		new_node.position = new_location
		map_state.nodes.append(new_node)
		generated_nodes += 1
		
func generate_edges(map_state: MapState):
	var nodes = map_state.nodes
	
	for node in nodes:
		var node_edge_count = node.edges.size()
		var edges_left = rng.randi_range(MIN_EDGES - node_edge_count, MAX_EDGES - node_edge_count)
		
		var closest_nodes = map_state.get_nodes_in_distance_order(node.position)
		while edges_left > 0:
			var node_to_be_added = closest_nodes[rng.randi_range(0,MAX_NODE_LOOKUP)]
			if add_edge(node, node_to_be_added):
				edges_left -= 1

func add_edge(target_node: MapNode, other_node: MapNode):
	if target_node.has_edge(other_node):
		return false
	
	var edge: MapEdge = map_edge.instance()
	add_child(edge)
	edge.map_node_1 = target_node
	edge.map_node_2 = other_node
	edge.points = [target_node.position, other_node.position]
	target_node.edges.append(edge)
	other_node.edges.append(edge)
	
	return true
