extends Node

var map_generator : MapGenerator

const CAPTURE_THRESHOLD = 20

var player_growth_speed = 10
var enemy_growth_speed = -5

var player_damage_output = 0
var enemy_damage_output = 5

func start_game():
	map_generator = MapGenerator.new()
	map_generator.generate_map()
	
