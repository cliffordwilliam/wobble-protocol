class_name PlayerIdleState
extends PlayerState


func enter(previous_state: State = null) -> void:
	if previous_state is PlayerFallState:
		player.play_bounce()
	elif previous_state is PlayerWalkState and player.is_on_wall():
		player.play_bounce()


func physics_process(delta: float) -> void:
	var direction := player.move_horizontal(delta)
	player.move()

	if not player.is_on_floor():
		state_machine.transition_to("PlayerFallState")
	elif Input.is_action_just_pressed("ui_accept"):
		state_machine.transition_to("PlayerJumpState")
	elif direction != 0.0 and not player.is_on_wall():
		state_machine.transition_to("PlayerWalkState")
