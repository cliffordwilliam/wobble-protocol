class_name CoinCounter
extends HBoxContainer

const CoinCollectBurstScene := preload("res://effects/coin_collect_burst.tscn")
const ICON_BURST_SCALE := 0.7

const BOUNCE_HEIGHT := 40.0
const BOUNCE_UP_DURATION := 0.03
const BOUNCE_SETTLE_DURATION := 0.5

const BLINK_ALPHA := 0.3
const BLINK_DURATION := 0.1

@onready var icon: TextureRect = $IconStack/Icon
@onready var count_wrapper: Control = $CountWrapper
@onready var count_label: Label = $CountWrapper/CountLabel

var _bounce_tween: Tween
var _blink_tween: Tween

var _count_rest_y: float


func _ready() -> void:
	_set_count(GameState.coins)
	GameState.coins_changed.connect(_on_coins_changed)

	# custom_minimum_size changes resolve on the next layout pass, not
	# immediately, so wait a frame before caching the label's resting position.
	# It never changes again after this: only the label's width grows with
	# more digits, not its height, since the font size is fixed.
	await get_tree().process_frame
	_count_rest_y = count_label.position.y


func _on_coins_changed(coins: int) -> void:
	_set_count(coins)
	_play_icon_burst()
	_play_count_bounce()


func _set_count(coins: int) -> void:
	count_label.text = str(coins)
	count_wrapper.custom_minimum_size = count_label.get_minimum_size()


func _play_icon_burst() -> void:
	var burst: CoinCollectBurst = CoinCollectBurstScene.instantiate()
	burst.position = icon.size / 2.0
	burst.scale = Vector2.ONE * ICON_BURST_SCALE
	icon.add_child(burst)


func _play_count_bounce() -> void:
	if _bounce_tween:
		_bounce_tween.kill()
	_bounce_tween = create_tween()
	_bounce_tween.tween_property(count_label, "position:y", _count_rest_y - BOUNCE_HEIGHT, BOUNCE_UP_DURATION) \
	.set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	_bounce_tween.tween_property(count_label, "position:y", _count_rest_y, BOUNCE_SETTLE_DURATION) \
	.set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	_bounce_tween.finished.connect(_on_bounce_finished)

	count_label.modulate.a = 1.0
	if _blink_tween:
		_blink_tween.kill()
	_blink_tween = create_tween().set_loops()
	_blink_tween.tween_property(count_label, "modulate:a", BLINK_ALPHA, BLINK_DURATION)
	_blink_tween.tween_property(count_label, "modulate:a", 1.0, BLINK_DURATION)


func _on_bounce_finished() -> void:
	_blink_tween.kill()
	count_label.modulate.a = 1.0
