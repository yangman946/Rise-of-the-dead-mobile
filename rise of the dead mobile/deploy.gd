extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var mousePos
var ind;
var valid = false
var special = false
signal instanced(index)

var so;

onready var sfx = get_node("sfx")
var move = false

# Called when the node enters the scene tree for the first time.
func _ready():
	mousePos = get_global_mouse_position()
	position = mousePos
	pass # Replace with function body.

func playaudio(sound):
	MusicPlayer.playaudio(sound)


		
func init(index, deployImg, s):
	self.ind = index
	self.special = s
	self.get_node("Sprite").texture = load(deployImg)
	self.move = false
	pass
	
func moveInit(soldier, sprite):
	self.move = true
	self.get_node("Sprite").texture = load(sprite)
	self.so = soldier
	


func valid():
	valid = true
	get_node("Sprite").modulate = Color(0, 1, 0, 0.7)

func invalid():
	valid = false
	get_node("Sprite").modulate = Color(1, 0, 0, 0.7)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_mouse_button_pressed(1):
		mousePos = get_global_mouse_position()
		position = mousePos
	else:
		if valid:
			playaudio("res://audio/deploy.wav")
			if move:
				
				get_tree().get_root().get_node("map").cancel()
				so.newDestination(global_position.x)
				
			else:
				get_tree().get_root().get_node("map").confirm(ind, global_position.x, special)
				emit_signal("instanced", ind)
			queue_free()
		else:

			if move:
				get_tree().get_root().get_node("map").setToolTip("Cancelled Move!")
			else:
				get_tree().get_root().get_node("map").setToolTip("Cancelled Deployment!")
			get_tree().get_root().get_node("map").cancel()
			queue_free()
	
	if position.x > -164 and position.x < 4580 and position.y < -23 and position.y > - 140:
		valid()
	else:
		
		invalid()
	
	#print(mousePos)
	pass


