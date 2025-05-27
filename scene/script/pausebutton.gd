extends Control


func _on_pause_pressed() -> void:
	print("Pause button pressed")
	_is_paused = !_is_paused
