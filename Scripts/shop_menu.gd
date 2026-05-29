extends Control

# 商店只需要返回游戏的逻辑，不需要任何结算
const MAIN_SCREEN_SCENE = "res://Scence/Main/main_screen.tscn"

func _on_close_button_pressed():
	get_tree().change_scene_to_file(MAIN_SCREEN_SCENE)
