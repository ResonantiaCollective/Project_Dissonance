extends Node
class_name PulseEngine

signal beat(beat_index: int, beat_time: float)
signal half_beat(beat_index: int, beat_time: float)
signal measure(measure_index: int, beat_time: float)

@export var bpm: float = 190.0
@export var beats_per_bar: int = 4
@export var beat_offset: float = 0.0
@export var latency_offset: float = 0.0
@export var use_audio_clock: bool = true
@export var auto_start: bool = true
@export var audio_player_path: NodePath

var _audio_player: AudioStreamPlayer = null
var _running: bool = false
var _last_beat_index: int = -1

func _ready() -> void:
	if audio_player_path != NodePath(""):
		_audio_player = get_node_or_null(audio_player_path) as AudioStreamPlayer
	if auto_start:
		start()

func set_audio_player(player: AudioStreamPlayer) -> void:
	_audio_player = player

func start() -> void:
	_running = true
	_last_beat_index = -1

func stop() -> void:
	_running = false

func set_bpm(new_bpm: float) -> void:
	if new_bpm <= 0.0:
		return
	bpm = new_bpm

func get_clock_time() -> float:
	if use_audio_clock and is_instance_valid(_audio_player):
		var t := _audio_player.get_playback_position()
		t += AudioServer.get_time_since_last_mix()
		t -= AudioServer.get_output_latency()
		return t + latency_offset
	return Time.get_ticks_msec() / 1000.0

func get_offset_from_nearest_beat(time: float = -1.0) -> float:
	var now := time if time >= 0.0 else get_clock_time()
	var seconds_per_beat := 60.0 / bpm
	if seconds_per_beat <= 0.0:
		return INF
	var relative := (now - beat_offset) / seconds_per_beat
	var nearest_index := int(round(relative))
	var nearest_time := beat_offset + float(nearest_index) * seconds_per_beat
	return abs(now - nearest_time)

func _process(_delta: float) -> void:
	if not _running:
		return

	var seconds_per_beat := 60.0 / bpm
	if seconds_per_beat <= 0.0:
		return

	var now := get_clock_time()
	if now < beat_offset:
		return

	var beat_index := int(floor((now - beat_offset) / seconds_per_beat))
	if beat_index <= _last_beat_index:
		return

	var next_index := _last_beat_index + 1
	while next_index <= beat_index:
		var beat_time := beat_offset + float(next_index) * seconds_per_beat
		emit_signal("beat", next_index, beat_time)

		if next_index % 2 == 0:
			emit_signal("half_beat", next_index, beat_time)

		if beats_per_bar > 0 and next_index % beats_per_bar == 0:
			emit_signal("measure", int(next_index / beats_per_bar), beat_time)

		next_index += 1

	_last_beat_index = beat_index
