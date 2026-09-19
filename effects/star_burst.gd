class_name StarBurst
extends Polygon2D

const POINT_COUNT := 4
const OUTER_RADIUS := 60.0
const INNER_RADIUS := 24.0

const START_SCALE := 3.0
const SPIN_AMOUNT := PI / 3.0
const DURATION := 0.6


func _ready() -> void:
	polygon = _build_star_points()
	scale = Vector2.ONE * START_SCALE

	var tween := create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "scale", Vector2.ZERO, DURATION)
	tween.parallel().tween_property(self, "rotation", SPIN_AMOUNT, DURATION)
	tween.parallel().tween_property(self, "modulate:a", 0.0, DURATION)
	tween.tween_callback(queue_free)


func _build_star_points() -> PackedVector2Array:
	var vertex_count := POINT_COUNT * 2
	var angle_step := TAU / vertex_count
	var points := PackedVector2Array()
	for i in vertex_count:
		var radius := OUTER_RADIUS if i % 2 == 0 else INNER_RADIUS
		var angle := -PI / 2.0 + i * angle_step
		points.append(Vector2(cos(angle), sin(angle)) * radius)
	return points
