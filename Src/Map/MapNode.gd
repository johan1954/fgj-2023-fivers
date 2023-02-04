extends Node2D
class_name MapNode

enum NodeTypes {NORMAL, TREE}

var type: int = NodeTypes.NORMAL
var edges: Array[MapEdge]
var rng = RandomNumberGenerator.new()

var belongs_to := Enums.Owner.NONE

func get_distance(other_position: Vector2) -> float:
	return position.distance_to(other_position)

func add_edge(other_node: MapNode) -> bool:
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

func has_edge(other_node: MapNode) -> bool:
	for edge in edges:
		if edge.get_other_node(self) == other_node:
			return true
	return false
	

	
func _init():
	rng.randomize()

func _process(delta):
	if belongs_to == Enums.Owner.PLAYER:
		modulate = Color.GREEN
	elif belongs_to == Enums.Owner.ENEMY:
		modulate = Color.RED
	else: 
		modulate = Color.WHITE
