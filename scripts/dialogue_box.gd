extends Panel
@onready var game_manager = get_node("GameManager")
@onready var dialogue_text : RichTextLabel = get_node("DialogueText")
@onready var talk_input : TextEdit = get_node("PlayerTalkInput")
@onready var talk_button : Button = get_node("TalkButton")

func initialize_with_npc (npc):
	dialogue_text.text = ""
	talk_button.disabled = true
	dialogue_text.visible = false
	



func _on_talk_button_pressed() -> void:
	pass # Replace with function
	
func _on_player_talk():
	talk_input.text = ""
	talk_button.disabled = true
	
func _on_npc_talk (npc_dialogue):
	dialogue_text = npc_dialogue
	talk_button.disabled = false
