extends Area2D

var click_count: int = 0
var reset_timer: float = 0.0
const RESET_DELAY: float = 10.0

var current_floating_text: Node2D = null

@onready var gold_manager = GoldManager
@onready var ui = get_tree().get_nodes_in_group("GoldUI")[0]
@onready var main_scene_root = get_parent().get_parent()
@export var floating_text_scn: PackedScene

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	position = get_viewport_rect().size / 2

	if click_count > 0:
		reset_timer -= _delta
		if reset_timer <= 0:
			finish_combo()

# 强制结算+清理+自动保存
func finish_combo():
	if click_count > 0:
		gold_manager.calculate_session_money(click_count)
		gold_manager.total_money += gold_manager.session_money
		gold_manager.save_game()
		gold_manager.session_money = 0
		ui.fade_anim()

	if current_floating_text:
		current_floating_text.queue_free()
		current_floating_text = null

	click_count = 0
	reset_timer = 0

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		click_count += 1
		reset_timer = RESET_DELAY
		gold_manager.calculate_session_money(click_count)
		
		ui.pop_anim()
		
		var combo_total_gold = click_count * gold_manager.current_multiplier

		if not current_floating_text:
			current_floating_text = floating_text_scn.instantiate()
			current_floating_text.z_index = 100
			main_scene_root.add_child(current_floating_text)
		
		current_floating_text.global_position = get_global_mouse_position() + Vector2(0, -30)
		current_floating_text.update_content(click_count, combo_total_gold)
		current_floating_text.shake()
		
		play_click_anim()

func play_click_anim():
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.1, 1.1), 0.07)
	tween.tween_property(self, "rotation", 0.1, 0.05)
	tween.tween_property(self, "rotation", -0.1, 0.05)
	tween.tween_property(self, "rotation", 0, 0.05)
	tween.tween_property(self, "scale", Vector2(1, 1), 0.07)
