extends Line2D

class_name MapEdge

var map_node_1: MapNode
var map_node_2: MapNode
var text_label: RichTextLabel

var control: float = 0
var belongs_to = Enums.Owner.NONE

func get_other_node(map_node: MapNode) -> MapNode:
	if map_node == map_node_1:
		return map_node_2
	else:
		return map_node_1

func handle_attack(control_delta: float):
	if (belongs_to == Enums.Owner.NONE):
		return false
		
	if (belongs_to == Enums.Owner.PLAYER):
		if (control_delta > 0):
			return false
		if map_node_1.belongs_to == Enums.Owner.ENEMY:
			map_node_1.attacker = Enums.Owner.PLAYER
		if map_node_2.belongs_to == Enums.Owner.ENEMY:
			map_node_2.attacker = Enums.Owner.PLAYER
	
	if (belongs_to == Enums.Owner.ENEMY):
		if (control_delta < 0):
			return false
		if map_node_1.belongs_to == Enums.Owner.PLAYER:
			map_node_1.attacker = Enums.Owner.ENEMY
		if map_node_2.belongs_to == Enums.Owner.PLAYER:
			map_node_2.attacker = Enums.Owner.ENEMY
	return true

func capture(control_delta: float):
	
	if (control_delta > 0 && control < GameEngine.CONTROL_TIME):
		control += control_delta
	if (control_delta < 0 && control > -GameEngine.CONTROL_TIME):
		control += control_delta
	
	default_color = lerp(Color.RED, Color.GREEN, get_balanced_weight(control))
	text_label.text = str(round(control))

	if control > GameEngine.CONTROL_TIME:
		if (map_node_1.belongs_to == Enums.Owner.ENEMY):
			map_node_1.attacker = Enums.Owner.PLAYER
		elif (map_node_1.belongs_to == Enums.Owner.NONE):
			change_ownership(map_node_1, Enums.Owner.PLAYER)
		if (map_node_2.belongs_to == Enums.Owner.ENEMY):
			map_node_2.attacker = Enums.Owner.PLAYER
		elif (map_node_2.belongs_to == Enums.Owner.NONE):
			change_ownership(map_node_2, Enums.Owner.PLAYER)
		return
	
	if control < -GameEngine.CONTROL_TIME:		
		if (map_node_1.belongs_to == Enums.Owner.PLAYER):
			map_node_1.attacker = Enums.Owner.ENEMY
		elif (map_node_1.belongs_to == Enums.Owner.NONE):
			change_ownership(map_node_1, Enums.Owner.ENEMY)
		if (map_node_2.belongs_to == Enums.Owner.PLAYER):
			map_node_2.attacker = Enums.Owner.ENEMY
		elif (map_node_2.belongs_to == Enums.Owner.NONE):
			change_ownership(map_node_2, Enums.Owner.ENEMY)
		return
		
func change_ownership(node, new_owner):
	node.capture_node(new_owner)

func init_text():
	if (text_label == null):
		text_label = get_node("RichTextLabel")
		text_label.position = lerp(points[0], points[1], 0.5)
	text_label.text="0"
		
func get_balanced_weight(health):
	return (health + GameEngine.CONTROL_TIME) / (GameEngine.CONTROL_TIME * 2)
	
func neutralize_edge():
	control = 0

func intersect_with(C: Vector2, D: Vector2) -> bool:
	var A := points[0]
	var B := points[1]
	return ccw(A, C, D) != ccw(B, C, D) and ccw(A, B, C) != ccw(A, B, D)
	
func ccw(A: Vector2, B: Vector2, C: Vector2) -> bool:
	return (C.y - A.y) * (B.x - A.x) > (B.y - A.y) * (C.x - A.x)
