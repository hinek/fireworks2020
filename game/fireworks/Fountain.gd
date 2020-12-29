extends Node2D


var lifetime = 10


onready var particles = $Particles


func _ready():
	var color = randi() % 6
	particles.color_ramp = load(str("res://colors/" + str(color) + ".tres"))
	particles.hue_variation = 0.3
	particles.hue_variation_random = 0.5
	$Timer.start(lifetime)


func _on_Timer_timeout():
	if particles.is_emitting():
		particles.emitting = false
		$Timer.start(particles.lifetime)
	else:
		queue_free()
