extends Node2D

# 終點門和轉場
@onready var Door = get_node("door")
@onready var Transitiondoor = get_node("Transitiondoor")

@onready var pause_menu_instance = $"UILayer/Pause_menu"
@onready var external_pause_button = $"Pause"
# 死亡
#@onready var trapcoin = get_node("coin dead") # 陷阱節點
#@onready var player = get_node("CharacterBody2D") # 角色

func _ready() -> void:
	GameState.current_level = 2
	GameState.current_game = 3
	#GameState.save_progress()
	
	if not Transition.has_played_intro:
		Transitiondoor.play("dooropen")
		Transition.has_played_intro = true
	else:
		Transitiondoor.stop()
	
	if pause_menu_instance:
		pause_menu_instance.visible = false # Ensure it starts hidden
		pause_menu_instance.connect("menu_closed", _on_pause_menu_closed) # <--- ADD THIS LINE
	#else:
		#print("Error: PauseMenu instance not found in _ready!")
	
	Door.connect("enter" , Callable(self , "_on_enter"))  # 終點門信號連結
	#trapcoin.connect("die" , Callable(self , "_on_die")) # 陷阱信號連結
	pass

func _on_enter() -> void:
	Transitiondoor.play("doorclose")
	await Transitiondoor.animation_finished
	Transition.has_played_intro = false
	GameState.current_game = 1
	GameState.level_game_progress[GameState.current_level] = GameState.current_game
	#轉場景
	if GameState.max_unlocked_level < 2:
		GameState.max_unlocked_level = 2
	GameState.current_level = 3
	GameState.current_game = 1
	GameState.max_unlocked_level = max(GameState.max_unlocked_level, 3)
	get_tree().change_scene_to_file("res://scene/main_menu.tscn")

	pass

func _on_ExternalPauseButton_pressed(): 
	pause_menu_instance.toggle_pause()
	

func _on_pause_pressed() -> void:
	if pause_menu_instance: # Make sure the instance exists
		pause_menu_instance.toggle_pause()
		#external_pause_button.visible = false
	#else:
		#print("Error: PauseMenu instance not found!")

func _on_pause_menu_closed(): # <--- ADD THIS NEW FUNCTION
	#print("Pause menu closed signal received. Showing external button.")
	external_pause_button.visible = true
