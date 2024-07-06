extends Panel

signal button_clicked(button)

@export var fade_duration := 1.0  # 设置淡出持续时间
@export var batch_interval := 4.0  # 每批灵感的生成间隔时间
@export var button_display_duration := 4.0  # 按钮显示时间
@export var max_random_delay := 1.0  # 每个按钮的最大随机延迟时间

# 获取面板的大小
var panel_size
var inspiration_queue = []  # 队列用于存储灵感数据

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	panel_size = size

	# 创建一个定时器来定期处理灵感队列
	var batch_timer = Timer.new()
	batch_timer.wait_time = batch_interval
	batch_timer.one_shot = false
	batch_timer.connect("timeout", Callable(self, "_process_inspiration_batch"))
	add_child(batch_timer)
	batch_timer.start()

func _on_media_liked(sender) -> void:
	# 获取所有子节点
	var child_nodes = sender.get_children()
	# 遍历所有子节点
	for child in child_nodes:
		if child.name.begins_with("word"):
			print("name: ", child.get_meta("Word"))
			print("type: ", child.get_meta("Type"))
			# 将灵感数据添加到队列中
			inspiration_queue.append({"word": child.get_meta("Word"), "type": child.get_meta("Type")})

func _process_inspiration_batch():
	randomize() # 初始化随机数生成器
	
	# 遍历灵感队列，为每条灵感创建一个按钮并随机放置
	while inspiration_queue.size() > 0:
		var inspiration = inspiration_queue.pop_front()
		_create_inspiration_button_with_delay(inspiration)

func _create_inspiration_button_with_delay(inspiration):
	# 创建一个定时器来延迟按钮的创建
	var delay_timer = Timer.new()
	delay_timer.wait_time = randf() * max_random_delay
	delay_timer.one_shot = true
	delay_timer.connect("timeout", Callable(self, "_create_inspiration_button").bind(inspiration))
	add_child(delay_timer)
	delay_timer.start()

func _create_inspiration_button(inspiration):
	var button = Button.new()
	button.text = inspiration["word"]
	button.set_meta("Type", inspiration["type"])
	button.connect("pressed", Callable(self, "_on_button_pressed").bind(button))
	add_child(button)
	
	# 设置按钮的随机位置，确保不会超出面板边界
	var random_x = randi() % int(panel_size.x - button.size.x)
	var random_y = randi() % int(panel_size.y - button.size.y)
	button.position = Vector2(random_x, random_y)
	
	# 随机选择并播放一个inspire音效
	var random_inspire = "inspire" + str(randi() % 6 + 1)
	SoundManager.play_sfx(random_inspire)
	
	# 设置一个定时器来处理按钮的淡出和移除
	var out_timer = Timer.new()
	out_timer.wait_time = button_display_duration
	out_timer.one_shot = true
	out_timer.connect("timeout", Callable(self, "_on_out_timer_timeout").bind(button))
	add_child(out_timer)
	out_timer.start()

func _on_button_pressed(button):
	print("Button pressed: ", button.text)
	emit_signal("button_clicked", button)
	button.queue_free()
	SoundManager.play_sfx("collect")

func _on_out_timer_timeout(button):
	if button != null:
		fade_and_remove_button(button)

func fade_and_remove_button(button):
	var tween = get_tree().create_tween()
	tween.tween_property(button, "modulate", Color(1, 1, 1, 0), fade_duration)
	tween.tween_callback(Callable(button.queue_free))
