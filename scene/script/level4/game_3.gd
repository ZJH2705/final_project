extends Node2D

@onready var platform = $platform2
@onready var area2d = $AArea2D
@onready var Door = get_node("door")
@onready var Transitiondoor = get_node("Transitiondoor")
@onready var pause_menu_instance = $"UILayer/Pause_menu"
@onready var external_pause_button = $"Pause"

func _ready() -> void:
	# Area2D 訊號連接
	area2d.connect("platform_should_show", _on_platform_should_show)
	
	# 遊戲狀態設定
	GameState.current_level = 4
	GameState.current_game = 3
	
	# 開門動畫
	if not Transition.has_played_intro:
		Transitiondoor.play("dooropen")
		Transition.has_played_intro = true
	else:
		Transitiondoor.stop()
	
	# 暫停選單設定
	if pause_menu_instance:
		pause_menu_instance.visible = false
		pause_menu_instance.connect("menu_closed", _on_pause_menu_closed)
	
	# 終點門訊號連接
	Door.connect("enter", Callable(self, "_on_enter"))
	# trapcoin.connect("die", Callable(self, "_on_die")) # 如果有需要再打開

func _on_platform_should_show():
	platform.show_platform()  # 顯示 platform

func _on_enter() -> void:
	Transitiondoor.play("doorclose")
	await Transitiondoor.animation_finished
	Transition.has_played_intro = false
	# 轉場景
	GameState.current_game = 1
	GameState.level_game_progress[GameState.current_level] = GameState.current_game
	#轉場景
	if GameState.max_unlocked_level < 5:
		GameState.max_unlocked_level = 5
	GameState.current_level = 5
	GameState.current_game = 1
	GameState.max_unlocked_level = max(GameState.max_unlocked_level, 5)
	get_tree().change_scene_to_file("res://scene/main_menu.tscn")

func _on_ExternalPauseButton_pressed(): 
	pause_menu_instance.toggle_pause()

func _on_pause_pressed() -> void:
	if pause_menu_instance:
		pause_menu_instance.toggle_pause()

func _on_pause_menu_closed():
	external_pause_button.visible = true
