extends Control

func _ready():
	var display_manga = preload("res://scenes/display_manga.tscn").instantiate()
	
	# 设置自定义路径
	display_manga.left_manga_path = "res://assets/samplemanga.png"
	display_manga.middle_manga_path = "res://assets/samplemanga.png"
	display_manga.right_manga_path = "res://assets/samplemanga.png"
	display_manga.next_scene_path = "res://scenes/title_screen.tscn"
	display_manga.ending_image_path = "res://assets/samplemanga.png"
	display_manga.show_ending_image = true
	
	add_child(display_manga)
