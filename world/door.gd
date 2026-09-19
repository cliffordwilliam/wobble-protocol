class_name Door
extends Area2D

@export_file("*.tscn") var target_room_path: String

@onready var marker: Marker2D = $Marker2D


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		SceneManager.goto_room(target_room_path, name)
