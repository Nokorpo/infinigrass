extends Control
## Curtain animation used when changing levels

signal change_scene_now
signal finished

func play_animation() -> void:
	reparent(get_tree().root)
	$AnimationPlayer.play("next_level")

func is_playing() -> bool:
	return $AnimationPlayer.is_playing()

func emit_change_scene_signal() -> void:
	change_scene_now.emit()

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	finished.emit()
	queue_free()
