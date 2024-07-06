#Global是控制整个游戏框架的脚本，包括背景音乐，页面和关卡的切换

extends Node

@onready var animation_player = $AnimationPlayer

#在各种地方都可以通过Globals.reload_world()来重置世界
func reload_world():
	animation_player.play_backwards("fade-in")
	await animation_player.animation_finished
	get_tree().reload_current_scene()
	animation_player.play("fade-in")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_esc"):
		back_to_title()

func _animate_transition_to(path):
	animation_player.play_backwards("fade-in")
	await animation_player.animation_finished
	if path:
		get_tree().change_scene_to_file(path)
	else:
		get_tree().reload_current_scene()
	
	animation_player.play("fade-in")

func start_game():
	go_to_world("res://game.tscn")

#到时候可以写保留什么东西等等
func go_to_world(path):
	_animate_transition_to(path)
	
func back_to_title():
	_animate_transition_to("res://scenes/title_screen.tscn")
