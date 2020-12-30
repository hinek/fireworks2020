extends Node2D


var lifetime = 10
var target_velocity = 200


onready var particles = $Particles
onready var audio = $AudioStreamPlayer


func _ready():
	var color = randi() % 6
	particles.color_ramp = load(str("res://colors/" + str(color) + ".tres"))
	particles.hue_variation = 0.3
	particles.hue_variation_random = 0.5
	particles.initial_velocity = target_velocity / 10
	audio.volume_db = -10
	audio.play()
	$Timer.start(lifetime)


func _process(delta):
	particles.initial_velocity = lerp(particles.initial_velocity, target_velocity, delta)
	audio.volume_db = particles.initial_velocity / 20 - 10
	if particles.initial_velocity < 10:
		particles.emitting = false
		audio.stop()
	if particles.initial_velocity < 1:
		queue_free()


func _on_Timer_timeout():
	if particles.is_emitting():
		target_velocity = 0
		$Timer.start(particles.lifetime)
