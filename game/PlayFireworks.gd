extends Node2D


func _ready():
	pass


func _on_Timer_timeout():
	var newRocket = load("res://fireworks/Rocket.tscn").instance()
	newRocket.position = Vector2(rand_range(180, 1100), 720)
	newRocket.rotation_degrees = rand_range(-5, 5)
	newRocket.linear_velocity = Vector2(0, rand_range(-350, -400))
	add_child(newRocket)
	
	var newFountain = load("res://fireworks/Fountain.tscn").instance()
	newFountain.position = Vector2(rand_range(180, 1100), 720)
	add_child(newFountain)
	pass
