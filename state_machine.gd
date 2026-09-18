class_name StateMachine
extends Node

@onready var current_state: State = get_child(0)


func _ready() -> void:
	current_state.enter()


func _physics_process(delta: float) -> void:
	current_state.physics_process(delta)


func transition_to(target_state_path: NodePath) -> void:
	var previous_state := current_state
	current_state.exit()
	current_state = get_node(target_state_path)
	current_state.enter(previous_state)
