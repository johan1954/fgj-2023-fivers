extends Camera2D

const CAMERA_MIN_X = -356
const CAMERA_MAX_X = 356
const CAMERA_MIN_Y = -200
const CAMERA_MAX_Y = 200
const ZOOM_SPEED = 0.05


var mouse_start_pos: Vector2
var screen_start_position: Vector2

var dragging = false
var fullscreen = false

func _input(event: InputEvent):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			if event.pressed:
				mouse_start_pos = event.position
				screen_start_position = position
				dragging = true
			else:
				dragging = false
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			#print("MOUSE_BUTTON_WHEEL_UP", zoom)
			zoom += Vector2(ZOOM_SPEED, ZOOM_SPEED)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			#print("MOUSE_BUTTON_WHEEL_DOWN", zoom)
			if zoom.x >= 0.79 or zoom.y >= 0.79:
				zoom -= Vector2(ZOOM_SPEED, ZOOM_SPEED)
			
			
	if event is InputEventMouseMotion and dragging:
		var new_position = (mouse_start_pos - event.position) / zoom + screen_start_position
		if new_position.x < CAMERA_MIN_X:
			new_position.x = CAMERA_MIN_X
		if new_position.x > CAMERA_MAX_X:
			new_position.x = CAMERA_MAX_X
		if new_position.y < CAMERA_MIN_Y:
			new_position.y = CAMERA_MIN_Y
		if new_position.y > CAMERA_MAX_Y:
			new_position.y = CAMERA_MAX_Y
		position = new_position

	if event is InputEventKey and event.pressed and event.physical_keycode == KEY_F11:
		fullscreen = !fullscreen
		if fullscreen:
			DisplayServer.window_set_mode(Window.MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(Window.MODE_WINDOWED)
