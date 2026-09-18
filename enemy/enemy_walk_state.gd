class_name EnemyWalkState
extends EnemyState


func enter(previous_state: State = null) -> void:
	if previous_state is EnemyFallState:
		enemy.play_bounce()


func physics_process(_delta: float) -> void:
	enemy.velocity.x = enemy.direction * Enemy.SPEED
	enemy.move_and_slide()

	if not enemy.is_on_floor():
		state_machine.transition_to("EnemyFallState")
	elif enemy.is_on_wall():
		enemy.direction = -enemy.direction
		enemy.play_bounce()
