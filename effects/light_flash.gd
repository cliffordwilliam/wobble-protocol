class_name LightFlash
extends Sprite2D

const DURATION := 0.3


func _ready() -> void:
	var tween := create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "modulate:a", 0.0, DURATION)
	tween.tween_callback(queue_free)
