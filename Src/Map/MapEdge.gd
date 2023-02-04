extends Line2D

class_name MapEdge

var map_node_1: MapNode
var map_node_2: MapNode

var health: float = 0

func get_other_node(map_node: MapNode) -> MapNode:
	if map_node == map_node_1:
		return map_node_2
	else:
		return map_node_1

func intersect_with(C: Vector2, D: Vector2) -> bool:
	var A := points[0]
	var B := points[1]
	return ccw(A, C, D) != ccw(B, C, D) and ccw(A, B, C) != ccw(A, B, D)
	
func ccw(A: Vector2, B: Vector2, C: Vector2) -> bool:
	return (C.y - A.y) * (B.x - A.x) > (B.y - A.y) * (C.x - A.x)
