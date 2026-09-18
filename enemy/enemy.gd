class_name Enemy
extends Actor

const SPEED := 200.0
const SQUISH_DURATION := 0.6
const SQUISH_IMPACT_DURATION := 0.1
const SQUISH_SCALE := Vector2(1.2, 0.5)
const SQUISH_FROM_SCALE := Vector2(1.5, 0.2)

const SmokeParticlesScene := preload("res://enemy/smoke_particles.tscn")


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
	queue_free()
