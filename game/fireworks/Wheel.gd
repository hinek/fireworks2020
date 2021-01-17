extends Node2D


export var height = 0.5            # 0.0 = min height / 1.0 = max height
export var color_set = -1          # -1 == random
export var booster_count = 2       # 2 .. 10
export var radius_percent = 0.8    # 0.2 = min radius / 1.0 = max radius


var angle = 0


onready var offset = 2 * PI / booster_count
onready var radius = 150 * radius_percent


func set_attribute(name, value):
	if name == "height":
		height = clamp(float(value), 0, 1)
	elif name == "color":
		color_set = clamp(int(value), 0, 5)
	elif name == "count":
		booster_count = clamp(int(value), 2, 10)
	#elif name == "lifetime":
		#lifetime_seconds = clamp(float(value), 1.0, 86400)
	elif name == "size":
		radius_percent = clamp(float(value), 0.2, 1.0)


# Called when the node enters the scene tree for the first time.
func _ready():
	position.y = get_parent().screen_height * height
	for i in range(1, booster_count):
		var booster = $Booster0.duplicate()
		booster.name = "Booster%d" % i
		add_child(booster)
	configure_boosters()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	angle += delta * 4
	if angle > 2 * PI:
		angle -= 2 * PI
	configure_boosters()
	#$Booster0.position = Vector2(radius, 0).rotated(angle)
	#$Booster0.direction = Vector2(0, -1).rotated(angle)


func configure_boosters():
	for i in range(0, booster_count):
		var booster = get_node("Booster%d" % i)
		booster.position = Vector2(radius, 0).rotated(angle + i * offset)
		booster.direction = Vector2(0, -1).rotated(angle + i * offset)
