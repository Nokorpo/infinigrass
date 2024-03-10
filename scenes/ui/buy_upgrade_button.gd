extends Button

@export var resource: ResourcesManager.GameResourceType
var is_upgrade_max: bool

func _ready():
	on_money_changed()
	ResourcesManager.money_changed.connect(on_money_changed)

func on_money_changed():
	if ResourcesManager.money < get_current_cost() and !is_upgrade_max:
		disabled = true
		$TextureRect.modulate = Color(0, 0, 0, .6)
	else:
		disabled = false
		$TextureRect.modulate = Color.WHITE

func get_current_cost() -> int:
	return %UpgradesManager.get_next_pruner().upgrade_cost
