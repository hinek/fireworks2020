extends RigidBody2D


export var angle_modifier_percent = 0.0    # 0.0 = center / -1.0 left / 1.0 right
export var angle_random_percent = 0.5      # 0.0 = no random / 1.0 = max random

export var height_modifier_percent = 0.8   # 0.0 = min height / 1.0 = max height
export var height_random_percent = 0.5     # 0.0 = no random / 1.0 = max random

export var effect_name = "explosion"
export var effect_color_set = -1           # -1 == random
export var effect_lifetime_seconds = 2     # 0.5 .. 5.0


func set_attribute(name, value):
	if name == "angle":
		angle_modifier_percent = clamp(float(value), -1.0, 1.0)
	elif name == "arandom":
		angle_random_percent = clamp(float(value), 0.0, 1.0)
	elif name == "height":
		height_modifier_percent = clamp(float(value), 0.0, 1.0)
	elif name == "hrandom":
		height_random_percent = clamp(float(value), 0.0, 1.0)
	elif name == "effect":
		effect_name = value
	elif name == "color":
		effect_color_set = clamp(int(value), 0, 5)
	elif name == "lifetime":
		effect_lifetime_seconds = clamp(float(value), 0.5, 5.0)


func _ready():
	rotation_degrees = 5 * angle_modifier_percent + rand_range(-angle_random_percent * 3, angle_random_percent * 3)
	var height = height_modifier_percent * 100 + 300 + rand_range(-height_random_percent * 30, height_random_percent * 30)
	linear_velocity = Vector2(0, -height)
	linear_velocity = Vector2(0, linear_velocity.y).rotated(rotation)
	$AudioStreamPlayer.play()


func _process(delta):
	if linear_velocity.y > -100:
		var effect = load("res://fireworks/" + effect_name.capitalize() + ".tscn").instance()
		effect.position = position
		if "color_set" in effect:
			effect.color_set = effect_color_set
		if "lifetime_seconds" in effect:
			effect.lifetime_seconds = effect_lifetime_seconds
		get_parent().add_child(effect)
		queue_free()
