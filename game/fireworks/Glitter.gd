extends Node2D


const OVERLAPPING_SHOWERS = 4


export var color_set = -1 # -1 == random


var last_particles = null


onready var color_number = color_set if (color_set >= 0 && color_set < 6) else randi() % 6


func _ready():
	$ParticlesExplosion.one_shot = true
	for i in range(1, OVERLAPPING_SHOWERS):
		var particles = get_node("ParticlesShower0").duplicate()
		particles.name = "ParticlesShower%d" % i
		add_child(particles)
	$AudioStreamPlayer.play()
	$Timer.start()


func _process(delta):
	if last_particles != null && not last_particles.is_emitting():
		queue_free()


var i = 0
func _on_Timer_timeout():
	var particles = get_node("ParticlesShower%d" % i)
	particles.one_shot = true
	particles.color_ramp = load(str("res://colors/glitter_" + str(color_number) + ".tres"))
	particles.emitting = true
	last_particles = particles
	i += 1
	if i < OVERLAPPING_SHOWERS:
		$Timer.start()
