extends Node2D

@export_category("Visuals")
@export var sprite_on_spawn: Texture2D
@export var sprite_on_completed: Texture2D
@export_category("Resources")
@export var resource: ResourcesManager.GameResourceType
@export var amount: int = 1
@export var time_until_done := 1.0

var finished := false

func _ready() -> void:
	$Timer.start(time_until_done)
	$Sprite2D.texture = sprite_on_spawn

func _on_timer_timeout() -> void:
	$Sprite2D.texture = sprite_on_completed
	finished = true

func _input(event: InputEvent) -> void:
	if finished and is_left_click(event) and is_mouse_inside():
		ResourcesManager.add_resource(amount, resource)
		get_viewport().set_input_as_handled()
		queue_free()

func is_mouse_inside():
	return $Sprite2D.get_rect().has_point(get_global_mouse_position())

static func is_left_click(event: InputEvent):
	return event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed
