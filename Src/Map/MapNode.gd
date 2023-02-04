extends Node2D
class_name MapNode

enum NodeTypes {NORMAL, TREE}
enum Owner {NONE, PLAYER, ENEMY}

var type: int = NodeTypes.NORMAL
var edges: Array[MapEdge]
var rng = RandomNumberGenerator.new()

var belongs_to := Owner.NONE

func get_distance(other_position: Vector2):
	return position.distance_to(other_position)

func add_edge(other_node: MapNode):
	if has_edge(other_node):
		return false
	
	var edge: MapEdge = AssetsPreload.MAP_EDGE_NODE.instantiate()
	Map.add_child(edge)
	edge.map_node_1 = self
	edge.map_node_2 = other_node
	edge.points = [position, other_node.position]
	edges.append(edge)
	other_node.edges.append(edge)
	
	return true

func has_edge(other_node: MapNode):
	for edge in edges:
		if edge.get_other_node(self) == other_node:
			return true
	return false

func _init():
	rng.randomize()
	belongs_to = rng.randi_range(0,3)

func _process(delta):
	if belongs_to == Owner.PLAYER:
		modulate = Color.GREEN
	elif belongs_to == Owner.ENEMY:
		modulate = Color.RED
	else: 
		modulate = Color.WHITE
