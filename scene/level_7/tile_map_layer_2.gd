extends TileMapLayer

@export var player_name: String = "CharacterBody2D"
@export var erase_width: int = 5  # 可透過 Inspector 調整消除寬度

func _on_area_2d_body_entered(body: Node) -> void:
	if body.name != player_name:
		return
	
	# 取得玩家所在格子座標
	var player_tile = local_to_map(body.global_position)
	
	# 設定消除起始位置 (玩家右側第一格)
	var start_x = player_tile.x +1
	
	# 取得地圖有效範圍
	var used_rect = get_used_rect()
	var y_min = used_rect.position.y 
	var y_max = used_rect.position.y + used_rect.size.y - 1

	# 雙重循環消除區域
	for offset_x in range(erase_width):  # 橫向消除 3 格
		for y in range(y_min, y_max + 1):
			var target_x = start_x + offset_x
			var target_pos = Vector2i(target_x, y)
			set_cell(target_pos, -1, Vector2i(-1, -1))

	update_internals()  # 更新物理碰撞
