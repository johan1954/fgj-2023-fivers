extends Node

#func _ready():
#	AudioServer.playback_speed_scale = 2.0

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			GlobalAudio.playSoundEffect()
			var map = get_node("/root/Map")
			for child in map.get_children():
				child.queue_free()
			
			print("Kiitos ohjelman käytöstä!")
			get_tree().quit()
#			get_tree().change_scene_to_file("res://MainMenu.tscn")

var map_generator : MapGenerator
var map_state : MapState

const CONTROL_TIME = 20
const DRAFT_TIMER = 3

var player_growth_speed = 20
var enemy_growth_speed = -10

var player_damage_output = 0
var enemy_damage_output = 10

var _main_volume_bus := AudioServer.get_bus_index("Master")
var _music_volume_bus := AudioServer.get_bus_index("Music")
var _sfx_volume_bus := AudioServer.get_bus_index("SFX")



func start_game():
	
	map_generator = MapGenerator.new()
	map_state = map_generator.generate_map()

#	var new_card_button = AssetsPreload.CARD_BUTTON_NODE.instantiate()
#	Map.add_child(new_card_button)
#	new_card_button = AssetsPreload.CARD_BUTTON_NODE.instantiate()
#	new_card_button.message = "Test 1"
#	new_card_button.z_index = 1
#	new_card_button.console_print()
#	Map.add_child(new_card_button)
#	new_card_button.position = Vector2(-50, -50)
#	new_card_button.message = "Test 2"
#	new_card_button.console_print()
	
func get_card_manager():
	return get_node("/root/Scene/GlobalScripts/CardManager")
