extends Control

@onready var timer: Timer = $Timer
@onready var clock: Label = $Clock
@onready var output: Panel = $Output
var type_num:int
var content_num:int
var time:int

func _ready() -> void:
	time=24
	clock.text=str(time)
	timer.start()
	pass

func finish() -> void:
	type_num=0
	content_num=0
	
	var words=output.get_children()
	for word in words:
		if word.get_meta("Type")=="类型":
			type_num+=1
		else:
			content_num+=1
	
	#结局分支逻辑（在这里放结局切换）
	if type_num<1||content_num<6:
		print("完成度低")
	elif type_num>4||content_num>12:
		print("无法完成")
	else:
		print("大成功")
	
func _on_button_pressed() -> void:
	finish()

func _on_timer_timeout() -> void:
	time-=1
	clock.text=str(time)
	if time==0:
		finish()
