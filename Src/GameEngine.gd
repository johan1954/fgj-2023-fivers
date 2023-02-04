extends Node


func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			get_tree().change_scene_to_file("res://MainMenu.tscn")
			print(get_tree().get_current_scene()) 
			#get_tree().change_scene_to_file("res://MainMenu.tscn")


var map_generator : MapGenerator

const CAPTURE_THRESHOLD = 20

var player_growth_speed = 10
var enemy_growth_speed = -5

var player_damage_output = 0
var enemy_damage_output = 5

func start_game():
	map_generator = MapGenerator.new()
	map_generator.generate_map()

	var new_card_button = AssetsPreload.CARD_BUTTON_NODE.instantiate()
	Map.add_child(new_card_button)
	new_card_button = AssetsPreload.CARD_BUTTON_NODE.instantiate()
	new_card_button.message = "Test 1"
	new_card_button.console_print()
	Map.add_child(new_card_button)
	new_card_button.position = Vector2(-50, -50)
	new_card_button.message = "Test 2"
	new_card_button.console_print()
	
