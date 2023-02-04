extends Line2D

class_name MapEdge

var map_node_1: MapNode
var map_node_2: MapNode
var text_label: RichTextLabel

var health: float = 0

func get_other_node(map_node: MapNode) -> MapNode:
	if map_node == map_node_1:
		return map_node_2
	else:
		return map_node_1

func capture(health_delta: float):
	
	health += health_delta
	
	default_color = lerp(Color.RED, Color.GREEN, (health+100)/200)
	text_label.text = str(round(health))
	
	if (health >= GameEngine.CAPTURE_THRESHOLD):
		map_node_1.belongs_to = Enums.Owner.PLAYER
		map_node_2.belongs_to = Enums.Owner.PLAYER
		
	elif (health <= -GameEngine.CAPTURE_THRESHOLD):
		map_node_1.belongs_to = Enums.Owner.ENEMY
		map_node_2.belongs_to = Enums.Owner.ENEMY
		
func init_text():
	if (text_label == null):
		text_label = get_node("RichTextLabel")
		text_label.position = lerp(points[0], points[1], 0.5)
	text_label.text="0"
		
func get_balanced_weight():
	pass

func intersect_with(C: Vector2, D: Vector2) -> bool:
	var A := points[0]
	var B := points[1]
	return ccw(A, C, D) != ccw(B, C, D) and ccw(A, B, C) != ccw(A, B, D)
	
func ccw(A: Vector2, B: Vector2, C: Vector2) -> bool:
	return (C.y - A.y) * (B.x - A.x) > (B.y - A.y) * (C.x - A.x)
