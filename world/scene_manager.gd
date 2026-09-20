extends Node


func goto_room(room_scene_path: String, door_name: String) -> void:
	_deferred_goto_room.call_deferred(room_scene_path, door_name)


func _deferred_goto_room(room_scene_path: String, door_name: String) -> void:
	var main: Main = get_tree().current_scene

	for child in main.world.get_children():
		child.free()

	var room: Room = load(room_scene_path).instantiate()
	main.world.add_child(room)

	var door: Door = room.get_node(door_name)
	main.player.global_position.x = door.marker.global_position.x

	apply_camera_limits(main, room)

	main.camera.global_position = main.player.global_position
	main.camera.reset_smoothing()


func apply_camera_limits(main: Main, room: Room) -> void:
	var tile_map_layer := room.tile_map_layer
	var used_rect := tile_map_layer.get_used_rect()
	var tile_size := Vector2(tile_map_layer.tile_set.tile_size)

	var top_left := tile_map_layer.to_global(Vector2(used_rect.position) * tile_size)
	var bottom_right := tile_map_layer.to_global(Vector2(used_rect.end) * tile_size)

	main.camera.limit_left = roundi(top_left.x)
	main.camera.limit_top = roundi(top_left.y)
	main.camera.limit_right = roundi(bottom_right.x)
	main.camera.limit_bottom = roundi(bottom_right.y)
