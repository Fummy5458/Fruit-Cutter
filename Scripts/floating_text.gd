extends Node2D

@onready var label = $TextLabel

const BASE_FONT_SIZE: int = 28
const FONT_SIZE_PER_40_COMBO: int = 4
const MAX_FONT_SIZE: int = 60

func update_content(combo:int, combo_total:int):
	var font_size = BASE_FONT_SIZE + floor(combo / 40) * FONT_SIZE_PER_40_COMBO
	font_size = min(font_size, MAX_FONT_SIZE)
	
	label.add_theme_font_size_override("font_size", font_size)
	label.text = "%d连击\n+%d" % [combo, combo_total]
	label.modulate.a = 1.0

func shake():
	var tween = create_tween()
	tween.tween_property(self, "position", position + Vector2(5, 0), 0.05)
	tween.tween_property(self, "position", position + Vector2(-5, 0), 0.05)
	tween.tween_property(self, "position", position + Vector2(3, 0), 0.05)
	tween.tween_property(self, "position", position + Vector2(-3, 0), 0.05)
	tween.tween_property(self, "position", position, 0.05)

func _process(delta):
	pass
