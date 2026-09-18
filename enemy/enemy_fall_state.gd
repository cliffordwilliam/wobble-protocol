class_name EnemyFallState
extends EnemyState


func enter(_previous_state: State = null) -> void:
	enemy.cancel_squash()


func physics_process(delta: float) -> void:
	enemy.apply_gravity(delta)

	enemy.velocity.x = enemy.direction * Enemy.SPEED
	enemy.move_and_slide()

	enemy.update_air_squash()

	if enemy.is_on_floor():
		state_machine.transition_to("EnemyWalkState")
