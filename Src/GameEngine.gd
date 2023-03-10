extends Node

#func _ready():
#	AudioServer.playback_speed_scale = 5.0

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

func alert(alert_text: String, title: String='Message') -> void:
	var dialog = AcceptDialog.new()
	dialog.dialog_text = alert_text
	dialog.add_cancel_button ("Cancel")
	dialog.title = title
	dialog.ok_button_text = "Yes"
	dialog.set_script(load("res://Src/UI/scripts/exitGameConfirmationDialog.gd"))
	dialog.connect("confirmed", Callable(dialog,'delete_all'))
	add_child(dialog,true)
	dialog.popup_centered()



func _unhandled_input(event):
	if event is InputEventKey:
		#print("InputEventKey ar den ", event.keycode)
		if event.pressed and event.keycode == KEY_ESCAPE:
			alert("Are you sure you want to quit game", "Quit game?")
			#get_tree().quit()
#			get_tree().change_scene_to_file("res://MainMenu.tscn")

		#Easter eggs. Speed up music volume and increase volume
		elif event.pressed and event.keycode == 39:
			AudioServer.playback_speed_scale = 5.0
		elif event.pressed and event.keycode == 96:
			AudioServer.set_bus_volume_db(_music_volume_bus, linear_to_db(20))
		elif event.pressed and event.keycode == 93:
			#Remove easter egg effectsd
			AudioServer.playback_speed_scale = 1.0
			AudioServer.set_bus_volume_db(_music_volume_bus, linear_to_db(1))



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
