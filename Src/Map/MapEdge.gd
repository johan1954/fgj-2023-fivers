extends Line2D

class_name MapEdge

var map_node_1: MapNode
var map_node_2: MapNode

var health: float = 0

func get_other_node(map_node: MapNode):
	if map_node == map_node_1:
		return map_node_2
	else:
		return map_node_1
