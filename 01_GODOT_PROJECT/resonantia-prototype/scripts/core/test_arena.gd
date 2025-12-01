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

var enemy_max_hp: int = 45
var enemy_hp: int = enemy_max_hp
var enemy_alive: bool = true

var player_max_hp: int = 25
var player_hp: int = player_max_hp
var player_alive: bool = true

var last_beat_time: float = -1.0
const PERFECT_WINDOW := 0.03
const GOOD_WINDOW := 0.09

var beat_counter: int = 0
var enemy_attack_interval_beats: int = 8  # enemy attacks every 8 beats
var enemy_attack_damage: int = 3

func _ready() -> void:
	print("Resonantia A6 — Enemy Counterattacks Online.")

	var bus_index := AudioServer.get_bus_index("Spectrum")
	if bus_index != -1:
		spectrum = AudioServer.get_bus_effect_instance(bus_index, 0)

	audio_player.play()
	label.text = ""
	feedback.text = ""

	_reset_pulse()
	_update_combo_label()
	_update_enemy_hp_label()
	_update_player_hp_label()

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

	# Beat detection
	if energy > beat_threshold:
		beat_state = true
		pulse_strength = 1.0
		if not was_on_beat:
			# Rising edge = new beat
			label.text = "BEAT"
			last_beat_time = Time.get_ticks_msec() / 1000.0
			_on_new_beat()
	else:
		beat_state = false
		label.text = ""

	# Screen pulse fade-out
	pulse_strength = max(pulse_strength - pulse_decay * delta, 0.0)
	pulse_rect.modulate.a = pulse_strength * 0.25

func _on_new_beat() -> void:
	beat_counter += 1

	if player_alive and enemy_alive:
		# Enemy attacks every N beats
		if beat_counter % enemy_attack_interval_beats == 0:
			_enemy_attack_player()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("strike_on_beat"):
		if not player_alive:
			feedback.text = "YOU FALL INTO DISSONANCE"
			feedback.modulate = Color(1, 0.4, 0.4)
			await get_tree().create_timer(0.4).timeout
			feedback.text = ""
			return

		if not enemy_alive:
			_enemy_defeated_feedback()
			return

		var timing := _classify_timing()

		match timing:
			"PERFECT":
				var dmg := _calculate_damage(2, 1.5)
				_apply_enemy_damage(dmg)
				_good_feedback("PERFECT", Color(0, 1, 1))
			"GOOD":
				var dmg := _calculate_damage(1, 1.0)
				_apply_enemy_damage(dmg)
				_good_feedback("GOOD", Color(0, 1, 0))
			"MISS":
				combo = 0
				_update_combo_label()
				_miss_feedback()

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
	enemy_rect.modulate = Color(1, 1, 1, 1)

	if enemy_hp == 0:
		enemy_alive = false
		_enemy_defeated_feedback()

func _enemy_attack_player() -> void:
	if not player_alive:
		return

	player_hp = max(player_hp - enemy_attack_damage, 0)
	_update_player_hp_label()

	# Flash player on hit
	var original := player_rect.modulate
	player_rect.modulate = Color(1, 0.5, 0.5)
	await get_tree().create_timer(0.1).timeout
	player_rect.modulate = original

	feedback.text = "ENEMY STRIKES"
	feedback.modulate = Color(1, 0.6, 0.2)
	await get_tree().create_timer(0.25).timeout
	feedback.text = ""

	if player_hp == 0:
		player_alive = false
		_on_player_defeated()

func _on_player_defeated() -> void:
	feedback.text = "YOU FALL INTO DISSONANCE"
	feedback.modulate = Color(1, 0.2, 0.2)
	print("Player defeated.")

	# Dim the screen a bit
	pulse_rect.modulate.a = 0.4

	await get_tree().create_timer(0.7).timeout
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
