extends Area2D

signal die
@onready var timer: Timer = $Timer
@onready var trigger_area: Area2D = $Area2D  # 觸發區

var has_triggered = false
var should_move = false

func _ready():
	visible = false  # 尖刺一開始隱藏

func _process(delta):
	if should_move:
		position.x -= 500 * delta

func _on_trigger_entered(body: Node):
	if body is CharacterBody2D:
		visible = true
		should_move = true

func _on_hit_entered(body: Node):
	if has_triggered:
		return
	if body is CharacterBody2D:
		has_triggered = true
		print("你已經死了")
		var player = body as CharacterBody2D
		player.die() # 呼叫角色死亡
		GameState.death_count += 1
		await player.anim.animation_finished
		timer.start()

func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
	emit_signal("die")
