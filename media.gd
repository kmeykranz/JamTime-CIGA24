extends Control

signal liked()


func _on_post_liked(sender) -> void:
	print("Signal received from: ", sender.name)
	emit_signal("liked",sender)
