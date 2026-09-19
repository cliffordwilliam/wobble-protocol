class_name HitBurst
extends Node2D

const HIT_RAY_COUNT := 2
const ANGLE_WINDOW := TAU / HIT_RAY_COUNT

const HitRayScene := preload("res://effects/hit_ray.tscn")


func _ready() -> void:
	child_exiting_tree.connect(_on_child_exiting_tree)

	for i in HIT_RAY_COUNT:
		var hit_ray: HitRay = HitRayScene.instantiate()
		hit_ray.rotation = ANGLE_WINDOW * i + randf_range(0.0, ANGLE_WINDOW)
		add_child(hit_ray)


func _on_child_exiting_tree(_node: Node) -> void:
	if get_child_count() == 1:
		queue_free()
