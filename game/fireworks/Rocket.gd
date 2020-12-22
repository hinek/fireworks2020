extends RigidBody2D


func _ready():
	linear_velocity = Vector2(0, linear_velocity.y).rotated(rotation)


func _process(delta):
	if linear_velocity.y > -100:
		var explosion = load("res://fireworks/Explosion.tscn").instance()
		explosion.position = position
		get_parent().add_child(explosion)
		queue_free()
