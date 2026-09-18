class_name Actor
extends CharacterBody2D

const FALL_GRAVITY := 5062.5
const MAX_FALL_SPEED := 1164.375

const LAND_SQUASH_DURATION := 1.0
const LAND_SQUASH_SCALE := Vector2(1.3, 0.7)

const AIR_SQUASH_MAX_Y := 1.2
const AIR_SQUASH_MIN_X := 0.9

const MAX_TILT_ANGLE := deg_to_rad(4.0)

@onready var sprite: Sprite2D = $Sprite2D

var _squash_tween: Tween


func apply_gravity(delta: float, gravity: float = FALL_GRAVITY) -> void:
	velocity.y = min(velocity.y + gravity * delta, MAX_FALL_SPEED)


func apply_tilt(max_speed: float) -> void:
	sprite.rotation = remap(velocity.x, -max_speed, max_speed, MAX_TILT_ANGLE, -MAX_TILT_ANGLE)


func update_air_squash() -> void:
	var speed := absf(velocity.y)
	sprite.scale.y = remap(speed, 0.0, MAX_FALL_SPEED, 1.0, AIR_SQUASH_MAX_Y)
	sprite.scale.x = remap(speed, 0.0, MAX_FALL_SPEED, 1.0, AIR_SQUASH_MIN_X)


func play_bounce() -> void:
	cancel_squash()
	_squash_tween = create_tween().set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	_squash_tween.tween_property(sprite, "scale", Vector2.ONE, LAND_SQUASH_DURATION) \
	.from(LAND_SQUASH_SCALE)


func cancel_squash() -> void:
	if _squash_tween:
		_squash_tween.kill()
