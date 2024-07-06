extends Panel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_idea_button_clicked(button: Variant) -> void:
	randomize() # 初始化随机数生成器
	
	# 获取面板的大小
	var panel_size = size
	
	var but = Button.new()
	but.text = button.text
	but.set_meta("Type",button.get_meta("Type"))
	add_child(but)
			
	# 设置按钮的随机位置，确保不会超出面板边界
	var random_x = randi() % int(panel_size.x - but.size.x)
	var random_y = randi() % int(panel_size.y - but.size.y)
	but.position = Vector2(random_x, random_y)
