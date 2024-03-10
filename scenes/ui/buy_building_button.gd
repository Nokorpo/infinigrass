extends Button

@export_file("*.tscn") var gameplay_item
@export var resource: ResourcesManager.GameResourceType
@export var cost: int = 100
var tooltip_tween: Tween

func _ready():
	on_resource_changed()
	ResourcesManager.resource_changed.connect(on_resource_changed)

func _on_button_down():
	if can_buy_item():
		ResourcesManager.subtract_resource(cost, resource)
		var this_item = load(gameplay_item).instantiate()
		%Grasses.add_child(this_item)

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

func on_resource_changed():
	if can_buy_item():
		disabled = false
		$TextureRect.modulate = Color.WHITE
	else:
		disabled = true
		$TextureRect.modulate = Color(0, 0, 0, .6)

func can_buy_item():
	return ResourcesManager.get_resource_quantity(resource) >= cost
