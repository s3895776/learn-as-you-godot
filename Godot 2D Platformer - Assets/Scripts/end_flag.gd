extends Area2D

@export var scene_to_load: PackedScene

func _on_body_entered(body: Node2D) -> void:
	
#	otherside requires a signal
	if not body.is_in_group("Player"):
		print(body.get_groups())
		return

	if scene_to_load == null:
		print("Error: No scene assigned!")
		return

	print("Player entered the area. Changing scene...")
	get_tree().change_scene_to_packed(scene_to_load)
