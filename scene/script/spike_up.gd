extends Area2D

signal die

@onready var timer: Timer = $Timer
var has_triggered = false

@onready var sprite: Sprite2D = $spike
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var spike_collision: CollisionShape2D = $CollisionShape2D

var is_triggered = false

func _ready():
	# 初始時尖刺的碰撞要關閉，避免未冒出時就殺死玩家

	sprite.visible = false

# 這是觸發區域的訊號，角色進入後播放尖刺動畫
func _on_judge_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D" and not is_triggered:
		is_triggered = true
		# 播放尖刺冒出動畫
		start_spike()

func start_spike():
	sprite.visible = true
	# 這裡可以先把 sprite.position.y 設為地底位置
	sprite.position.y = 45
	animation_player.play("spike_up")

# 這是尖刺本身的碰撞訊號，只在尖刺冒出時才會觸發
func _on_body_entered(body: Node2D) -> void:
	if has_triggered:
		return

	if body is CharacterBody2D:
		has_triggered = true
		print("你已經死了")

		var player = body as CharacterBody2D
		player.die() #呼叫自己死亡
		GameState.death_count+=1
		print("hello")
		await player.anim.animation_finished
		timer.start()

func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
	emit_signal("die")
