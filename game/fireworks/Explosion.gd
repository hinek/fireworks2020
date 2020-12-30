extends Node2D


onready var particles = $Particles


func _ready():
	particles.one_shot = true
	var color = randi() % 6
	particles.color_ramp = load(str("res://colors/" + str(color) + ".tres"))
	particles.hue_variation = 0.3
	particles.hue_variation_random = 0.5
	$AudioStreamPlayer.play()


func _process(delta):
	if not particles.is_emitting():
		queue_free()
