extends Node2D

# 场景路径
const SHOP_SCENE = "res://Scence/Main/ShopMenu.tscn"
const MAIN_MENU_SCENE = "res://Scence/Main/MainMenu.tscn"

# 节点绑定（完美匹配你的场景树）
@onready var watermelon: Area2D = $BackGround/Watermelon
@onready var pause_mask: ColorRect = $PauseMask
@onready var pause_menu: VBoxContainer = $PauseMenu
@onready var continue_button: Button = $PauseMenu/ContinueButton
@onready var back_to_main_button: Button = $PauseMenu/BackToMainButton
@onready var settings_button: Button = $GoldUi/SettingsButton

func _ready():
	# 修复：Godot 4 正确的暂停模式写法
	pause_menu.process_mode = Node.PROCESS_MODE_ALWAYS
	pause_mask.process_mode = Node.PROCESS_MODE_ALWAYS
	
	# 初始状态隐藏菜单
	pause_mask.visible = false
	pause_menu.visible = false

# 打开商店
func _on_shop_button_pressed():
	watermelon.finish_combo()
	get_tree().change_scene_to_file(SHOP_SCENE)

# 打开暂停菜单
func open_pause_menu():
	print("✅ 打开暂停菜单")
	get_tree().paused = true
	pause_mask.visible = true
	pause_menu.visible = true

# 关闭暂停菜单（继续游戏）
func close_pause_menu():
	print("✅ 关闭暂停菜单，继续游戏")
	pause_mask.visible = false
	pause_menu.visible = false
	get_tree().paused = false

# 回到主菜单（自动结算+保存）
func back_to_main_menu():
	print("✅ 返回主菜单")
	watermelon.finish_combo()
	get_tree().paused = false
	get_tree().change_scene_to_file(MAIN_MENU_SCENE)

# 窗口关闭自动保存
func _notification(what: int):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		watermelon.finish_combo()
		get_tree().quit()
