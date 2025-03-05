extends Area2D


func _on_body_entered(body: Node2D) -> void:
	print("new level")
	get_tree().change_scene_to_file("res://scenes/level_2.tscn")
