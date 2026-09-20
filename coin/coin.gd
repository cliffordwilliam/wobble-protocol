class_name Coin
extends Node2D

const POP_HEIGHT := 250.0
const POP_DURATION := 0.2
const SETTLE_DURATION := 1.0

const SPIN_DURATION := 0.5

const CoinCollectBurstScene := preload("res://effects/coin_collect_burst.tscn")

@onready var sprite: Sprite2D = $Sprite2D
@onready var pickup_area: Area2D = $PickupArea
@onready var collision_shape: CollisionShape2D = $PickupArea/CollisionShape2D


func _ready() -> void:
	pickup_area.body_entered.connect(_on_pickup_area_body_entered)

	var bounce_tween := create_tween()
	bounce_tween.tween_property(sprite, "position:y", -POP_HEIGHT, POP_DURATION).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	bounce_tween.tween_property(sprite, "position:y", 0.0, SETTLE_DURATION).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)

	var spin_tween := create_tween().set_loops().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	spin_tween.tween_property(sprite, "scale:x", 0.0, SPIN_DURATION)
	spin_tween.tween_property(sprite, "scale:x", 1.0, SPIN_DURATION)


func _on_pickup_area_body_entered(body: Node2D) -> void:
	if body is Player:
		var coin_collect_burst: CoinCollectBurst = CoinCollectBurstScene.instantiate()
		coin_collect_burst.global_position = collision_shape.global_position
		get_parent().add_child(coin_collect_burst)

		GameState.add_coins(1)

		queue_free()
