extends Node

var current_level := 1
var current_game := 1
var death_count := 0



#func save_progress():
#	var data = {
#		"level": current_level,
#		"game": current_game,
#		"deaths": death_count
#	}
#	var file = FileAccess.open("user://save_data.json", FileAccess.WRITE)
#	file.store_string(JSON.stringify(data))
#	file.close()

#func load_progress():
#	if not FileAccess.file_exists("user://save_data.json"):
#		return
#	var file = FileAccess.open("user://save_data.json", FileAccess.READ)
#	var content = file.get_as_text()
#	var data = JSON.parse_string(content)
#	if data:
#		current_level = data.get("level", 1)
#		current_game = data.get("game", 1)
#		death_count = data.get("deaths", 0)
#	file.close()
