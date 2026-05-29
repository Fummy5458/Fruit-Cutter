extends CanvasLayer

@onready var total_label = get_node("TotalMoneyLabel")
@onready var session_label = get_node("SessionMoneyLabel")
@onready var mul_label = get_node("MultiplierLabel")
@onready var gold_manager = GoldManager

var tween: Tween = null

func _process(_delta):
	total_label.text = "总金币：%d" % gold_manager.total_money
	session_label.text = "本次金币：%d" % gold_manager.session_money
	mul_label.text = "倍率 ×%d" % gold_manager.current_multiplier

func pop_anim():
	if tween: tween.kill()
	tween = create_tween()
	session_label.modulate.a = 0
	session_label.scale = Vector2(0.8, 0.8)
	tween.tween_property(session_label, "modulate:a", 1, 0.2)
	tween.tween_property(session_label, "scale", Vector2(1,1), 0.2)

func fade_anim():
	if tween: tween.kill()
	tween = create_tween()
	tween.tween_property(session_label, "modulate:a", 0, 0.5)
	tween.tween_property(session_label, "scale", Vector2(0.8,0.8), 0.5)
	tween.finished.connect(gold_manager.merge_to_total)
