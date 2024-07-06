extends Panel

signal button_clicked(button)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_media_liked(sender) -> void:
	# 获取所有子节点
	var child_nodes = sender.get_children()
	# 遍历所有子节点
	for child in child_nodes:
		if child.name.begins_with("word"):
			print("name: ", child.get_meta("Word"))
			print("type: ", child.get_meta("Type"))

	randomize() # 初始化随机数生成器
	
	# 获取面板的大小
	var panel_size = size
	
	# 遍历信息列表，为每条信息创建一个按钮并随机放置
	for child in child_nodes:
		if child.name.begins_with("word"):
			var button = Button.new()
			button.text = child.get_meta("Word")
			button.set_meta("Type",child.get_meta("Type"))
			button.connect("pressed",Callable(self,"_on_button_pressed").bind(button))
			add_child(button)
			
			# 设置按钮的随机位置，确保不会超出面板边界
			var random_x = randi() % int(panel_size.x - button.size.x)
			var random_y = randi() % int(panel_size.y - button.size.y)
			button.position = Vector2(random_x, random_y)
			
# 当按钮被点击时调用的方法
func _on_button_pressed(button):
	print("Button pressed: ", button.text)
	emit_signal("button_clicked", button)
	button.queue_free()
