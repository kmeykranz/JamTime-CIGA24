extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	SoundManager.play_bgm("title")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_pressed():
	Globals.start_game()
	SoundManager.play_sfx("click")
	print("start")
