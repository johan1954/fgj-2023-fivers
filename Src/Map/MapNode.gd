extends Node2D

class_name MapNode

enum NodeTypes {NORMAL, TREE}

var type: int = NodeTypes.NORMAL
var edges = []

func get_distance(other_position: Vector2):
	return position.distance_to(other_position)

func add_edge(other_node: MapNode):
	if has_edge(other_node):
		return false
	
	var edge = MapEdge.new()
	edges.append(edge)
	other_node.edges.append(edge)
	
	return true

func has_edge(other_node: MapNode):
	for edge in edges:
		if edge.get_other_node(self) == other_node:
			return true
	return false
