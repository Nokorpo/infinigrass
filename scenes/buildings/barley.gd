extends Node2D

signal instantiated
signal cancel_instantiation

@export_category("Visuals")
@export var sprite_on_spawn: Texture2D
@export var sprite_on_completed: Texture2D
@export_category("Resources")
@export var resource: ResourcesManager.GameResourceType
@export var amount: int = 1
@export var time_until_done := 1.0

var finished := false
var is_instantiated := false
var is_picked_up := false

func _ready() -> void:
	$Timer.start(time_until_done)
	$Sprite2D.texture = sprite_on_spawn

func _process(_delta):
	if !is_instantiated:
		var mouse_position = get_viewport().get_mouse_position()
		position = mouse_position
		modulate = Color("ffffff")
		if !can_be_placed():
			modulate = Color("ffa092")

func _on_timer_timeout() -> void:
	$Sprite2D/AnimationPlayer.play("ready")
	$Sprite2D.texture = sprite_on_completed
	finished = true

func _input(event: InputEvent) -> void:
	if is_picked_up:
		return
	if !is_instantiated and Input.is_action_just_released("click"):
		if can_be_placed():
			$Timer.start()
			is_instantiated = true
			self.modulate = Color("ffffff")
			top_level = false
			instantiated.emit()
			$SpawnSound.play(0)
		else:
			cancel_instantiation.emit()
			queue_free()
	if finished and is_left_click(event) and is_mouse_inside():
		ResourcesManager.add_resource(amount, resource)
		get_viewport().set_input_as_handled()
		pickup()
		$SpawnSound.play(0)

func pickup():
	is_picked_up = true
	$CPUParticles2D.emitting = true
	var tween: Tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property($Sprite2D, "modulate", Color("ffffff", 0), .2)
	tween.tween_property($Shadow, "modulate", Color("ffffff", 0), .2)
	await get_tree().create_timer(1).timeout
	queue_free()

func can_be_placed():
	if position.x > 775 or position.x < 25\
		or position.y > 620 or position.y < 30:
		return false
	return true

func is_mouse_inside():
	return $Sprite2D.get_rect().has_point(to_local(get_global_mouse_position()))

func is_left_click(event: InputEvent):
	return event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed
