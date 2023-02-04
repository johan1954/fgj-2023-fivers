extends Node2D
class_name MapNode

enum NodeTypes {NORMAL, TREE}
var type: int = NodeTypes.NORMAL
var edges: Array[MapEdge]

func get_distance(other_position: Vector2):
	return position.distance_to(other_position)

func add_edge(other_node: MapNode):
	if has_edge(other_node):
		return false
	
	var edge: MapEdge = AssetsPreload.MAP_EDGE_NODE.instantiate()
	add_child(edge)
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
	belongsTo = rng.randi_range(0,3)

func _process(delta):
	if belongsTo == Owner.PLAYER:
		modulate = Color.green
	elif belongsTo == Owner.ENEMY:
		modulate = Color.red
	else: 
		modulate = Color.white
