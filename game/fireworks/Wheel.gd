extends Node2D


export var height = 0.5            # 0.0 = min height / 1.0 = max height
export var color_set = -1          # -1 == random
export var booster_count = 2       # 2 .. 10
export var radius_percent = 0.8    # 0.2 = min radius / 1.0 = max radius
export var lifetime_seconds = 7


var angle = 0
var speed = 0
var phase = 1


onready var offset = 2 * PI / booster_count
onready var radius = 150 * radius_percent


func set_attribute(name, value):
	if name == "height":
		height = clamp(float(value), 0, 1)
	elif name == "color":
		color_set = clamp(int(value), 0, 5)
	elif name == "count":
		booster_count = clamp(int(value), 2, 10)
	elif name == "lifetime":
		lifetime_seconds = clamp(float(value), 1.0, 86400)
	elif name == "size":
		radius_percent = clamp(float(value), 0.2, 1.0)


func _ready():
	position.y = get_parent().screen_height * (1 - height)
	var color_number = color_set if (color_set >= 0 && color_set < 6) else randi() % 6
	$Booster0.color_ramp = load(str("res://colors/" + str(color_number) + ".tres"))
	for i in range(1, booster_count):
		var booster = $Booster0.duplicate()
		booster.name = "Booster%d" % i
		add_child(booster)
	configure_boosters()
	$Timer.wait_time = lifetime_seconds
	$Timer.start()
	$AudioStreamPlayer.play()


func _process(delta):
	if phase == 1 && speed < 5:
		speed += delta * 2
		$AudioStreamPlayer.volume_db = speed * 2 - 10
	elif phase == 2 && $AudioStreamPlayer.volume_db > -80:
		$AudioStreamPlayer.volume_db -= delta * 100
	
	angle += delta * speed
	if angle > 2 * PI:
		angle -= 2 * PI
	configure_boosters()


func configure_boosters():
	for i in range(0, booster_count):
		var booster = get_node("Booster%d" % i)
		booster.position = Vector2(radius, 0).rotated(angle + i * offset)
		booster.direction = Vector2(0, -1).rotated(angle + i * offset)


func _on_Timer_timeout():
	if phase == 1:
		for i in range(0, booster_count):
			var booster = get_node("Booster%d" % i)
			booster.emitting = false
		phase = 2
		$Timer.wait_time = 1
		$Timer.start()
	elif phase == 2:
		queue_free()
