extends Node

# 获取节点引用
@onready var left_manga: TextureRect = $LeftManga
@onready var middle_manga: TextureRect = $MiddleManga
@onready var right_manga: TextureRect = $RightManga
@onready var ending_image: TextureRect = $EndingImage
@onready var continue_label: Label = $ContinueLabel  # 用于显示“按任意键以继续”的Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var left_biankuang = $LeftBiankuang
@onready var middle_kuang = $MiddleKuang
@onready var right_kuang = $RightKuang




# 自定义漫画路径
var left_manga_path: String = ""
var middle_manga_path: String = ""
var right_manga_path: String = ""
var next_scene_path: String = ""
var ending_image_path: String = ""
var show_ending_image: bool = false

# 定义计时器和步骤计数器
var timer: Timer
var current_step: int = 1  # 从1开始，因为第0步已经显示了第一个图片

func _ready():
	# 隐藏所有节点，除了左边的第一张图片
	left_manga.visible = true
	middle_manga.visible = false
	right_manga.visible = false
	continue_label.visible = false
	ending_image.visible = false
	left_biankuang.visible = false
	middle_kuang.visible = false
	right_kuang.visible = false
	
	# 加载自定义路径的漫画图片
	if left_manga_path != "":
		left_manga.texture = load(left_manga_path)
	if middle_manga_path != "":
		middle_manga.texture = load(middle_manga_path)
	if right_manga_path != "":
		right_manga.texture = load(right_manga_path)
	if ending_image_path != "":
		ending_image.texture = load(ending_image_path)

	# 播放第一个图片的淡入动画
	

	ending_image.visible = true

func _fade_in(node: CanvasItem):
	node.visible = true
	animation_player.play(node.name + "_fade_in")

func wait_seconds(seconds: float) -> void:
	var timer = Timer.new()
	timer.wait_time = seconds
	timer.one_shot = true
	add_child(timer)
	timer.start()
	await timer.timeout
	remove_child(timer)
	timer.queue_free()

func _input(event):
	if event is InputEventKey and event.pressed:
		# 跳转到自定义场景
		if next_scene_path != "":
			Globals.go_to_world(next_scene_path)
