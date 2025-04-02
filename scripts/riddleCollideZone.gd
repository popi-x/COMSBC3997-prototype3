extends Area2D

func _on_body_entered(body: Node2D) -> void:
	%DialogueBox.visible = true
	%DialogueBox.inRiddle = true
		
