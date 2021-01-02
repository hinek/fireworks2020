extends Node2D


const random_fountain_positions = [
	[0.25, 0.75],
	[],
	[0.5],
	[],
	[],
	[0.2],
	[0.4],
	[0.6],
	[0.8],
	[],
	[],
	[0.1, 0.9],
	[0.3, 0.7],
	[0.5],
	[],
	[]
]


var random_mode = true
var random_next_fountain_timer = 0
var random_fountain_index = 0
var orchestration_array = []
var orchestration_index = 0


onready var timer = $Timer
onready var screen_width = 1280 #get_viewport().size.x
onready var screen_height = 720 #get_viewport().size.y


func _ready():
	random_mode = Settings.random_mode
	if random_mode:
		timer.wait_time = 0.5
		continue_random()
	else:
		orchestration_array = Settings.current_show.split("\n")
		continue_orchestration()


func _input(event):
	if event.is_action_released("ui_cancel"):
		get_tree().change_scene("res://SetupScreen.tscn")


func _on_Timer_timeout():
	if random_mode:
		continue_random()
	else:
		continue_orchestration()
	return


func continue_random():
	if randi() % 2 == 0:
		var newRocket = load("res://fireworks/Rocket.tscn").instance()
		newRocket.position = Vector2(rand_range(screen_width / 10, screen_width * 9 / 10), screen_height)
		add_child(newRocket)
	
	if random_next_fountain_timer == 0:
		for position in random_fountain_positions[random_fountain_index]:
			var newFountain = load("res://fireworks/Fountain.tscn").instance()
			newFountain.position = Vector2(position * screen_width, screen_height)
			newFountain.lifetime_seconds = 6
			add_child(newFountain)
		random_fountain_index = (random_fountain_index + 1) % random_fountain_positions.size()
		random_next_fountain_timer = 4
	random_next_fountain_timer -= 1
	
	timer.start()


func continue_orchestration():
	if orchestration_index >= 0:
		var instruction = orchestration_array[orchestration_index]
		orchestration_index += 1
		if orchestration_index >= orchestration_array.size():
			orchestration_index = -1
		execute_instruction(instruction)


func execute_instruction(instruction):
	var result = instruction.split(" ", false)
	if result == null || result.size() < 2 || result[0].begins_with("#"):
		continue_orchestration()
		return
	var command = result[0].to_lower()
	
	if command == "fountain" || command == "rocket":
		var x = float(result[1])
		var newFirework = load("res://fireworks/" + command.capitalize() + ".tscn").instance()
		newFirework.position = Vector2(screen_width * x, screen_height)
		for i in range(2, result.size()):
			var set = result[i].split(":")
			if (set.size() == 2):
				newFirework.set_attribute(set[0], set[1])
		add_child(newFirework)
	
	if command == "wait":
		var time_ms = float(result[1])
		timer.wait_time = time_ms / 1000
		timer.start()
	else:
		continue_orchestration()
