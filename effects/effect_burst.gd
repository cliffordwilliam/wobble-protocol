class_name EffectBurst
extends Node2D


func _ready() -> void:
	child_exiting_tree.connect(_on_child_exiting_tree)


func _on_child_exiting_tree(_node: Node) -> void:
	if get_child_count() == 1:
		queue_free()
