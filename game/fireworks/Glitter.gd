extends Node2D


export var color_set = -1 # -1 == random


onready var particles = $ParticlesShower


func _ready():
	$ParticlesExplosion.one_shot = true
	particles.one_shot = true
	var color_number = 0 #= color_set if (color_set >= 0 && color_set < 6) else randi() % 6
	particles.color_ramp = load(str("res://colors/glitter_" + str(color_number) + ".tres"))
	$AudioStreamPlayer.play()


func _process(delta):
	if not particles.is_emitting():
		queue_free()
