class_name EnemySquishedState
extends EnemyState


func enter(_previous_state: State = null) -> void:
	enemy.sprite.rotation = 0.0
	enemy.velocity = Vector2.ZERO
	enemy.collision_layer = 0
	enemy.play_squish()
