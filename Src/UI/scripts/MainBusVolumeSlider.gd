extends HSlider

func _ready() -> void:
	print(AudioServer.get_bus_volume_db(GameEngine._main_volume_bus) )
	
	var currentValue = db_to_linear(AudioServer.get_bus_volume_db(GameEngine._main_volume_bus))
	set_value_no_signal(currentValue)
	connect("value_changed", Callable(self,"_on_value_changed") )
	print(value)


func _on_value_changed(value: float) -> void:
	print("_main_volume_bus", value)
	AudioServer.set_bus_volume_db(GameEngine._main_volume_bus, linear_to_db(value))
