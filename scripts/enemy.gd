extends Node2D

const SPEED = 50

var direction = 1
@export var right_limit: float = 10000000
@export var left_limit: float = -10000000

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_left_down: RayCast2D = $RayCastLeftDown
@onready var ray_cast_right_down: RayCast2D = $RayCastRightDown


func _process(delta):
	if ray_cast_right.is_colliding() or not ray_cast_right_down.is_colliding() or position.x > right_limit:
		direction = -1
		animated_sprite.flip_h = true
	if ray_cast_left.is_colliding() or not ray_cast_left_down.is_colliding() or position.x <= left_limit:
		direction = 1
		animated_sprite.flip_h = false
	position.x += direction * SPEED * delta
