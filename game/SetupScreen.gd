extends Control


func _ready():
	if Settings.current_show == null || Settings.current_show == "":
		_on_LoadDemo_pressed()
	else:
		$TextEdit.text = Settings.current_show


func _on_StartOrchestrated_pressed():
	Settings.current_show = $TextEdit.text
	Settings.random_mode = false
	get_tree().change_scene("res://PlayFireworks.tscn")


func _on_StartRandom_pressed():
	Settings.random_mode = true
	get_tree().change_scene("res://PlayFireworks.tscn")


func _on_SaveShow_pressed(show_number):
	Settings.saved_shows[show_number - 1] = $TextEdit.text


func _on_LoadShow_pressed(show_number):
	$TextEdit.text = Settings.saved_shows[show_number - 1]


func _on_LoadDemo_pressed():
	$TextEdit.text = """# use this to prepare your personal fireworks
# see instructions at the right side

# let's start simple
fountain 0.2 color:1 size:1.0
fountain 0.8 color:1 size:1.0
wait 1000
rocket 0.5 arandom:0
wait 500
rocket 0.6 arandom:0 angle:1.0
wait 500
rocket 0.4 arandom:0 angle:-1.0
wait 2000
rocket 0.1 color:0
rocket 0.9 color:0
wait 3000

# now more rockets
rocket 0.5 color:3
wait 500
rocket 0.45 color:3
wait 500
rocket 0.55 color:3
wait 500
fountain 0.1 color:0
wait 500
fountain 0.3 color:2
wait 500
fountain 0.5 color:3
wait 500
fountain 0.7 color:4
wait 500
fountain 0.9 color:5
wait 500

# rockets at the sides
rocket 0.2
rocket 0.8
wait 100
rocket 0.2
rocket 0.8
wait 100
rocket 0.2
rocket 0.8
wait 3000

# rockets closer to the middle
rocket 0.4
rocket 0.6
wait 100
rocket 0.4
rocket 0.6
wait 100
rocket 0.4
rocket 0.6
wait 3000

# rocket zig zag
rocket 0.2
wait 300
rocket 0.4
wait 300
rocket 0.6
wait 300
rocket 0.8
wait 300
rocket 0.6
wait 300
rocket 0.4
wait 300
rocket 0.2
wait 300
rocket 0.4
wait 300
rocket 0.6
wait 300
rocket 0.8
wait 3000

# big bang
rocket 0.5
wait 100
rocket 0.5
wait 100
rocket 0.5
wait 5000

# surprise double zig zag
rocket 0.1
rocket 0.9
wait 500
rocket 0.2
rocket 0.8
wait 500
rocket 0.3
rocket 0.7
wait 500
rocket 0.4
rocket 0.6
wait 500
rocket 0.5
rocket 0.5
wait 500
rocket 0.6
rocket 0.4
wait 500
rocket 0.7
rocket 0.3
wait 500
rocket 0.8
rocket 0.2
wait 500
rocket 0.9
rocket 0.1
wait 3000

# more fountains
fountain 0.1 color:0
fountain 0.9 color:0
wait 800
fountain 0.2 color:1
fountain 0.8 color:1
wait 800
fountain 0.3 color:2
fountain 0.7 color:2
wait 800
fountain 0.4 color:3
fountain 0.6 color:3
wait 800
fountain 0.5 color:4
fountain 0.5 color:4
rocket 0.15
rocket 0.85
wait 800
fountain 0.6 color:1
fountain 0.4 color:1
rocket 0.25
rocket 0.75
wait 800
fountain 0.7 color:2
fountain 0.3 color:2
rocket 0.35
rocket 0.65
wait 800
fountain 0.8 color:3
fountain 0.2 color:3
rocket 0.45
rocket 0.55
wait 800
fountain 0.9 color:4
fountain 0.1 color:4
wait 3000

# rockets inwards
rocket 0.15
rocket 0.85
wait 1000
rocket 0.25
rocket 0.75
wait 1000
rocket 0.35
rocket 0.65
wait 1000
rocket 0.45
rocket 0.55
wait 3000

# 3 big bangs (left, right, center)
rocket 0.25
wait 100
rocket 0.25
wait 100
rocket 0.25
wait 2500
rocket 0.75
wait 100
rocket 0.75
wait 100
rocket 0.75
wait 2500
rocket 0.5
wait 100
rocket 0.5
wait 100
rocket 0.5"""
