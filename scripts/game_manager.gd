extends Node

var score = 0
var battery_count = 0

@onready var label: Label = $"../CanvasLayer/ScoreLabel"
@onready var battery_num: Label = $"../CanvasLayer/BatteryCounter/BatteryNum"

func modify_battery(num: int):
	battery_count += num
	update_battery_label()

func add_point():
	score += 1
	update_score_label()

func update_score_label():
	label.text = "Score: " + str(score)
	
func update_battery_label():
	battery_num.text = " x " + str(battery_count)
	
func new_level():
	score = 0
	battery_count = 0
	update_score_label()
	update_battery_label()
	
