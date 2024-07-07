extends Control

func _ready():
	var display_manga = preload("res://scenes/display_manga.tscn").instantiate()
	
	# 设置自定义路径
	display_manga.left_manga_path = "res://assets/manga/start/start1.png"
	display_manga.middle_manga_path = "res://assets/manga/start/start2.png"
	display_manga.right_manga_path = "res://assets/manga/start/start1.png"
	display_manga.next_scene_path = "res://game.tscn"
	display_manga.ending_image_path = "res://assets/samplemanga.png"
	display_manga.show_ending_image = false
	
	add_child(display_manga)
