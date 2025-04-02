extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -240.0

var max_jumps = 1
var jump_count = 0


@onready var animated_sprite = $AnimatedSprite2D
@onready var game_manager: Node = %GameManager


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if(!(get_tree().get_current_scene().name == "Level1_5" and %DialogueBox.inRiddle)):
		update_jump_ability()
		# Add the gravity.
		

		# Handle jump.
		if is_on_floor():
			jump_count = 0
		if Input.is_action_just_pressed("jump") and jump_count < max_jumps:
			velocity.y = JUMP_VELOCITY
			jump_count += 1
			if jump_count == 2:
				game_manager.modify_battery(-1)
		if Input.is_action_just_pressed("restart"):
			get_tree().reload_current_scene()

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction := Input.get_axis("move_left", "move_right")
		
		# Flip the sprite
		if direction > 0:
			animated_sprite.flip_h = false
		elif direction < 0:
			animated_sprite.flip_h = true
			
		# Play animations
		if is_on_floor():
			if direction == 0:
				animated_sprite.play("idle")
			else:
				animated_sprite.play("run")
		else:
			animated_sprite.play("jump")
			
		
		# Apply movement
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			
	else:
		velocity.x = 0

	move_and_slide()
	
func update_jump_ability():
	if game_manager.battery_count > 0:
		max_jumps = 2
	else:
		max_jumps = 1
