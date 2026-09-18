class_name IdleState
extends State


func enter(previous_state: State = null) -> void:
	if previous_state is FallState:
		player.play_bounce()
	elif previous_state is WalkState and player.is_on_wall():
		player.play_bounce()


func physics_process(delta: float) -> void:
	var direction := player.move_horizontal(delta)
	player.move_and_slide()

	if not player.is_on_floor():
		state_machine.transition_to("FallState")
	elif Input.is_action_just_pressed("ui_accept"):
		state_machine.transition_to("JumpState")
	elif direction != 0.0 and not player.is_on_wall():
		state_machine.transition_to("WalkState")
