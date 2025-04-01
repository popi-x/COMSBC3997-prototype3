extends Panel
@onready var game_manager = get_node("GameManager")
@onready var dialogue_text : RichTextLabel = get_node("DialogueText")
@onready var talk_input : TextEdit = get_node("PlayerTalkInput")
@onready var talk_button : Button = get_node("TalkButton")
var riddle = 0
var dead = false
var passMessage = false
var passed = false

func initialize_with_npc (npc):
	dialogue_text.text = ""
	talk_button.disabled = true
	

func _ready() -> void:
	visible = false

func _on_talk_button_pressed() -> void:
	if (passMessage):
		passMessage = false
		talk_input.visible = true
		if(passed):
			if (riddle == 1):
				_on_npc_talk("Rich people need it. Poor people have it. If you eat it, you die.")
			if (riddle == 2):
				_on_npc_talk("Which word in the dictionary is spelled incorrectly?")
			if(riddle == 3):
				visible = false
				# remove wizard and riddle collision box
				%riddleCollision.disabled = true
				%Wizard.get_node("AnimatedSprite2D").animation = "die"
				print("TODO")
		else:
			_on_npc_talk("")
	else:
		var userInput = talk_input.text
		#todo: branching with multiple riddles
		#todo: npc rxn to riddle
		_on_player_talk()
		var npcResponse = _on_npc_response(userInput)
		_on_npc_talk (npcResponse)
	
func _on_player_talk():
	talk_input.text = ""
	talk_button.disabled = true
	
func _on_npc_response(userInput):
	#todo: determine if user input is correct 
	if(riddle == 0):
		if(" n " in userInput.to_lower() or "n" in userInput.to_lower().split(" ")):
			passed = true
	elif(riddle == 1):
		if("nothing" in userInput.to_lower().split(" ")):
			passed = true
	elif(riddle == 2):
		if("incoectly" in userInput.to_lower().split(" ")):
			passed = true
	
	passMessage = true
	if(passed and riddle < 2):
		riddle += 1
		return("You have passed my riddle! On to the next one...")
	elif(passed and riddle == 2):
		riddle += 1
		return("You have passed my final riddle! You may proceed.")
	dead = true
	return("You have failed my riddle! Prepare to die.")
	
func _on_npc_talk (npc_dialogue):
	if(dead && !passMessage):
		#todo: add timer to give reader time to read
		#trigger fire animation and death 
		visible = false
		return
	dialogue_text.text = npc_dialogue
	talk_button.disabled = false
	if(passMessage):
		talk_input.visible = false
