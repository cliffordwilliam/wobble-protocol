class_name Enemy
extends Actor

const SPEED := 200.0
const SQUISH_DURATION := 0.6
const SQUISH_SCALE := Vector2(1.2, 0.5)
const SQUISH_FROM_SCALE := Vector2(1.5, 0.2)

@onready var state_machine: StateMachine = $StateMachine

var direction := 1.0


func move_horizontal() -> void:
	velocity.x = direction * SPEED
	apply_tilt(SPEED)


func squish() -> void:
	state_machine.transition_to("EnemySquishedState")


func play_squish() -> void:
	cancel_squash()
	_squash_tween = create_tween().set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	_squash_tween.tween_property(sprite, "scale", SQUISH_SCALE, SQUISH_DURATION) \
	.from(SQUISH_FROM_SCALE)
	_squash_tween.tween_callback(queue_free)
