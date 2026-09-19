class_name LightRing
extends Sprite2D

const DURATION := 0.3
const END_SCALE := 3.0


func _ready() -> void:
	var tween := create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "scale", Vector2.ONE * END_SCALE, DURATION)
	tween.parallel().tween_property(self, "modulate:a", 0.0, DURATION)
	tween.tween_callback(queue_free)
