extends Node

var map_generator : MapGenerator

const CAPTURE_THRESHOLD = 20

var player_growth_speed = 10
var enemy_growth_speed = -5



func _ready():
	map_generator = MapGenerator.new()
	map_generator.generate_map()
	



