class_name HitBurst
extends EffectBurst

const HIT_RAY_COUNT := 4
const ANGLE_WINDOW := TAU / HIT_RAY_COUNT

const HitRayScene := preload("res://effects/hit_ray.tscn")


func _ready() -> void:
	super()

	for i in HIT_RAY_COUNT:
		var hit_ray: HitRay = HitRayScene.instantiate()
		hit_ray.rotation = ANGLE_WINDOW * i + randf_range(0.0, ANGLE_WINDOW)
		add_child(hit_ray)
