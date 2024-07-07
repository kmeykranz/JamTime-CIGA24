extends Control

@onready var timer: Timer = $Timer
@onready var clock: Label = $Clock_Text
@onready var output: Panel = $Output
@onready var didi = $didi
@onready var didididi = $didididi
@onready var state_image: TextureRect = $State_image
@onready var coffee_button: Button = $CoffeeButton

enum State{
	happy,
	sad,
}

var state:State
var type_num:int
var content_num:int
var time:int
var happy_time:int

func _ready() -> void:
	SoundManager.play_bgm("game")
	time=6
	clock.text=str(time)
	timer.start()
	state=State.happy
	happy_time=0
	coffee_button.disabled=true
	state_image.texture=load("res://assets/post/头像2.png")
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
		Globals.go_to_world("res://scenes/ending2.tscn")
	elif type_num>4||content_num>12:
		print("无法完成")
		Globals.go_to_world("res://scenes/ending1.tscn")
	else:
		print("大成功")
		Globals.go_to_world("res://scenes/ending3.tscn")
		
	
func _on_button_pressed() -> void:
	SoundManager.play_sfx("click")
	finish()

func _on_timer_timeout() -> void:
	time-=1
	clock.text=str(time)
	if time==0:
		didididi.play()
		finish()
	else: 
		didi.play()
		
	happy_time+=1
	if happy_time==2:
		state=State.sad
		state_image.texture=load("res://assets/post/头像1.png")
		coffee_button.disabled=false

func _on_coffee_button_pressed() -> void:
	state=State.happy
	happy_time=0
	state_image.texture=load("res://assets/post/头像2.png")
	coffee_button.disabled=true
	
