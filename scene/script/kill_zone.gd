extends Area2D

signal die

@onready var timer: Timer = $Timer
var has_triggered = false

func _on_body_entered(body: Node2D) -> void:
	if has_triggered:
		return

	if body is CharacterBody2D:
		has_triggered = true
		print("你已經死了")

		var player = body as CharacterBody2D
		player.die() #呼叫自己死亡
		GameState.death_count+=1

		await player.anim.animation_finished
		#timer.start()
func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
	emit_signal("die")
