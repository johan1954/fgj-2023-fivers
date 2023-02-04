extends Node

const DESIRED_NODE_COUNT = 100
const MIN_X = -300
const MAX_X = 300
const MIN_Y = -300
const MAX_Y = 300
const MIN_DISTANCE = 50
const MIN_EDGES = 3
const MAX_EDGES = 5
const MAX_NODE_LOOKUP = 10

var rng = RandomNumberGenerator.new()
func _ready():
	generate_map()
	
func generate_map() -> MapState:
	var map_state = MapState.new()
	rng.randomize()
	
	generate_nodes(map_state)
	generate_edges(map_state)
	spawn_players()
	
	return map_state
		
func generate_nodes(map_state: MapState):
	var generated_nodes = 0
	while (generated_nodes < DESIRED_NODE_COUNT):
		var new_x = rng.randf_range(MIN_X, MAX_X)
		var new_y = rng.randf_range(MIN_Y, MAX_Y)
		var new_location = Vector2(new_x, new_y)
		
		var closest_node = map_state.find_closest_node(new_location)
		if closest_node != null && closest_node.get_distance(new_location) < MIN_DISTANCE:
			continue
			
		spawn_node(new_location)	
		generated_nodes += 1

func spawn_node(spawn_location: Vector2):
	var new_node = AssetsPreload.MAP_NODE_NODE.instantiate()
	Map.add_child(new_node)
	new_node.position = spawn_location
	map_state.nodes.append(new_node)
	return new_node
		
func generate_edges():
	var nodes = map_state.nodes
	
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
			
			if node.add_edge(node_candidate):
				edgest_to_be_placed -= 1

func spawn_players():
	var player = AssetsPreload.PLAYER_SHROOM_NODE.instantiate()
	add_child(player)
	init_player(player, Vector2(MIN_X - 100, 0), Enums.Owner.PLAYER)
	
	var enemy = AssetsPreload.ENEMY_SHROOM_NODE.instantiate()
	add_child(enemy)
	init_player(enemy, Vector2(MAX_X + 100, 0), Enums.Owner.ENEMY)
	
func init_player(shroom_object, spawn_position: Vector2, owner):
	shroom_object.position = spawn_position
	shroom_object.closest_node = map_state.find_closest_node(shroom_object.position)[0]
	shroom_object.node = spawn_node(shroom_object.position)
	shroom_object.node.add_edge(shroom_object.closest_node)
	shroom_object.node.belongs_to = owner
