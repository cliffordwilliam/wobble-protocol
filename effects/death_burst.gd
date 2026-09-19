class_name DeathBurst
extends EffectBurst

const RAY_COUNT := 4
const RAY_LENGTH_MIN := 300.0
const RAY_LENGTH_MAX := 400.0
const ANGLE_WINDOW := TAU / RAY_COUNT

const LightRayScene := preload("res://effects/light_ray.tscn")


func _ready() -> void:
	super()

	for i in RAY_COUNT:
		var light_ray: LightRay = LightRayScene.instantiate()
		light_ray.rotation = ANGLE_WINDOW * i + randf_range(0.0, ANGLE_WINDOW)
		light_ray.points = PackedVector2Array([Vector2.ZERO, Vector2(randf_range(RAY_LENGTH_MIN, RAY_LENGTH_MAX), 0.0)])
		add_child(light_ray)
