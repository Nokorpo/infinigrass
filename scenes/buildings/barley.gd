extends Node2D

signal instantiated

@export_category("Visuals")
@export var sprite_on_spawn: Texture2D
@export var sprite_on_completed: Texture2D
@export_category("Resources")
@export var resource: ResourcesManager.GameResourceType
@export var amount: int = 1
@export var time_until_done := 1.0

var finished := false
var is_instantiated := false

func _ready() -> void:
	$Timer.start(time_until_done)
	$Sprite2D.texture = sprite_on_spawn

func _process(delta):
	if !is_instantiated:
			var mouse_position = get_viewport().get_mouse_position()
			position = mouse_position
			modulate = Color("ffffff")
			if !can_be_placed():
				modulate = Color("ffa092")

func can_be_placed():
	if position.x > 775 or position.x < 25\
		or position.y > 620 or position.y < 30:
		return false
	return true

func _on_timer_timeout() -> void:
	$Sprite2D.texture = sprite_on_completed
	finished = true

func _input(event: InputEvent) -> void:
	if !is_instantiated and Input.is_action_just_released("click"):
		if can_be_placed():
			$Timer.start()
			is_instantiated = true
			self.modulate = Color("ffffff")
			instantiated.emit()
		else:
			queue_free()
	if finished and is_left_click(event) and is_mouse_inside():
		ResourcesManager.add_resource(amount, resource)
		get_viewport().set_input_as_handled()
		queue_free()

func is_mouse_inside():
	return $Sprite2D.get_rect().has_point(to_local(get_global_mouse_position()))

static func is_left_click(event: InputEvent):
	return event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed
