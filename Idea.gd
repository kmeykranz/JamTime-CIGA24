extends Panel

signal button_clicked(button)

@export var fade_duration := 1.0  # 设置淡出持续时间
# 获取面板的大小
var panel_size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	panel_size = size


func _on_media_liked(sender) -> void:
	# 获取所有子节点
	var child_nodes = sender.get_children()
	# 遍历所有子节点
	for child in child_nodes:
		if child.name.begins_with("word"):
			print("name: ", child.get_meta("Word"))
			print("type: ", child.get_meta("Type"))

	randomize() # 初始化随机数生成器
	
	# 遍历信息列表，为每条信息创建一个按钮并随机放置
	for child in child_nodes:
		if child.name.begins_with("word"):
			# 启动定时器，1秒后执行渐出效果
			var timer = Timer.new()
			timer.wait_time = 1.0
			timer.one_shot = true
			timer.connect("timeout", Callable(self, "_on_timer_timeout").bind(child))
			add_child(timer)
			timer.start()
			
# 当按钮被点击时调用的方法
func _on_button_pressed(button):
	print("Button pressed: ", button.text)
	emit_signal("button_clicked", button)
	button.queue_free()

func _on_timer_timeout(child)->void:
	var button = Button.new()
	button.text = child.get_meta("Word")
	button.set_meta("Type",child.get_meta("Type"))
	button.connect("pressed",Callable(self,"_on_button_pressed").bind(button))
	add_child(button)
	
	# 设置按钮的随机位置，确保不会超出面板边界
	var random_x = randi() % int(panel_size.x - button.size.x)
	var random_y = randi() % int(panel_size.y - button.size.y)
	button.position = Vector2(random_x, random_y)
	
	var out_timer = Timer.new()
	out_timer.wait_time = 4.0
	out_timer.one_shot = true
	out_timer.connect("timeout", Callable(self, "_on_out_timer_timeout").bind(button))
	add_child(out_timer)
	out_timer.start()

func _on_out_timer_timeout(button):
	if button != null:
		fade_and_remove_button(button)

func fade_and_add_button(button):
	var tween = get_tree().create_tween()
	tween.tween_property(button, "modulate", Color(1, 1, 1, 0), 1)
	tween.tween_callback(button.queue_free)
	
func fade_and_remove_button(button):
	var tween = get_tree().create_tween()
	tween.tween_property(button, "modulate", Color(1, 1, 1, 0), 1)
	tween.tween_callback(button.queue_free)

