extends Area2D

func _on_body_entered(body: Node2D) -> void:
	print("you win!")
	get_tree().change_scene_to_file("res://scenes/end_screen.tscn")
