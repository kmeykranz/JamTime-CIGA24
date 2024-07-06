extends Node

@onready var sfx_player = $SFX
@onready var bgm_player = $BGM
@onready var animation_player = $AnimationPlayer

var current_bgm: AudioStream = null
@export var fade_duration := 1.0  # 淡入淡出持续时间

# 音效资源路径字典
var sfx_paths = {
	"alarm": "res://assets/sound/sfx/alarm.mp3",
	"alarm-single": "res://assets/sound/sfx/alarm-single.mp3",
	"click": "res://assets/sound/sfx/click.mp3",
	"clocking": "res://assets/sound/sfx/clocking.mp3",
	"collect": "res://assets/sound/sfx/collect.mp3",
	"inspire1": "res://assets/sound/sfx/inspire/inspire1.mp3",
	"inspire2": "res://assets/sound/sfx/inspire/inspire2.mp3",
	"inspire3": "res://assets/sound/sfx/inspire/inspire3.mp3",
	"inspire4": "res://assets/sound/sfx/inspire/inspire4.mp3",
	"inspire5": "res://assets/sound/sfx/inspire/inspire5.mp3",
	"inspire6": "res://assets/sound/sfx/inspire/inspire6.mp3",
	
}

# 背景音乐资源路径字典
var bgm_paths = {
	"game": "res://assets/sound/bgm/72seconds.mp3",
	"endFew": "res://assets/sound/bgm/endFew.mp3",
	"endSuccess": "res://assets/sound/bgm/endSuccess.mp3",
	"endTooMuch": "res://assets/sound/bgm/endTooMuch.mp3",
	"title": "res://assets/sound/bgm/titleScreen.mp3",
}

# 播放背景音乐
func play_bgm(bgm_name: String) -> void:
	if bgm_name in bgm_paths:
		var bgm = load(bgm_paths[bgm_name])
		if bgm and current_bgm != bgm:
			if bgm_player.playing:
				bgm_player.stop()
			if bgm is AudioStream:
				var audio_stream = bgm as AudioStream
				audio_stream.loop = true  # 设置音频流的循环播放属性
				current_bgm = audio_stream
				bgm_player.stream = current_bgm
				bgm_player.play()
		else:
			print("Failed to load background music: " + bgm_name)
	else:
		print("Background music not found: " + bgm_name)

# 播放音效
func play_sfx(sfx_name: String) -> void:
	if sfx_name in sfx_paths:
		var sfx = load(sfx_paths[sfx_name])
		if sfx:
			sfx_player.stream = sfx
			sfx_player.play()
		else:
			print("Failed to load sound effect: " + sfx_name)
	else:
		print("Sound effect not found: " + sfx_name)
