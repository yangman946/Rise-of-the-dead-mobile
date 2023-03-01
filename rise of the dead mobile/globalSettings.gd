extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"



var music_volume = 100.0
var fx_volume = 100.0


var config = ConfigFile.new()
var prefs = config.load("user://prefs.cfg")

# Called when the node enters the scene tree for the first time.
func _ready():
	if prefs != OK:
		print("error")
		apply()
		return
	

	music_volume = config.get_value("user", "mv")
	fx_volume = config.get_value("user", "fxv")
	apply()
	pass # Replace with function body.

func save():

	config.set_value("user", "mv", music_volume)
	config.set_value("user", "fxv", fx_volume)
	
	config.save("user://prefs.cfg")
	pass
	
func apply():

		
	MusicPlayer.updateMusic(music_volume)
	MusicPlayer.updateSfx(fx_volume)

	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
