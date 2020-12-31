extends Node2D


export var color_set = -1          # -1 == random
export var lifetime_seconds = 10
export var size_percent = 0.8


var target_velocity = 200


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
	target_velocity = 250 * size_percent
	var color_number = color_set if (color_set >= 0 && color_set < 6) else randi() % 6
	particles.color_ramp = load(str("res://colors/" + str(color_number) + ".tres"))
	particles.initial_velocity = target_velocity / 10
	audio.volume_db = -20
	audio.play()
	$Timer.start(lifetime_seconds)


func _process(delta):
	particles.initial_velocity = lerp(particles.initial_velocity, target_velocity, delta)
	audio.volume_db = particles.initial_velocity / 10 - 20
	if particles.initial_velocity < 10:
		particles.emitting = false
		audio.stop()
	if particles.initial_velocity < 1:
		queue_free()


func _on_Timer_timeout():
	if particles.is_emitting():
		target_velocity = 0
		$Timer.start(particles.lifetime)
