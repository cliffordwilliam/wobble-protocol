class_name PlayerHurtState
extends PlayerState

const HurtBurstScene := preload("res://effects/hurt_burst.tscn")

@onready var timer: Timer = $Timer


func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)


func enter(_previous_state: State = null) -> void:
	player.play_bounce()
	player.is_invincible = true
	player.velocity.x = Player.KNOCKBACK_VELOCITY * player.hurt_direction

	var hurt_burst: HurtBurst = HurtBurstScene.instantiate()
	hurt_burst.global_position = player.collision_shape.global_position
	player.get_parent().add_child(hurt_burst)

	timer.start()


func exit() -> void:
	player.start_invincibility()


func physics_process(delta: float) -> void:
	player.velocity.x = move_toward(player.velocity.x, 0, player.ACCELERATION * delta)
	player.apply_tilt(player.MAX_SPEED)
	player.apply_gravity(delta)
	player.move_and_slide()


func _on_timer_timeout() -> void:
	state_machine.transition_to(PlayerFallState if not player.is_on_floor() else PlayerIdleState)
