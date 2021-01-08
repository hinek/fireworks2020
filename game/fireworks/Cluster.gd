extends Node2D


export var color_set = -1 # -1 == random
export var lifetime_seconds = 2


var second_stage_type = load("res://fireworks/ClusterSecondStage.tscn")
var explosion_type = load("res://fireworks/Explosion2.tscn")
var initial_child_count = 0


func _ready():
	initial_child_count = get_child_count()
	for i in range(-3, 4):
		var second_stage = second_stage_type.instance()
		second_stage.name = "sec%d" % i
		second_stage.linear_velocity = Vector2(0, -150).rotated(i * 0.2)
		add_child(second_stage)
	$AudioStreamPlayer.play()
	$Timer.wait_time = lifetime_seconds
	$Timer.start()


func _process(delta):
	if get_child_count() == initial_child_count:
		queue_free()


func _on_Timer_timeout():
	for child in get_children():
		if child.name.begins_with("sec"):
			var explosion = explosion_type.instance()
			explosion.name = "expl_" + child.name
			explosion.position = child.position
			explosion.color_set = color_set
			add_child(explosion)
			child.queue_free()
