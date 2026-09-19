class_name Player
extends Actor

const MAX_SPEED := 657.0
const ACCELERATION := 1476.563
const RISE_GRAVITY := 1012.5
const JUMP_VELOCITY := -928.125
const KNOCKBACK_VELOCITY := 500
const INVINCIBLE_BLINK_ALPHA := 0.3
const INVINCIBLE_BLINK_DURATION := 0.1

@onready var state_machine: StateMachine = $StateMachine
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var invincibility_timer: Timer = $InvincibilityTimer
@onready var hurt_area: Area2D = $HurtArea
@onready var camera_transform: RemoteTransform2D = $CameraTransform

var is_invincible := false
var hurt_direction := 1.0

var _invincibility_tween: Tween


func _ready() -> void:
	invincibility_timer.timeout.connect(_on_invincibility_timer_timeout)
	hurt_area.body_entered.connect(_on_hurt_area_body_entered)


func _on_hurt_area_body_entered(body: Node2D) -> void:
	if body is Enemy:
		if velocity.y > 0.0:
			body.squish()
			play_bounce()
			velocity.y = JUMP_VELOCITY
		elif not is_invincible:
			hurt_direction = signf(global_position.x - body.global_position.x)
			state_machine.transition_to("PlayerHurtState")


func start_invincibility() -> void:
	invincibility_timer.start()

	if _invincibility_tween:
		_invincibility_tween.kill()
	_invincibility_tween = create_tween().set_loops()
	_invincibility_tween.tween_property(sprite, "modulate:a", INVINCIBLE_BLINK_ALPHA, INVINCIBLE_BLINK_DURATION)
	_invincibility_tween.tween_property(sprite, "modulate:a", 1.0, INVINCIBLE_BLINK_DURATION)


func _on_invincibility_timer_timeout() -> void:
	is_invincible = false
	_invincibility_tween.kill()
	sprite.modulate.a = 1.0


func move_horizontal(delta: float) -> float:
	var direction := Input.get_axis("ui_left", "ui_right")
	velocity.x = move_toward(velocity.x, direction * MAX_SPEED, ACCELERATION * delta)
	apply_tilt(MAX_SPEED)
	return direction
