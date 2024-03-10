extends Node2D

signal instantiated

@export_category("Resource")
@export var resource: ResourcesManager.GameResourceType
@export var amount: int = 1
@export var time_until_completion: float = 1.0
var is_instantiated := false

func _ready() -> void:
	$Timer.start(time_until_completion)

func _process(delta):
	if !is_instantiated:
		var mouse_position = get_viewport().get_mouse_position()
		position = mouse_position
		modulate = Color("ffffff")
		if !can_be_placed():
			modulate = Color("ffa092")

func _input(event):
	if !is_instantiated and Input.is_action_just_released("click"):
		if can_be_placed():
			$Timer.start()
			is_instantiated = true
			self.modulate = Color("ffffff")
			instantiated.emit()
		else:
			queue_free()

func _on_timer_timeout() -> void:
	ResourcesManager.add_resource(amount, resource)

func can_be_placed():
	if position.x > 775 or position.x < 25\
		or position.y > 620 or position.y < 30:
		return false
	return true
