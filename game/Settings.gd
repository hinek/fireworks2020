extends Node

const settings_file = "user://settings.save"
const max_shows = 3

var random_mode = false setget set_random_mode
var current_show = "" setget set_current_show
var saved_shows = ["", "", ""] setget set_saved_shows

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
	var f = File.new()
	f.open(settings_file, File.WRITE)
	f.store_var(random_mode)
	f.store_var(current_show)
	for show in saved_shows:
		f.store_var(show)
	f.close()

func load_settings():
	var f = File.new()
	if f.file_exists(settings_file):
		f.open(settings_file, File.READ)
		random_mode = f.get_var()
		current_show = f.get_var()
		for i in range(max_shows):
			saved_shows[i] = f.get_var()
		f.close()
