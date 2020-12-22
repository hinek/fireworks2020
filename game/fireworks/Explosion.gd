extends Node2D


const colors = [
	Color(0, 0, 1, 1),
	Color(0, 1, 0, 1),
	Color(0, 1, 1, 1),
	Color(1, 0, 0, 1),
	Color(1, 0, 1, 1),
	Color(1, 1, 0, 1)
]


onready var particles = $Particles


func _ready():
	var color = colors[randi() % colors.size()]
	particles.one_shot = true
	particles.color_ramp.colors[0] = color
	particles.color_ramp.colors[1] = color
	particles.hue_variation = 0.3
	particles.hue_variation_random = 0.5


func _process(delta):
	if not particles.is_emitting():
		queue_free()
