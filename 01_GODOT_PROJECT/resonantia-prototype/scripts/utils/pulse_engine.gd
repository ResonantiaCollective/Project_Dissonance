extends Node
class_name PulseEngine

signal beat
signal half_beat
signal measure

var bpm: float = 120.0
var _beat_timer: Timer
var _beat_count: int = 0

func _ready() -> void:
	_beat_timer = Timer.new()
	_beat_timer.one_shot = false
	add_child(_beat_timer)
	_beat_timer.timeout.connect(_on_beat_timeout)
	_update_timer()
	_beat_timer.start()

func set_bpm(new_bpm: float) -> void:
	if new_bpm <= 0.0:
		return
	bpm = new_bpm
	_update_timer()

func _update_timer() -> void:
	var interval := 60.0 / bpm
	_beat_timer.wait_time = interval

func _on_beat_timeout() -> void:
	_beat_count += 1
	emit_signal("beat")

	# Half beat as simple toggle
	if _beat_count % 2 == 0:
		emit_signal("half_beat")

	# Measure every 4 beats for now (can be configurable later)
	if _beat_count % 4 == 0:
		emit_signal("measure")
