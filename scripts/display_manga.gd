extends Node

# 获取节点引用
@onready var left_manga: TextureRect = $LeftManga
@onready var middle_manga: TextureRect = $MiddleManga
@onready var right_manga: TextureRect = $RightManga
@onready var continue_label: Label = $ContinueLabel  # 用于显示“按任意键以继续”的Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# 自定义漫画路径
var left_manga_path: String = ""
var middle_manga_path: String = ""
var right_manga_path: String = ""
var next_scene_path: String = ""

# 定义计时器和步骤计数器
var timer: Timer
var current_step: int = 1  # 从1开始，因为第0步已经显示了第一个图片

func _ready():
	# 隐藏所有节点，除了左边的第一张图片
	left_manga.visible = true
	middle_manga.visible = false
	right_manga.visible = false
	continue_label.visible = false

	# 加载自定义路径的漫画图片
	if left_manga_path != "":
		left_manga.texture = load(left_manga_path)
	if middle_manga_path != "":
		middle_manga.texture = load(middle_manga_path)
	if right_manga_path != "":
		right_manga.texture = load(right_manga_path)

	# 播放第一个图片的淡入动画
	_fade_in(left_manga)
	
	# 创建并启动计时器
	timer = Timer.new()
	add_child(timer)
	timer.timeout.connect(self._on_timer_timeout)
	timer.start(1.0)  # 设置时间间隔（秒）

func _on_timer_timeout():
	# 根据当前步骤显示对应节点
	match current_step:
		1:
			_fade_in(middle_manga)
		2:
			_fade_in(right_manga)
		3:
			continue_label.visible = true
			# 连接输入事件
			set_process_input(true)
			timer.stop()  

	# 增加步骤计数
	current_step += 1

func _fade_in(node: CanvasItem):
	node.visible = true
	animation_player.play(node.name + "_fade_in")

func _input(event):
	if event is InputEventKey and event.pressed:
		# 跳转到自定义场景
		if next_scene_path != "":
			Globals.go_to_world(next_scene_path)
