extends Area2D

signal enter

var has_triggered := false
func _on_body_entered(body: Node2D) -> void:
 if has_triggered:
  return
 if body is CharacterBody2D:
  var player = body as CharacterBody2D
  print("Player touched the door!")
  player._pass()
  #touching_door = true
 # 例如：播放一個動畫或切換場景
  get_child(0).play("enter_door")
  await get_child(0).animation_finished
#發信號
 print("準備發信號")
 emit_signal("enter")
 print("done?")
 # 或執行場景切換
 #get_tree().change_scene_to_file("res://scene/game_3.tscn")
