extends Control

func _ready():
	# Set buttons based on saved state
	$sound_on.button_pressed = Keep.sound_enabled
	$sound_off.button_pressed = not Keep.sound_enabled
	
	if Keep.sound_enabled:
		Music.play_music()
	else:
		Music.stop_music()

func _on_reset_pressed() -> void:
	pass # Replace with function body.


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/main_menu.tscn")


func _on_sound_on_toggled(toggled_on: bool) -> void:
	$sound_off.button_pressed = not toggled_on
	Keep.sound_enabled = toggled_on
	if toggled_on:
		Music.play_music()
		# Handle turning sound ON here
		print("Sound ON")
	else:
		Music.stop_music()
		# Handle turning sound ON here
		print("Sound OFF")


func _on_sound_off_toggled(toggled_on: bool) -> void:
	if toggled_on:
		$sound_on.button_pressed = false
		Keep.sound_enabled = false
		Music.stop_music()
		# Handle turning sound OFF here
		print("Sound OFF")


#func _on_ready() -> void:
	#$sound_on.button_pressed = true  # Start with sound ON
	#$sound_off.button_pressed = false
