extends Control

func _ready():
	$AnimationPlayer.play("RESET")
	set_process(true)
	hide()

func resume():
	get_tree().paused = false 
	$AnimationPlayer.play_backwards("blur")
	hide()
	
func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	show()
	
func testEsc():
	if Input.is_action_just_pressed("esc") and not get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().paused:
		resume()
		

func _on_Back_pressed() -> void:
	resume()


func _on_Restart_pressed() -> void:
	resume()
	get_tree().reload_current_scene()


func _on_Resume_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/main_menu.tscn")

func _process(delta):
	testEsc()
