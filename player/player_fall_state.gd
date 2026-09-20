class_name PlayerFallState
extends PlayerState


func enter(_previous_state: State = null) -> void:
	player.cancel_squash()


func physics_process(delta: float) -> void:
	player.apply_gravity(delta)

	var direction := player.move_horizontal(delta)
	player.move_and_slide()

	player.update_air_squash()

	if player.is_on_floor() and player.velocity.y >= 0.0:
		state_machine.transition_to(PlayerWalkState if direction != 0.0 else PlayerIdleState)
