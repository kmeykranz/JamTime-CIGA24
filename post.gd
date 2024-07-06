extends PanelContainer

@export var name_text:String
@export var content_text:String
@export var head_number:String #头像的序号(填数字1-7)
@export var image_path:String
@onready var content: Label = $Panel/content
@onready var name_node: Label = $Panel/name
@onready var head_rect: TextureRect = $Panel/head/TextureRect
@onready var image_rect: TextureRect = $Panel/head/TextureRect

signal liked()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	name_node.text=name_text
	content.text=content_text
	if head_number:
		head_rect.texture=load("res://assets/post/头像"+head_number+".png")
	if image_path:
		image_rect.texture=load("res://assets/image/"+image_path)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_like_pressed() -> void:
	emit_signal("liked",self)
	pass # Replace with function body.
