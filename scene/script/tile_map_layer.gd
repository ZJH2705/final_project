extends TileMapLayer

# 設定玩家的 Node 名稱
@export var player_name: String = "player"

func _on_area_2d_body_entered(body: Node) -> void:
	print("triggered", body)
	# 判斷是不是玩家
	if body.name != player_name:
		return

	# 取得玩家目前的 tilemap 格子座標
	var player_pos: Vector2 = body.global_position
	var player_tile: Vector2i = local_to_map(player_pos)

	# 假設要讓玩家前方一排（x+1）全部消失
	var disappear_x = player_tile.x + 1
	var used_rect = get_used_rect()
	var y_min = used_rect.position.y
	var y_max = used_rect.position.y + used_rect.size.y - 1

	for y in range(y_min, y_max + 1):

		var target_pos = Vector2i(disappear_x, y)
		# 將該格設為空（-1, Vector2i(-1, -1)）
		set_cell(target_pos, -1, Vector2i(-1, -1))
