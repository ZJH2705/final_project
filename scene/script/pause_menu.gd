extends Control

signal menu_closed

var _is_paused: bool = false:
	set(value):
		_is_paused = value
		get_tree().paused = value
		visible = value
		print("PauseMenu: _is_paused setter called. New state:", _is_paused, " Visible:", visible, " Tree Paused:", get_tree().paused)
		if not _is_paused: # If unpausing (menu is closing)
			emit_signal("menu_closed")

func _ready() -> void:
	visible = _is_paused
	set("pause_mode", 2)
	print("PauseMenu: _ready called. Initial visible:", visible, " Pause Mode:", get_process_mode())


func _unhandled_input(event: InputEvent) -> void:
	if not is_node_ready():
		return
	if event.is_action_pressed("escape"):
		print("PauseMenu: Escape pressed!")
		toggle_pause()
		get_viewport().set_input_as_handled()
	
#func set_paused(value:bool) ->void:
#	_is_paused = value
#	get_tree().paused = _is_paused
#	visible = _is_paused

func toggle_pause() -> void:
#	self._is_paused = !self._is_paused
	_is_paused = !_is_paused
#	get_tree().paused = _is_paused
#	visible = _is_paused
	print("Pause toggled. Paused:", _is_paused)
	
#func _on_pause_pressed() -> void:
#	print("Pause button pressed")
#	toggle_pause()

func _on_back_pressed() -> void:
	_is_paused = false
	Transition.has_played_intro = false
	get_tree().change_scene_to_file("res://scene/main_menu.tscn")


func _on_restart_pressed() -> void:
	_is_paused = false
	get_tree().reload_current_scene()



func _on_resume_pressed() -> void:
	_is_paused = false
#	get_tree().paused = _is_paused
#	visible = _is_paused
