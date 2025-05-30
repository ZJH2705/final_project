extends AnimatableBody2D

@onready var trigger_area = $Area2D

func _ready() -> void:
	visible = false  # 一開始隱藏平台
	trigger_area.body_entered.connect(_on_trigger_entered)

func _on_trigger_entered(body: Node) -> void:
	if body is CharacterBody2D:  # 確認是角色碰到
		visible = true           # 顯示平台


func _on_area_2d_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
