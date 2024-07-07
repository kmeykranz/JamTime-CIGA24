extends ScrollContainer

@onready var blank: Control = $VBoxContainer/Blank
@onready var v_scroll: VScrollBar = get_v_scroll_bar()
@onready var h_scroll: HScrollBar = get_h_scroll_bar()

var previous_v_value: float = 0.0
var previous_h_value: float = 0.0
var max_scroll_speed: float = 1500.0  # 最大滚动速度，可以根据需要调整

func _ready() -> void:
	v_scroll.visible = false
	h_scroll.visible = false
	randomize()  # 初始化随机数生成器
	shuffle_children()
	hide_scrollbars()
	previous_v_value = v_scroll.value
	previous_h_value = h_scroll.value

func shuffle_children():
	# 获取子节点列表
	var children = []
	for child in get_vbox().get_children():
		if child is PanelContainer:
			children.append(child)
			
	# 打乱子节点列表顺序
	children.shuffle()
	
	# 清空 VBoxContainer
	clear_children()
	
	get_vbox().add_child(blank)
	# 重新添加子节点
	for child in children:
		get_vbox().add_child(child)

func clear_children():
	# 删除所有子节点
	for child in get_vbox().get_children():
		get_vbox().remove_child(child)

func hide_scrollbars():
	v_scroll.visible = false
	h_scroll.visible = false

# 获取 VBoxContainer 节点
func get_vbox():
	return $VBoxContainer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	limit_scroll_speed(delta)

func limit_scroll_speed(delta: float) -> void:
	# 限制垂直滚动速度
	var v_scroll_diff = v_scroll.value - previous_v_value
	if abs(v_scroll_diff) > max_scroll_speed * delta:
		v_scroll.value = previous_v_value + sign(v_scroll_diff) * max_scroll_speed * delta
	
	# 限制水平滚动速度
	var h_scroll_diff = h_scroll.value - previous_h_value
	if abs(h_scroll_diff) > max_scroll_speed * delta:
		h_scroll.value = previous_h_value + sign(h_scroll_diff) * max_scroll_speed * delta

	previous_v_value = v_scroll.value
	previous_h_value = h_scroll.value
