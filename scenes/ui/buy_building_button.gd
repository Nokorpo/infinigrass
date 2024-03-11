extends Button

@export_file("*.tscn") var gameplay_item
@export var resource: ResourcesManager.GameResourceType
@export var cost: int = 100
var tooltip_tween: Tween
var item_to_spawn: PackedScene

func _ready():
	item_to_spawn = load(gameplay_item)
	on_resource_changed()
	$Tooltip/Price.set_texture(resource)
	$Tooltip/Price.set_price(cost)
	ResourcesManager.resource_changed.connect(on_resource_changed)

func _on_button_down():
	if can_buy_item():
		var this_item = item_to_spawn.instantiate()
		this_item.top_level = true
		this_item.z_index = 2
		this_item.scale = Vector2.ZERO
		var tween = create_tween().set_trans(Tween.TRANS_SINE)
		tween.tween_property(this_item, "scale", Vector2.ONE, .1)

		%Grasses.add_child(this_item)
		this_item.instantiated.connect(_on_item_instantiated)
		this_item.cancel_instantiation.connect(_on_instantiation_canceled)
		%AcceptSound.play(0)

func _on_item_instantiated():
	ResourcesManager.subtract_resource(cost, resource)

func _on_instantiation_canceled():
	%CancelSound.play(0)

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

func can_buy_item() -> bool:
	return ResourcesManager.get_resource_quantity(resource) >= cost
