extends Node2D


var random_mode = false
var orchestration_string = """fountain 0.2
fountain 0.8
wait 1000
rocket 0.4
wait 100
rocket 0.5
wait 100
rocket 0.6"""

var orchestration_array = []
var orchestration_index = 0
var split_instruction = RegEx.new()


onready var timer = $Timer
onready var screen_width = get_viewport().size.x
onready var screen_height = get_viewport().size.y


func _ready():
	if random_mode:
		continue_random()
	else:
		split_instruction.compile("(\\w+)( ([^\\s]+))+")
		orchestration_array = orchestration_string.split("\n")
		continue_orchestration()


func _on_Timer_timeout():
	if random_mode:
		continue_random()
	else:
		continue_orchestration()
	return


func continue_random():
	var newRocket = load("res://fireworks/Rocket.tscn").instance()
	newRocket.position = Vector2(rand_range(180, 1100), 720)
	newRocket.rotation_degrees = rand_range(-5, 5)
	newRocket.linear_velocity = Vector2(0, rand_range(-350, -400))
	add_child(newRocket)
	
	var newFountain = load("res://fireworks/Fountain.tscn").instance()
	newFountain.position = Vector2(rand_range(180, 1100), 720)
	add_child(newFountain)
	
	timer.wait_time = rand_range(1, 2)
	timer.start()


func continue_orchestration():
	if orchestration_index >= 0:
		var instruction = orchestration_array[orchestration_index]
		orchestration_index += 1
		if orchestration_index >= orchestration_array.size():
			orchestration_index = -1
		execute_instruction(instruction)


func execute_instruction(instruction):
	var result = split_instruction.search(instruction)
	var command = result.strings[1].to_lower()
	
	if command == "fountain":
		var x = float(result.strings[2])
		var newFountain = load("res://fireworks/Fountain.tscn").instance()
		newFountain.position = Vector2(screen_width * x, screen_height)
		add_child(newFountain)
	elif command == "rocket":
		var x = float(result.strings[2])
		var newRocket = load("res://fireworks/Rocket.tscn").instance()
		newRocket.position = Vector2(screen_width * x, screen_height)
		newRocket.rotation_degrees = rand_range(-5, 5)
		newRocket.linear_velocity = Vector2(0, rand_range(-350, -400))
		add_child(newRocket)
	
	if command == "wait":
		var time_ms = float(result.strings[2])
		timer.wait_time = time_ms / 1000
		timer.start()
	else:
		continue_orchestration()
