class_name FallState
extends State


func enter(_previous_state: State = null) -> void:
	player.cancel_squash()


func physics_process(delta: float) -> void:
	player.velocity.y = min(player.velocity.y + Player.FALL_GRAVITY * delta, Player.MAX_FALL_SPEED)

	var direction := player.move_horizontal(delta)
	player.move_and_slide()

	var speed := absf(player.velocity.y)
	player.sprite.scale.y = remap(speed, 0.0, Player.MAX_FALL_SPEED, 1.0, Player.AIR_SQUASH_MAX_Y)
	player.sprite.scale.x = remap(speed, 0.0, Player.MAX_FALL_SPEED, 1.0, Player.AIR_SQUASH_MIN_X)

	if player.is_on_floor():
		state_machine.transition_to("WalkState" if direction != 0.0 else "IdleState")
