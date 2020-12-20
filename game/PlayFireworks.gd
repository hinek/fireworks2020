extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Explosion.one_shot = true
	$Explosion.emitting = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	$Explosion.emitting = false
	$Explosion.position = Vector2(rand_range(50, 1150), rand_range(50, 300))
	$Explosion.emitting = true
