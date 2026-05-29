extends Control

const MAIN_SCREEN_SCENE = "res://Scence/Main/main_screen.tscn"

@onready var gold_manager = GoldManager
@onready var buy_button = $BuyButton
@onready var price_label = $PriceLabel
@onready var multiplier_label = $MultiplierLabel
@onready var remaining_label = $RemainingLabel

func _ready() -> void:
	update_shop_ui()

# 更新商店UI显示
func update_shop_ui() -> void:
	# 更新当前倍率显示
	multiplier_label.text = "当前倍率：x%.1f" % gold_manager.current_multiplier
	
	# 更新剩余购买次数
	remaining_label.text = "剩余次数：%d/%d" % [
		gold_manager.MAX_MULTIPLIER_UPGRADES - gold_manager.multiplier_upgrade_count,
		gold_manager.MAX_MULTIPLIER_UPGRADES
	]
	
	# 检查是否达到购买上限
	if gold_manager.multiplier_upgrade_count >= gold_manager.MAX_MULTIPLIER_UPGRADES:
		price_label.text = "已售罄"
		buy_button.disabled = true
		buy_button.text = "已售罄"
	else:
		# 更新价格显示
		price_label.text = "价格：%d 金币" % gold_manager.get_current_upgrade_price()
		buy_button.disabled = false
		buy_button.text = "购买升级"

# 点击购买按钮
func _on_buy_button_pressed() -> void:
	if gold_manager.buy_multiplier_upgrade():
		# 购买成功，更新UI
		update_shop_ui()

# 返回游戏
func _on_close_button_pressed() -> void:
	get_tree().change_scene_to_file(MAIN_SCREEN_SCENE)
