extends Node2D

@onready var label: Label = $Label
@onready var feedback: Label = $FeedbackLabel
@onready var combo_label: Label = $ComboLabel
@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var pulse_rect: ColorRect = $BeatFlash
@onready var enemy_rect: ColorRect = $EnemyRect
@onready var enemy_hp_label: Label = $EnemyHPLabel
@onready var player_rect: ColorRect = $PlayerRect
@onready var player_hp_label: Label = $PlayerHPLabel

var spectrum: AudioEffectSpectrumAnalyzerInstance = null
var beat_threshold: float = 0.05
var beat_state: bool = false

var debug_timer: float = 0.0
var pulse_strength: float = 0.0
var pulse_decay: float = 5.0

var combo: int = 0
var best_combo: int = 0

var enemy_max_hp: int = 80
var enemy_hp: int = enemy_max_hp
var enemy_alive: bool = true

var player_max_hp: int = 20
var player_hp: int = player_max_hp
var player_alive: bool = true

var last_beat_time: float = -1.0
const PERFECT_WINDOW := 0.03
const GOOD_WINDOW := 0.09

var beat_count: int = 0
var enemy_attack_every_n_beats: int = 8  # enemy attacks every X beats

func _ready() -> void:
	print("Resonantia A6 — Duel + Restart Dojo Online.")

	var bus_index := AudioServer.get_bus_index("Spectrum")
	if bus_index != -1:
		spectrum = AudioServer.get_bus_effect_instance(bus_index, 0)
		if spectrum == null:
			push_error("SpectrumAnalyzer instance is null. Check Spectrum bus.")

	audio_player.play()
	_reset_pulse()
	_reset_duel_visuals()
	_update_combo_label()
	_update_enemy_hp_label()
	_update_player_hp_label()
	label.text = ""
	feedback.text = ""

func _process(delta: float) -> void:
	if spectrum == null:
		label.text = "NO SPECTRUM"
		return

	debug_timer += delta

	var vec: Vector2 = spectrum.get_magnitude_for_frequency_range(500.0, 3000.0)
	var energy := vec.length()

	if debug_timer > 0.3:
		print("Energy:", energy)
		debug_timer = 0.0

	var was_on_beat := beat_state

	if energy > beat_threshold:
		beat_state = true
		pulse_strength = 1.0

		if not was_on_beat:
			label.text = "BEAT"
			last_beat_time = Time.get_ticks_msec() / 1000.0
			_on_beat_pulse()
	else:
		beat_state = false
		label.text = ""

	pulse_strength = max(pulse_strength - pulse_decay * delta, 0.0)
	pulse_rect.modulate.a = pulse_strength * 0.25

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("restart_duel"):
		_restart_duel()
		return

	if event.is_action_pressed("strike_on_beat"):
		if not player_alive:
			feedback.text = "YOU FALL INTO DISSONANCE"
			feedback.modulate = Color(1, 0.5, 0.5)
			await get_tree().create_timer(0.4).timeout
			feedback.text = ""
			return

		if not enemy_alive:
			_enemy_defeated_feedback()
			return

		var timing := _classify_timing()

		match timing:
			"PERFECT":
				var dmg_perfect := _calculate_damage(2, 1.5)
				_apply_enemy_damage(dmg_perfect)
				_good_feedback("PERFECT", Color(0, 1, 1))
			"GOOD":
				var dmg_good := _calculate_damage(1, 1.0)
				_apply_enemy_damage(dmg_good)
				_good_feedback("GOOD", Color(0, 1, 0))
			"MISS":
				combo = 0
				_update_combo_label()
				_miss_feedback()

func _on_beat_pulse() -> void:
	if not enemy_alive or not player_alive:
		return

	beat_count += 1

	if beat_count % enemy_attack_every_n_beats == 0:
		_enemy_attack_player(1)

