extends Control



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_pressed() -> void:
	#GameState.load_progress()  # Load saved game state
	var level = GameState.current_level
	var game_num = GameState.current_game
	
	#print(level) 
	#print(game_num)
	var scene_path := "res://scene/game_%d.tscn" % [game_num]
	get_tree().change_scene_to_file(scene_path)


func _on_option_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/settings.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_play_2_pressed() -> void:
	pass # Replace with function body.
