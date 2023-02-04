extends Node2D
class_name MapNode

enum NodeTypes {NORMAL, TREE}

var type: int = NodeTypes.NORMAL
var edges = []

func get_distance(other_position: Vector2):
	return position.distance_to(other_position)

func has_edge(other_node: MapNode):
	for edge in edges:
		if edge.get_other_node(self) == other_node:
			return true
	return false