func _classify_timing() -> String:
	if last_beat_time < 0.0:
		return "MISS"

	var now := Time.get_ticks_msec() / 1000.0
	var offset := now - last_beat_time

	if offset < 0.0:
		return "MISS"

	if offset <= PERFECT_WINDOW:
		return "PERFECT"
	elif offset <= GOOD_WINDOW:
		return "GOOD"
	return "MISS"

func _calculate_damage(base: int, perfect_mult: float) -> int:
	combo += 1
	if combo > best_combo:
		best_combo = combo

	_update_combo_label()

	var combo_mult := 1.0 + combo * 0.1
	return int(round(base * combo_mult * perfect_mult))

func _apply_enemy_damage(amount: int) -> void:
	if not enemy_alive:
		return

	enemy_hp = max(enemy_hp - amount, 0)
	_update_enemy_hp_label()

	var flash_color := Color(1, 1, 0) if amount >= 3 else Color(1, 0, 0)
	enemy_rect.modulate = flash_color
	await get_tree().create_timer(0.1).timeout
	enemy_rect.modulate = Color(1, 1, 1, enemy_rect.modulate.a)

	if enemy_hp == 0:
		enemy_alive = false
		_enemy_defeated_feedback()

func _enemy_attack_player(amount: int) -> void:
	if not player_alive:
		return

	player_hp = max(player_hp - amount, 0)
	_update_player_hp_label()

	var original := player_rect.modulate
	player_rect.modulate = Color(1, 0.5, 0.5)
	feedback.text = "ENEMY STRIKE"
	feedback.modulate = Color(1, 0.6, 0.2)
	await get_tree().create_timer(0.2).timeout
	player_rect.modulate = original
	feedback.text = ""

	if player_hp == 0:
		player_alive = false
		_on_player_defeated()

func _on_player_defeated() -> void:
	feedback.text = "YOU FALL INTO DISSONANCE"
	feedback.modulate = Color(1, 0.3, 0.3)
	print("Player defeated.")
	await get_tree().create_timer(0.6).timeout
	feedback.text = ""

func _enemy_defeated_feedback() -> void:
	feedback.text = "ENEMY DEFEATED"
	feedback.modulate = Color(1, 1, 0)
	enemy_rect.modulate.a = 0.3
	await get_tree().create_timer(0.25).timeout
	feedback.text = ""

func _good_feedback(text: String, color: Color) -> void:
	feedback.text = text
	feedback.modulate = color
	await get_tree().create_timer(0.25).timeout
	feedback.text = ""

func _miss_feedback() -> void:
	feedback.text = "MISS"
	feedback.modulate = Color(1, 0, 0)
	await get_tree().create_timer(0.25).timeout
	feedback.text = ""

func _update_combo_label() -> void:
	combo_label.text = "COMBO: %d  (BEST: %d)" % [combo, best_combo]

func _update_enemy_hp_label() -> void:
	enemy_hp_label.text = "ENEMY HP: %d / %d" % [enemy_hp, enemy_max_hp]

func _update_player_hp_label() -> void:
	player_hp_label.text = "PLAYER HP: %d / %d" % [player_hp, player_max_hp]

func _reset_pulse() -> void:
	var c := pulse_rect.modulate
	c.a = 0.0
	pulse_rect.modulate = c

func _reset_duel_visuals() -> void:
	enemy_rect.modulate = Color(1, 1, 1, 1)
	player_rect.modulate = Color(1, 1, 1, 1)
	enemy_rect.modulate.a = 1.0

func _restart_duel() -> void:
	print("Restarting duel.")
	combo = 0
	# best_combo persists between runs
	enemy_hp = enemy_max_hp
	player_hp = player_max_hp
	enemy_alive = true
	player_alive = true
	beat_count = 0
	last_beat_time = -1.0

	_reset_pulse()
	_reset_duel_visuals()
	_update_combo_label()
	_update_enemy_hp_label()
	_update_player_hp_label()

	feedback.text = "RITUAL RESTARTED"
	feedback.modulate = Color(0.6, 0.8, 1.0)
	await get_tree().create_timer(0.3).timeout
	feedback.text = ""
