extends AudioStreamPlayer

## Play the next song when current one is finished
func _on_finished() -> void:
	stop()
	play(0)
