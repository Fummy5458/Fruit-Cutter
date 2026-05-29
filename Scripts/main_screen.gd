extends Node2D

const SHOP_SCENE = "res://Scence/Main/ShopMenu.tscn"
const MAIN_MENU_SCENE = "res://Scence/Main/MainMenu.tscn"

@onready var watermelon = $BackGround/Watermelon

# 只有在游戏界面点击商店时才会执行结算
func _on_shop_button_pressed():
	watermelon.finish_combo()
	get_tree().change_scene_to_file(SHOP_SCENE)

# 点击返回主菜单时也会结算
func _on_back_button_pressed():
	watermelon.finish_combo()
	get_tree().change_scene_to_file(MAIN_MENU_SCENE)
