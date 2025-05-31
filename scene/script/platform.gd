extends AnimatableBody2D

func _ready() -> void:
	visible = false  # 一開始隱藏

func show_platform():
	print("yes")
	visible = true   # 需要時顯示
