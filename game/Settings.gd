extends Node

const settings_file = "user://settings.save"
const max_shows = 3

var random_mode = false: set = set_random_mode
var current_show = "": set = set_current_show
var saved_shows = ["", "", ""]: set = set_saved_shows

func _ready():
	load_settings()

func set_random_mode(value):
	random_mode = value
	save_settings()

func set_current_show(value):
	current_show = value
	save_settings()

func set_saved_shows(value):
	saved_shows = value
	save_settings()

func save_settings():
	var f = FileAccess.open(settings_file, FileAccess.WRITE)
	f.store_var(random_mode)
	f.store_var(current_show)
	for show in saved_shows:
		f.store_var(show)
	f.close()

func load_settings():
	if FileAccess.file_exists(settings_file):
		var f = FileAccess.open(settings_file, FileAccess.READ)
		random_mode = f.get_var()
		current_show = f.get_var()
		for i in range(max_shows):
			saved_shows[i] = f.get_var()
		f.close()
