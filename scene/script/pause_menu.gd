extends Control



var _is_paused: bool = false:
	set(value):
		_is_paused = value
		visible = _is_paused
		if _is_paused:
			await get_tree().create_timer(0.01).timeout
			get_tree().paused = true
		else:
			get_tree().paused = false
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		self._is_paused = !_is_paused
	
#func set_paused(value:bool) ->void:
#	_is_paused = value
#	get_tree().paused = _is_paused
#	visible = _is_paused

func _on_pause_pressed() -> void:
	print("Pause button pressed")
	_is_paused = !_is_paused

func _on_back_pressed() -> void:
	_is_paused = false
	get_tree().change_scene_to_file("res://scene/main_menu.tscn")


func _on_restart_pressed() -> void:
	_is_paused = false
	get_tree().reload_current_scene()



func _on_resume_pressed() -> void:
	_is_paused = false
	get_tree().paused = _is_paused
	visible = _is_paused
