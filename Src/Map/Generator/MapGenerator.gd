extends Node

class_name MapGenerator

const DESIRED_NODE_COUNT = 100
const MIN_X = -356
const MAX_X = 356
const MIN_Y = -200
const MAX_Y = 200
const MIN_DISTANCE_TO_NODE = 40
const MIN_DISTANCE_TO_EDGE = 20
const MIN_EDGES = 3
const MAX_EDGES = 5
const MAX_NODE_LOOKUP = 10

var rng = RandomNumberGenerator.new()
	
func generate_map() -> MapState:
	var map_state = MapState.new()
	rng.randomize()
	
	generate_nodes(map_state)
	generate_edges(map_state)
	spawn_players(map_state)
	
	return map_state
		
func generate_nodes(map_state: MapState):
	while (map_state.nodes.size() < DESIRED_NODE_COUNT):
		var new_x = rng.randf_range(MIN_X, MAX_X)
		var new_y = rng.randf_range(MIN_Y, MAX_Y)
		var new_location = Vector2(new_x, new_y)
		
		var closest_node = map_state.find_closest_node(new_location)
		if closest_node != null && closest_node.get_distance(new_location) < MIN_DISTANCE_TO_NODE:
			continue
			
		MapNode.spawn_node(new_location, map_state)
		
func generate_edges(map_state: MapState):
	var nodes = map_state.nodes
	var deletable_nodes: Array[MapNode] = []
	
	for node in nodes:
		var node_edge_count = node.edges.size()
		var edgest_to_be_placed = rng.randi_range(MIN_EDGES - node_edge_count, MAX_EDGES - node_edge_count)
		
		var closest_nodes = map_state.get_nodes_in_distance_order(node.position)
		var node_candidates := closest_nodes.slice(0, MAX_NODE_LOOKUP)
		while edgest_to_be_placed > 0 and !node_candidates.is_empty():
			var node_candidate = node_candidates.pick_random()
			node_candidates.erase(node_candidate)
			
			if map_state.intersects_with_any_other_edge(node.position, node_candidate.position):
				continue
				
			if map_state.find_closest_distance_to_edge(node, node_candidate) < MIN_DISTANCE_TO_EDGE:
				continue
			
			if node.add_edge(node_candidate):
				edgest_to_be_placed -= 1
		
		if node.edges.size() == 0:
			deletable_nodes.append(node)
	
	for deletable_node in deletable_nodes:
		deletable_node.delete_node(map_state)

func spawn_players(map_state: MapState):
	var player = AssetsPreload.PLAYER_SHROOM_NODE.instantiate()
	add_child(player)
	init_player(map_state, player, Vector2(MIN_X - 100, 0), Enums.Owner.PLAYER)
	
	var enemy = AssetsPreload.ENEMY_SHROOM_NODE.instantiate()
	add_child(enemy)
	init_player(map_state, enemy, Vector2(MAX_X + 100, 0), Enums.Owner.ENEMY)
	
func init_player(map_state: MapState, shroom_object, spawn_position: Vector2, player_owner):
	shroom_object.position = spawn_position
	shroom_object.closest_node = map_state.find_closest_node(shroom_object.position)
	shroom_object.node = MapNode.spawn_node(shroom_object.position, map_state)
	shroom_object.node.add_edge(shroom_object.closest_node)
	shroom_object.node.belongs_to = player_owner
