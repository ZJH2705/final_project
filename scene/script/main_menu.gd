extends Control



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#await get_tree().process_frame
	#update_death_label()
	update_level_buttons()
	update_death_display()
	pass




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#$"CanvasLayer/Label".text = "%d" % GameState.death_count
	
	
	if Input.is_action_just_pressed("ui_right"):
		if GameState.current_level < GameState.max_unlocked_level:
			GameState.current_level += 1
			update_level_buttons()

	if Input.is_action_just_pressed("ui_left"):
		if GameState.current_level > 1:
			GameState.current_level -= 1
			update_level_buttons()
	#pass





func _on_option_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/settings.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_play_1_pressed() -> void:
	var level = GameState.current_level
	GameState.current_game = GameState.level_game_progress[level]
	var game = GameState.current_game
	var scene_path := "res://scene/level_1/game_%d.tscn" % [game]
	get_tree().change_scene_to_file(scene_path)

	


func _on_play_2_pressed() -> void:
	var level = GameState.current_level
	GameState.current_game = GameState.level_game_progress[level]
	var game = GameState.current_game
	var scene_path := "res://scene/level_2/game_%d.tscn" % [game]
	get_tree().change_scene_to_file(scene_path)
	
func update_level_buttons() -> void:
	# Hide all buttons by default
	$PLAY1.visible = false
	$PLAY2.visible = false

	if GameState.current_level == 1:
		$PLAY1.visible = true
	elif GameState.current_level == 2 and GameState.max_unlocked_level >= 2:
		$PLAY2.visible = true

func update_death_display():
	var number_str = str(GameState.death_count)
	var container = $CanvasLayer/DeathCounterDisplay
	
	for child in container.get_children():
		child.queue_free()
	
	for char in number_str:
		var digit = int(char)
		var tex_rect = TextureRect.new()
		tex_rect.texture = load("res://assets/numbers/%d.png" % digit)
		tex_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		tex_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		tex_rect.custom_minimum_size = Vector2(32, 32)  # Set the size of each digit
		container.add_child(tex_rect)
