extends Button

@export var upgrade_type: UpgradesManager.UpgradeTypes
@export var resource: ResourcesManager.GameResourceType
var is_upgrade_max: bool
var tooltip_tween: Tween

func _ready():
	on_resource_changed()
	$Tooltip/Price.set_texture(resource)
	ResourcesManager.resource_changed.connect(on_resource_changed)

func on_resource_changed():
	if is_upgrade_max:
		$Tooltip/Price.set_price("MAX")
	else:
		$Tooltip/Price.set_price(get_current_cost())
	if ResourcesManager.get_resource_quantity(resource) < get_current_cost()\
		and !is_upgrade_max:
		disabled = true
		$TextureRect.modulate = Color(0, 0, 0, .6)
	else:
		disabled = false
		$TextureRect.modulate = Color.WHITE

func get_current_cost() -> int:
	if upgrade_type == UpgradesManager.UpgradeTypes.PRUNER:
		return %UpgradesManager.get_next_pruner().upgrade_cost
	else:
		return %UpgradesManager.get_next_fertilizer().upgrade_cost

func _on_mouse_entered():
	if tooltip_tween != null:
		tooltip_tween.kill()
	tooltip_tween = create_tween().set_trans(Tween.TRANS_SINE)
	tooltip_tween.tween_property($Tooltip, "modulate", Color("ffffff", 1), .2)

func _on_mouse_exited():
	if tooltip_tween != null:
		tooltip_tween.kill()
	tooltip_tween = create_tween().set_trans(Tween.TRANS_SINE)
	tooltip_tween.tween_property($Tooltip, "modulate", Color("ffffff", 0), .2)
