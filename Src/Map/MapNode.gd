extends Node2D
class_name MapNode

enum NodeTypes {NORMAL, TREE}
var type: int = NodeTypes.NORMAL

enum Owner {NONE, PLAYER, ENEMY}
var belongsTo = Owner.NONE

var edges = []
var rng = RandomNumberGenerator.new()

func get_distance(other_position: Vector2):
	return position.distance_to(other_position)

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
