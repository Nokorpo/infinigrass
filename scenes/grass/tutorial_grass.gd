extends Grass

func _ready() -> void:
	pulled.connect(on_tutorial_grass_pulled)
	var timer = get_tree().create_timer(2)
	timer.timeout.connect(func(): $Sprite2D/AnimationPlayer.play("tutorial_grab"))
	super._ready()

func _input(event):
	if is_pulled:
		return
	if !is_pulling and event is InputEventMouseMotion:
		if can_pull(event.position):
			_on_mouse_entered()
		else:
			_on_mouse_exited()
	if Input.is_action_just_pressed("click"):
		var mouse_positon = get_viewport().get_mouse_position()
		if can_pull(mouse_positon):
			is_pulling = true
			pulled_distance = 0.0
			mouse_position_last_frame = mouse_positon
			$Grass/AnimationPlayer.stop()

func on_tutorial_grass_pulled() -> void:
	queue_free()
