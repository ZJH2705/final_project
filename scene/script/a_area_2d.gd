extends Area2D

signal platform_should_show

func _on_body_entered(body: Node):
	if body.name == "CharacterBody2D":  # 假設角色叫 player
		emit_signal("platform_should_show")
		print("hello")
