class_name Enemy
extends Actor

const SPEED := 200.0
const SQUISH_DURATION := 0.6
const SQUISH_IMPACT_DURATION := 0.1
const SQUISH_SCALE := Vector2(1.2, 0.5)
const SQUISH_FROM_SCALE := Vector2(1.5, 0.2)

const RAY_COUNT := 4
const RAY_LENGTH_MIN := 300.0
const RAY_LENGTH_MAX := 400.0

const SmokeParticlesScene := preload("res://enemy/smoke_particles.tscn")
const LightFlashScene := preload("res://enemy/light_flash.tscn")
const LightRayScene := preload("res://enemy/light_ray.tscn")
const LightOrbParticlesScene := preload("res://enemy/light_orb_particles.tscn")


@onready var state_machine: StateMachine = $StateMachine
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

var direction := 1.0


func move_horizontal() -> void:
	velocity.x = direction * SPEED
	apply_tilt(SPEED)


func squish() -> void:
	state_machine.transition_to("EnemySquishedState")


func play_squish() -> void:
	cancel_squash()
	_squash_tween = create_tween().set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	_squash_tween.tween_property(sprite, "scale", SQUISH_FROM_SCALE, SQUISH_IMPACT_DURATION) \
	.set_trans(Tween.TRANS_EXPO)
	_squash_tween.tween_property(sprite, "scale", SQUISH_SCALE, SQUISH_DURATION)
	_squash_tween.tween_callback(_die)


func _die() -> void:
	var smoke: SmokeParticles = SmokeParticlesScene.instantiate()
	smoke.global_position = collision_shape.global_position
	get_parent().add_child(smoke)

	var light_flash: LightFlash = LightFlashScene.instantiate()
	light_flash.global_position = collision_shape.global_position
	get_parent().add_child(light_flash)

	var light_orbs: LightOrbParticles = LightOrbParticlesScene.instantiate()
	light_orbs.global_position = collision_shape.global_position
	get_parent().add_child(light_orbs)

	var angle_window := TAU / RAY_COUNT
	for i in RAY_COUNT:
		var light_ray: LightRay = LightRayScene.instantiate()
		light_ray.global_position = collision_shape.global_position
		light_ray.rotation = angle_window * i + randf_range(0.0, angle_window)
		light_ray.points = PackedVector2Array([Vector2.ZERO, Vector2(randf_range(RAY_LENGTH_MIN, RAY_LENGTH_MAX), 0.0)])
		get_parent().add_child(light_ray)

	queue_free()
