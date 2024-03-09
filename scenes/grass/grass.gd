extends Sprite2D

signal pulled

var target_pull_distance = 2400
var is_pulling := false
var pulled_distance := 0.0
var mouse_position_last_frame: Vector2

func _input(event):
	if Input.is_action_just_pressed("click"):
		var mouse_positon = get_viewport().get_mouse_position()
		const PULL_MARGIN = 80
		if (mouse_positon - position).length() < PULL_MARGIN:
			is_pulling = true
			pulled_distance = 0.0
			mouse_position_last_frame = mouse_positon
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
		rotation = clamp(horizontal_distance_to_mouse / 400, -1.3, 1.3)
		
		var distance_to_mouse :=  mouse_position - position
		scale.y = clamp(.5 + distance_to_mouse.length() / 200, .5, 2)
		scale.x = clamp(1 - distance_to_mouse.length() / 500, .2, 3)
		
		modulate.r = pulled_distance / target_pull_distance * 2
		if pulled_distance > target_pull_distance:
			pulled.emit()
			queue_free()