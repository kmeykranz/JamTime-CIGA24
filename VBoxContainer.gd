extends VBoxContainer

@onready var blank: Control = $Blank

func _ready() -> void:
	randomize()  # 初始化随机数生成器
	shuffle_children()

func shuffle_children():
	# 获取子节点列表
	var children = []
	for child in get_children():
		if child is PanelContainer:
			children.append(child)
			
	# 打乱子节点列表顺序
	children.shuffle()
	
	# 清空 VBoxContainer
	clear_children()
	
	add_child(blank)
	# 重新添加子节点
	for child in children:
		add_child(child)

func clear_children():
	# 删除所有子节点
	for child in get_children():
		remove_child(child)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
