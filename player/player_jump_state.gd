class_name PlayerJumpState
extends PlayerState


func enter(_previous_state: State = null) -> void:
	player.play_bounce()
	player.velocity.y = Player.JUMP_VELOCITY


func physics_process(delta: float) -> void:
	var held := Input.is_action_pressed("ui_accept")
	player.apply_gravity(delta, Player.RISE_GRAVITY if held else Player.FALL_GRAVITY)

	player.move_horizontal(delta)
	player.move_and_slide()

	if player.velocity.y >= 0.0:
		state_machine.transition_to("PlayerFallState")
