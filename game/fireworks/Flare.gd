extends Node2D


export var color_set = -1          # -1 == random
export var lifetime_seconds = 10
export var size_percent = 0.8


var number_left = 0
var last_particle = null


onready var particles = $Particles
onready var audio = $AudioStreamPlayer


func set_attribute(name, value):
	if name == "color":
		color_set = clamp(int(value), 0, 5)
	elif name == "lifetime":
		lifetime_seconds = clamp(float(value), 1.0, 86400)
	elif name == "size":
		size_percent = clamp(float(value), 0.35, 1.0)


func _ready():
	number_left = lifetime_seconds
	particles.one_shot = true
	particles.emitting = false
	particles.initial_velocity = 250 * size_percent
	particles.lifetime = 5 * size_percent
	spawn_new_particle()
	$Timer.start()


func _on_Timer_timeout():
	number_left -= 1
	if number_left > 0:
		spawn_new_particle()
	if !last_particle.is_emitting():
		queue_free()


func spawn_new_particle():
	var color_number = color_set if (color_set >= 0 && color_set < 6) else randi() % 6
	var newParticle = particles.duplicate()
	newParticle.name = "particles%d" % number_left
	newParticle.color_ramp = load(str("res://colors/" + str(color_number) + ".tres"))
	newParticle.emitting = true
	last_particle = newParticle
	add_child(newParticle)
	var newAudio = audio.duplicate()
	add_child(newAudio)
	newAudio.play()
