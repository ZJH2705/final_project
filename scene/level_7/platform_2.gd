extends AnimatableBody2D

@onready var anim = $AnimationPlayer
@onready var area = $Area2D
var is_disappearing = false

func _ready():
	area.body_entered.connect(_on_body_entered)
	anim.animation_finished.connect(_on_animation_finished)

func _on_body_entered(body):
	if is_disappearing:
		return
	if body is CharacterBody2D:
		is_disappearing = true
		anim.play("new_animation")  # 播放動畫

func _on_animation_finished(anim_name):
	if is_disappearing and anim_name == "new_animation":
		visible = false
		collision_layer = 0
		collision_mask = 0
		is_disappearing = false
