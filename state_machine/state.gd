class_name State
extends Node

@onready var state_machine: StateMachine = get_parent()


func enter(_previous_state: State = null) -> void:
	pass


func exit() -> void:
	pass


func physics_process(_delta: float) -> void:
	pass
