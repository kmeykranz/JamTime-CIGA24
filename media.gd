extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_post_liked(sender) -> void:
	print("Signal received from: ", sender.name)
	# 获取所有子节点
	var child_nodes = sender.get_children()
	# 遍历所有子节点
	for child in child_nodes:
		if child.name.begins_with("word"):
			print("name: ", child.get_meta("Word"))
			print("type: ", child.get_meta("Type"))
