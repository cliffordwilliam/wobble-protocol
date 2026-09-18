class_name HitRay
extends Line2D

const DURATION := 0.1


func _ready() -> void:
	var tween := create_tween()
	tween.tween_property(self, "width", 0.0, DURATION)
	tween.parallel().tween_method(_set_start_x, points[0].x, points[1].x, DURATION)
	tween.parallel().tween_method(_set_tip_curve_value, width_curve.get_point_position(0).y, 0.0, DURATION)
	tween.tween_callback(queue_free)


func _set_start_x(x: float) -> void:
	points = PackedVector2Array([Vector2(x, 0.0), points[1]])


func _set_tip_curve_value(value: float) -> void:
	width_curve.set_point_value(0, value)
