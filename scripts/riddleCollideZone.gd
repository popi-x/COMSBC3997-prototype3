extends Area2D

#@onready var timer: Timer = $Timer
#
func _on_body_entered(body: Node2D) -> void:
	%DialogueBox.visible = true
	%DialogueBox.inRiddle = true
