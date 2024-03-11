extends Button

@export var scene: PackedScene

func _ready() -> void:
	$AnimationPlayer.play("idle")

func _on_pressed() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	var curtain = %Curtain
	curtain.play_animation()
	# TODO uncomment when music is added
	#var tween = get_tree().create_tween()
	#tween.tween_property(%BackgroundMusic, "volume_db", -50, 1)
	await curtain.change_scene_now
	get_tree().change_scene_to_packed(scene)
