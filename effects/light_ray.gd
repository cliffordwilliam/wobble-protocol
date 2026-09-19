class_name LightRay
extends Line2D

const DURATION := 0.1


func _ready() -> void:
	var tween := create_tween()
	tween.tween_property(self, "scale:x", 0.0, DURATION)
	tween.parallel().tween_property(self, "modulate:a", 0.0, DURATION)
	tween.tween_callback(queue_free)
