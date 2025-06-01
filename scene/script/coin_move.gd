extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D :
		print("+1 coin")
		queue_free()


func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D :
		position.x += 30
		pass # Replace with function body.
