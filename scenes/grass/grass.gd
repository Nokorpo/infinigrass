extends Sprite2D

const TARGET_PULL_DISTANCE = 200

var is_pulling := false
var pulled_distance := 0.0
var mouse_position_last_frame: Vector2

func _input(event):
	if Input.is_action_just_pressed("click"):
		is_pulling = true
		pulled_distance = 0.0
		mouse_position_last_frame = get_viewport().get_mouse_position()
	elif Input.is_action_just_released("click"):
		is_pulling = false
		modulate.r = 1
		rotation = 0
		scale.y = 1
		scale.x = 1

func _process(delta):
	if is_pulling:
		var mouse_position := get_viewport().get_mouse_position()
		var distance_this_frame: Vector2 = mouse_position_last_frame - mouse_position
		pulled_distance += distance_this_frame.length()
		mouse_position_last_frame = mouse_position
		
		var horizontal_distance_to_mouse := mouse_position.x - position.x
		rotation = horizontal_distance_to_mouse / 400
		
		var distance_to_mouse :=  mouse_position - position
		scale.y = .5 + distance_to_mouse.length() / 200
		scale.x = 1 - distance_to_mouse.length() / 500
		
		modulate.r = pulled_distance / 2000
