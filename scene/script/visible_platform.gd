extends AnimatableBody2D

@onready var trigger_area = $Area2D

func _ready() -> void:
	visible = true  # 一開始顯示平台
	trigger_area.body_entered.connect(_on_trigger_entered)

func _on_trigger_entered(body: Node) -> void:
	if body is CharacterBody2D:  # 確認是角色碰到
		visible = false           # 隱藏平台
		collision_layer = 0
		collision_mask = 0
