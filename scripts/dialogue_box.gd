extends Panel
@onready var game_manager = get_node("GameManager")
@onready var dialogue_text : RichTextLabel = get_node("DialogueText")
@onready var talk_input : TextEdit = get_node("PlayerTalkInput")
@onready var talk_button : Button = get_node("TalkButton")
var inRiddle = false
var intro1 = true
var intro2 = false
var riddle = 0
var dead = false
var passMessage = false
var passed = false
var nonos = ["fuck", "shit", "hell", "damn", "bitch"]

#todo: intro dialogue
#todo: if you say AI special dialogue
#todo: if you curse, special dialogue and you instantly die
#todo: in: cunty wizard, out: slayyyyy insta pass 

func initialize_with_npc (npc):
	dialogue_text.text = ""
	talk_button.disabled = true
	

func _ready() -> void:
	talk_input.visible = false
	visible = false

func _on_talk_button_pressed() -> void:
	if(intro1):
		intro1 = false
		intro2 = true
		_on_npc_talk("Answer my riddles three and pass. Fail and die.")
	elif(intro2):
		intro2 = false
		talk_input.visible = true
		_on_npc_talk("Take me from a window, leave a grieving wife. Stick me in a door, save a life. What am I?")
	elif (passMessage):
		passMessage = false
		talk_input.visible = true
		if(passed):
			if (riddle == 1):
				passed = false
				_on_npc_talk("Rich people need it. Poor people have it. If you eat it, you die.")
			if (riddle == 2):
				passed = false
				_on_npc_talk("Which word in the dictionary is spelled incorrectly?")
			if(riddle == 3):
				visible = false
				inRiddle = false
				# remove wizard and riddle collision box
				%riddleCollision.disabled = true
				%Wizard.get_node("AnimatedSprite2D").animation = "die"
				# todo: add delay to allow animation to play
				%Wizard.get_node("CollisionShape2D").disabled = true
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
	if(userInput == "you are cunty wizard"):
		passMessage = true
		passed = true
		riddle = 3
		return("Purrrrrrr you can pass!")
	if("ai" in userInput.to_lower().split(" ")):
		attack_and_die()
		passMessage = true
		return("You think being controlled by a real player makes you more privileged than me??!!! DIE!!!")
	if(userInput.to_lower() in nonos):
		attack_and_die()
		passMessage = true
		return("You said a bad thing. Prepare to die!")
	if(riddle == 0):
		if(" n " in userInput.to_lower() or "n" in userInput.to_lower().split(" ")):
			passed = true
	elif(riddle == 1):
		if("nothing" in userInput.to_lower().split(" ")):
			passed = true
	elif(riddle == 2):
		if("incorrectly" in userInput.to_lower().split(" ")):
			passed = true
	
	passMessage = true
	if(passed and riddle < 2):
		riddle += 1
		return("You have passed my riddle! On to the next one...")
	elif(passed and riddle == 2):
		riddle += 1
		return("You have passed my final riddle! You may proceed.")
		
	attack_and_die()
	return("You have failed my riddle! Prepare to die.")
	
func attack_and_die():
	%Wizard.get_node("AnimatedSprite2D").animation = "attack"
	%riddleCollision.disabled = true
	dead = true
func _on_npc_talk (npc_dialogue):
	if(dead && !passMessage):
		#todo: add timer to give reader time to read
		#trigger fire animation and death 
		visible = false
		await get_tree().create_timer(1).timeout
		get_tree().change_scene_to_file("res://scenes/level_1.tscn")
		return
	dialogue_text.text = npc_dialogue
	talk_button.disabled = false
	if(passMessage):
		talk_input.visible = false
