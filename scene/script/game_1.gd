extends Node2D

# 終點門和轉場
@onready var Door = get_node("door")
@onready var Transition = get_node("Transitiondoor")

# 死亡
#@onready var trapcoin = get_node("coin dead") # 陷阱節點
#@onready var player = get_node("CharacterBody2D") # 角色

func _ready() -> void:
	GameState.current_level = 1
	GameState.current_game = 1
#	GameState.save_progress()
	
	Transition.play("dooropen")
	Door.connect("enter" , Callable(self , "_on_enter"))  # 終點門信號連結
	#trapcoin.connect("die" , Callable(self , "_on_die")) # 陷阱信號連結
	pass

func _on_enter() -> void:
	Transition.play("doorclose")
	await Transition.animation_finished
	#轉場景
	
	get_tree().change_scene_to_file("res://scene/game_2.tscn")

	pass
	
# 死亡
#func _on_die() -> void:
	#player.get_child(1).play("die")
	#trapcoin.disconnect("die" , Callable(self , "_on_die"))
