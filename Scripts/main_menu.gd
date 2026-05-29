extends Control

const GAME_SCENE = "res://Scence/Main/main_screen.tscn"
const SETTINGS_SCENE = "res://Settings.tscn"

# 开始游戏
func _on_start_button_pressed():
	get_tree().change_scene_to_file(GAME_SCENE)

# 继续游戏
func _on_continue_button_pressed():
	get_tree().change_scene_to_file(GAME_SCENE)

# 设置
func _on_settings_button_pressed():
	print("打开设置界面")

# 退出游戏
func _on_exit_button_pressed():
	GoldManager.save_game()
	get_tree().quit()
