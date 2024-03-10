extends Node2D

@export_category("Resource")
@export var resource: ResourcesManager.GameResourceType
@export var amount: int = 1
@export var time_until_completion: float = 1.0

func _ready() -> void:
	$Timer.start(time_until_completion)

func _on_timer_timeout() -> void:
	ResourcesManager.add_resource(amount, resource)
