extends Control

signal liked()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_post_liked(sender) -> void:
	print("Signal received from: ", sender.name)
	emit_signal("liked",sender)
