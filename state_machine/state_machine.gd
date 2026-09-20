class_name StateMachine
extends Node

@onready var current_state: State = get_child(0)


func _ready() -> void:
	current_state.enter()


func _physics_process(delta: float) -> void:
	current_state.physics_process(delta)


func transition_to(target_state_type: Variant) -> void:
	for child in get_children():
		if is_instance_of(child, target_state_type):
			var previous_state := current_state
			current_state.exit()
			current_state = child
			current_state.enter(previous_state)
			return
