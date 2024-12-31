extends Node2D


@export var color_set = -1          # -1 == random
@export var lifetime_seconds = 10
@export var size_percent = 0.8


var target_velocity = 200.0


@onready var particles = $Particles
@onready var audio = $AudioStreamPlayer


func set_attribute(name, value):
	if name == "color":
		color_set = clamp(int(value), 0, 5)
	elif name == "lifetime":
		lifetime_seconds = clamp(float(value), 1.0, 86400)
	elif name == "size":
		size_percent = clamp(float(value), 0.35, 1.0)


func _ready():
	target_velocity = 250.0 * size_percent
	var color_number = color_set if (color_set >= 0 && color_set < 6) else randi() % 6
	particles.color_ramp = load(str("res://colors/" + str(color_number) + ".tres"))
	particles.initial_velocity_min = target_velocity
	particles.initial_velocity_max = target_velocity
	audio.volume_db = -20
	audio.play()
	$Timer.start(lifetime_seconds)


func _process(delta):
	var velocity = lerp(particles.initial_velocity_min, target_velocity, delta)
	particles.initial_velocity_min = velocity
	particles.initial_velocity_max = velocity
	audio.volume_db = velocity / 10 - 20
	if velocity < 10:
		particles.emitting = false
		audio.stop()
	if velocity < 1:
		queue_free()


func _on_Timer_timeout():
	if particles.is_emitting():
		target_velocity = 0.0
		$Timer.start(particles.lifetime)
