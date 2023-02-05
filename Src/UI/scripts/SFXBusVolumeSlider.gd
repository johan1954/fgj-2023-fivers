extends HSlider

func _ready() -> void:
	value = db_to_linear(AudioServer.get_bus_volume_db(GameEngine._sfx_volume_bus))
	set_value_no_signal(value)
	connect("value_changed", Callable(self,"_on_value_changed") )
	print(value)


func _on_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(GameEngine._sfx_volume_bus, linear_to_db(value))
