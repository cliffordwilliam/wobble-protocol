class_name State
extends Node

@onready var player: Player = owner
@onready var state_machine: StateMachine = get_parent()


func enter(_msg: Dictionary = {}) -> void:
	pass


func exit() -> void:
	pass


func physics_process(_delta: float) -> void:
	pass


func unhandled_input(_event: InputEvent) -> void:
	pass
