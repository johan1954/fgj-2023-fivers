extends Node

class Card:
	var title: String
	var description: String
	var cardEffect: 
	
	func _init(title, speedIncrease):
		self.title = title
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	var drawnCard = Card.new("MY CARD", rng.randf_range(0,5))

func DrawCars():
	var drawnCard = Card.new("MY CARD", rng.randf_range(0,5))
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
