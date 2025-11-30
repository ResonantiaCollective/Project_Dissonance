extends Node2D

@onready var label := $Label
@onready var audio_player := $AudioStreamPlayer

var beat_interval := 0.5
var timer := 0.0
var beat_state := false

func _ready() -> void:
	print("Resonantia Prototype A1 ready.")
	if audio_player.stream:
		audio_player.play()
	label.text = "..."

func _process(delta: float) -> void:
	timer += delta
	if timer >= beat_interval:
		timer -= beat_interval
		beat_state = !beat_state
		if beat_state:
			label.text = "BEAT"
		else:
			label.text = ""
