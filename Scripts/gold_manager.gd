extends Node

# 游戏数据
var total_money: int = 0
var session_money: int = 0
var current_multiplier: int = 1

# 存档文件路径（user:// 是Godot专用的用户数据目录，跨平台可写）
const SAVE_FILE = "user://game_save.cfg"

func _ready() -> void:
	# 游戏启动时自动加载存档
	load_game()
	print("游戏存档加载成功，当前总金币：", total_money)

# 【核心】保存游戏
func save_game() -> void:
	var config = ConfigFile.new()
	
	# 把数据写入配置文件
	config.set_value("GameData", "total_money", total_money)
	config.set_value("GameData", "current_multiplier", current_multiplier)
	
	# 保存到文件
	var error = config.save(SAVE_FILE)
	if error == OK:
		print("游戏保存成功")
	else:
		print("游戏保存失败，错误码：", error)

# 【核心】加载游戏
func load_game() -> void:
	var config = ConfigFile.new()
	
	# 检查存档文件是否存在
	if FileAccess.file_exists(SAVE_FILE):
		var error = config.load(SAVE_FILE)
		if error == OK:
			# 读取数据，没有的话用默认值
			total_money = config.get_value("GameData", "total_money", 0)
			current_multiplier = config.get_value("GameData", "current_multiplier", 1)
		else:
			print("存档加载失败，使用默认数据")
	else:
		print("没有找到存档文件，使用默认数据")

# 计算本次连击金币
func calculate_session_money(click_count: int) -> void:
	session_money = click_count * current_multiplier
	
# 合并本次金币到总金币（供gold_ui动画结束后调用）
func merge_to_total():
	total_money += session_money
	session_money=0
	save_game()
