extends Node2D

@export_category("Visuals")
@export var sprite_on_idle: Texture2D
@export var sprite_on_working: Texture2D
@export var sprite_on_done: Texture2D
@export_category("Resources generated")
@export var resource: ResourcesManager.GameResourceType
@export var amount: int = 1
@export var time_until_done := 1.0
@export_category("Resources consumed by recharge")
@export var recharge_resource: ResourcesManager.GameResourceType
@export var recharge_amount: int = 1

enum LaborStates { IDLE, WORKING, DONE}
var state: LaborStates = LaborStates.IDLE

func _ready() -> void:
	$Sprite2D.texture = sprite_on_idle

func _input(event: InputEvent) -> void:
	if is_left_click(event) and is_mouse_inside():
		match state:
			LaborStates.IDLE:
				ResourcesManager.add_resource(recharge_amount, recharge_resource)
				$Timer.start(time_until_done)
				$Sprite2D.texture = sprite_on_working
				get_viewport().set_input_as_handled()
			LaborStates.DONE:
				ResourcesManager.add_resource(amount, resource)
				state = LaborStates.IDLE
				$Sprite2D.texture = sprite_on_idle
				get_viewport().set_input_as_handled()

func is_mouse_inside():
	return $Sprite2D.get_rect().has_point(to_local(get_global_mouse_position()))

static func is_left_click(event: InputEvent):
	return event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed

func _on_timer_timeout() -> void:
	state = LaborStates.DONE
	$Sprite2D.texture = sprite_on_done
