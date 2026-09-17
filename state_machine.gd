class_name StateMachine
extends Node

@export var initial_state: State

var current_state: State


func _ready() -> void:
	if initial_state:
		current_state = initial_state
		current_state.enter()


func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_process(delta)


func _unhandled_input(event: InputEvent) -> void:
	if current_state:
		current_state.unhandled_input(event)


func transition_to(target_state_path: NodePath, msg: Dictionary = {}) -> void:
	if not has_node(target_state_path):
		return

	var target_state: State = get_node(target_state_path)
	if target_state == current_state:
		return

	var previous_state := current_state
	if current_state:
		current_state.exit()
	current_state = target_state
	msg["from"] = previous_state
	current_state.enter(msg)
