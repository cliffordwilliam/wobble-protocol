class_name Main
extends Node

@onready var player: Player = $Player
@onready var camera: Camera2D = $PlayerCamera
@onready var world: Node2D = $World


func _ready() -> void:
	player.camera_transform.remote_path = player.camera_transform.get_path_to(camera)

	SceneManager.apply_camera_limits(self, world.get_child(0) as Room)

	camera.global_position = player.global_position
	camera.reset_smoothing()
