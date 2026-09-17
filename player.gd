extends CharacterBody2D

const MAX_SPEED := 657.0
const ACCELERATION := 1476.563
const RISE_GRAVITY := 1012.5
const FALL_GRAVITY := 5062.5
const MAX_FALL_SPEED := 1164.375
const JUMP_VELOCITY := -928.125


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		var rising_and_held := velocity.y < 0.0 and Input.is_action_pressed("ui_accept")
		var current_gravity := RISE_GRAVITY if rising_and_held else FALL_GRAVITY
		velocity.y = min(velocity.y + current_gravity * delta, MAX_FALL_SPEED)

	# As good practice, you should replace UI actions with custom gameplay actions.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("ui_left", "ui_right")
	velocity.x = move_toward(velocity.x, direction * MAX_SPEED, ACCELERATION * delta)

	move_and_slide()
