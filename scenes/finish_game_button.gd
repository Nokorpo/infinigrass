extends Button

var game_end_scene = "res://scenes/game_end.tscn"
var resources_icons: Array[Control]
var tooltip_tween: Tween
var not_triggered: bool = true

func _ready() -> void:
	ResourcesManager.resource_changed.connect(on_resource_changed)
	on_resource_changed()
	resources_icons = [$"../Control/Resources/CoinsIcon", $"../Control/Resources/Coins", $"../Control/Resources/BarleyIcon", $"../Control/Resources/Barley", $"../Control/Resources/BeerIcon", $"../Control/Resources/Beers"]

func on_resource_changed() -> void:
	if not_triggered and ResourcesManager.beer >= 20:
		var tween = create_tween().set_trans(Tween.TRANS_SINE)
		var node = $"../.."
		tween.tween_property(node, "position", Vector2.ZERO, 1)
		
	if ResourcesManager.money >= 300 and ResourcesManager.barley >= 200 and ResourcesManager.beer >= 100:
		disabled = false
		for this_icon: Node in resources_icons:
			this_icon.modulate = Color(1, 1, 1, 1)
	else:
		disabled = true
		for this_icon: Node in resources_icons:
			this_icon.modulate = Color(0, 0, 0, .6)

func _on_pressed() -> void:
	var curtain = %Curtain
	if curtain:
		mouse_filter = Control.MOUSE_FILTER_IGNORE
		curtain.play_animation()
		var tween = get_tree().create_tween()
		tween.tween_property(%BackgroundMusic, "volume_db", -50, 1)
		await curtain.change_scene_now
	get_tree().change_scene_to_file(game_end_scene)

func _on_mouse_entered() -> void:
	if tooltip_tween != null:
		tooltip_tween.kill()
	tooltip_tween = create_tween().set_trans(Tween.TRANS_SINE)
	tooltip_tween.tween_property($Tooltip, "modulate", Color("ffffff", 1), .2)

func _on_mouse_exited() -> void:
	if tooltip_tween != null:
		tooltip_tween.kill()
	tooltip_tween = create_tween().set_trans(Tween.TRANS_SINE)
	tooltip_tween.tween_property($Tooltip, "modulate", Color("ffffff", 0), .2)
