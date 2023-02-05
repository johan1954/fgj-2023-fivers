extends Node2D
class_name MapNode

enum NodeTypes {NORMAL, TREE}

var type: int = NodeTypes.NORMAL
var edges: Array[MapEdge]
var rng = RandomNumberGenerator.new()
var health : float
var attacker = Enums.Owner.NONE

var belongs_to := Enums.Owner.NONE

func _init():
	rng.randomize()
	
static func spawn_node(spawn_location: Vector2, map_state: MapState) -> MapNode:
	var new_node = AssetsPreload.MAP_NODE_NODE.instantiate()
	
	Map.add_child(new_node)
	new_node.position = spawn_location
	map_state.nodes.append(new_node)
	return new_node

func delete_node(map_state: MapState):
	Map.remove_child(self)
	map_state.nodes.erase(self)

func get_distance(other_position: Vector2) -> float:
	return position.distance_to(other_position)
	
func get_node_type():
	pass
	

func add_edge(other_node: MapNode) -> bool:
	if has_edge(other_node):
		return false
	
	var edge: MapEdge = AssetsPreload.MAP_EDGE_NODE.instantiate()
	Map.add_child(edge)
	edge.map_node_1 = self
	edge.map_node_2 = other_node
	edge.points = [position, other_node.position]
	# edge.init_text()
	
	edges.append(edge)
	other_node.edges.append(edge)
	
	return true

func has_edge(other_node: MapNode) -> bool:
	for edge in edges:
		if edge.get_other_node(self) == other_node:
			return true
	return false
	
func edge_distance_to_self(p1: Vector2, p2: Vector2) -> float:
	var p3 = position
	var l2 = p1.distance_squared_to(p2)
	var p3_p1 = p3 - p1
	var p2_p1 = p2 - p1
	var t = max(0, min(1, p3_p1.dot(p2_p1) / l2))
	var projection = p1 + t * (p2 - p1)
	
	return p3.distance_to(projection)
	
func capture_node(new_owner: Enums.Owner):
	belongs_to = new_owner
	health = 20
	capture_all_edges(new_owner)
	
func capture_all_edges(new_owner):
	for i in edges:
		if (i.belongs_to == new_owner):
			continue
		if (i.belongs_to == Enums.Owner.NONE):
			i.belongs_to = new_owner
		if (i.belongs_to == Enums.Owner.PLAYER):
			i.belongs_to = new_owner
			i.control = 0
		if (i.belongs_to == Enums.Owner.ENEMY):
			if (GameEngine.player_damage_output > 0):
				i.belongs_to = new_owner
				i.control = 0
			continue

func _process(delta):
	if (attacker != Enums.Owner.NONE):
		handle_attack(delta)
		return
	
	if belongs_to == Enums.Owner.PLAYER:
		for i in edges:
			if (i.belongs_to == belongs_to):
				i.capture(GameEngine.player_growth_speed * delta)
		modulate = Color.GREEN
		
	elif belongs_to == Enums.Owner.ENEMY:
		for i in edges:
			if (i.belongs_to == belongs_to):
				i.capture(GameEngine.enemy_growth_speed * delta)
			elif i.belongs_to == Enums.Owner.PLAYER:
				if (i.control > GameEngine.CONTROL_TIME):
					i.capture(GameEngine.enemy_growth_speed * delta)
		modulate = Color.RED
	else: 
		modulate = Color.WHITE

func handle_attack(delta):
	if (attacker == Enums.Owner.ENEMY):
		health -= GameEngine.enemy_damage_output * delta
		# print("Attack! New health:" + str(health))
		
	if (attacker == Enums.Owner.PLAYER):
		health -= GameEngine.player_damage_output * delta
	
	if (health < 0):
		capture_node(attacker)
		attacker = Enums.Owner.NONE
	
	
