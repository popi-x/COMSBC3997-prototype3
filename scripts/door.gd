extends Area2D
@onready var game_manager: Node = %GameManager


func _on_body_entered(body: Node2D) -> void:
	print("new level")
	game_manager.new_level()
	get_tree().change_scene_to_file("res://scenes/level_2.tscn")
