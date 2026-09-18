class_name JumpState
extends State


func enter(_previous_state: State = null) -> void:
	player.play_bounce()
	player.velocity.y = Player.JUMP_VELOCITY


func physics_process(delta: float) -> void:
	var held := Input.is_action_pressed("ui_accept")
	var gravity := Player.RISE_GRAVITY if held else Player.FALL_GRAVITY
	player.velocity.y = min(player.velocity.y + gravity * delta, Player.MAX_FALL_SPEED)

	player.move_horizontal(delta)
	player.move_and_slide()

	if player.velocity.y >= 0.0:
		state_machine.transition_to("FallState")
