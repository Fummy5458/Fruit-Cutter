extends Node

# 游戏全局数据
var total_money: int = 0
var session_money: int = 0
var current_multiplier: float = 1.0

# 商店倍率升级数据
var multiplier_upgrade_count: int = 0
const MAX_MULTIPLIER_UPGRADES: int = 10  # 最大购买次数
const BASE_UPGRADE_PRICE: int = 20       # 初始价格
const MULTIPLIER_PER_UPGRADE: float = 3 # 每次提升的倍率

# 存档文件路径
const SAVE_FILE = "user://game_save.cfg"

func _ready() -> void:
	load_game()
	print("游戏存档加载成功，当前总金币：", total_money)
	print("当前倍率：", current_multiplier)
	print("已购买倍率升级：", multiplier_upgrade_count, "/", MAX_MULTIPLIER_UPGRADES)

# 保存游戏
func save_game() -> void:
	var config = ConfigFile.new()
	
	config.set_value("GameData", "total_money", total_money)
	config.set_value("GameData", "current_multiplier", current_multiplier)
	config.set_value("GameData", "multiplier_upgrade_count", multiplier_upgrade_count)
	
	var error = config.save(SAVE_FILE)
	if error == OK:
		print("游戏保存成功")
	else:
		print("游戏保存失败，错误码：", error)

# 加载游戏
func load_game() -> void:
	var config = ConfigFile.new()
	
	if FileAccess.file_exists(SAVE_FILE):
		var error = config.load(SAVE_FILE)
		if error == OK:
			total_money = config.get_value("GameData", "total_money", 0)
			current_multiplier = config.get_value("GameData", "current_multiplier", 1.0)
			multiplier_upgrade_count = config.get_value("GameData", "multiplier_upgrade_count", 0)
		else:
			print("存档加载失败，使用默认数据")
	else:
		print("没有找到存档文件，使用默认数据")

# 计算本次连击金币
func calculate_session_money(click_count: int) -> void:
	session_money = int(click_count * current_multiplier)

# 计算当前倍率升级的价格
func get_current_upgrade_price() -> int:
	return BASE_UPGRADE_PRICE * pow(4.5, multiplier_upgrade_count)

# 购买倍率升级
func buy_multiplier_upgrade() -> bool:
	# 检查是否达到购买上限
	if multiplier_upgrade_count >= MAX_MULTIPLIER_UPGRADES:
		print("已达到最大购买次数")
		return false
	
	# 计算当前价格
	var price = get_current_upgrade_price()
	
	# 检查金币是否足够
	if total_money < price:
		print("金币不足")
		return false
	
	# 扣除金币
	total_money -= price
	
	# 提升倍率
	current_multiplier *= MULTIPLIER_PER_UPGRADE
	
	# 增加购买次数
	multiplier_upgrade_count += 1
	
	# 保存游戏
	save_game()
	
	print("购买成功！当前倍率：", current_multiplier)
	print("剩余购买次数：", MAX_MULTIPLIER_UPGRADES - multiplier_upgrade_count)
	print("下次升级价格：", get_current_upgrade_price())
	
	return true

# 合并本次金币到总金币
func merge_to_total():
	total_money += session_money
	session_money = 0
	save_game()
