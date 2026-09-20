class_name StarBurst
extends Polygon2D

const START_SCALE := 3.0
const SPIN_AMOUNT := PI / 3.0
const DURATION := 0.6


func _ready() -> void:
	scale = Vector2.ONE * START_SCALE

	var tween := create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "scale", Vector2.ZERO, DURATION)
	tween.parallel().tween_property(self, "rotation", SPIN_AMOUNT, DURATION)
	tween.parallel().tween_property(self, "modulate:a", 0.0, DURATION)
	tween.tween_callback(queue_free)
