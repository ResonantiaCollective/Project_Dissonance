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
@onready var surge_rect: ColorRect = $SurgeRect
@onready var surge_label: Label = $SurgeLabel
@onready var round_label: Label = $RoundLabel
@onready var ability_system: AbilitySystem = $AbilitySystem
@onready var pulse_engine: PulseEngine = $PulseEngine

@export var bpm: float = 190.0
@export var beat_offset: float = 0.0
@export var latency_offset: float = 0.0
@export var use_spectrum_beats: bool = false
@export var beat_threshold: float = 0.05
@export var spectrum_low_hz: float = 60.0
@export var spectrum_high_hz: float = 220.0
@export var spectrum_smooth: float = 0.2
@export var spectrum_peak_multiplier: float = 1.6
@export var spectrum_min_interval: float = 0.18

var spectrum: AudioEffectSpectrumAnalyzerInstance = null
var spectrum_retry_cooldown_left: float = 0.0
const SPECTRUM_RETRY_INTERVAL := 0.5
var spectrum_beat_state: bool = false
var spectrum_energy_ema: float = 0.0
var spectrum_energy_prev: float = 0.0
var spectrum_last_beat_time: float = -1.0

var debug_timer: float = 0.0
var debug_enabled: bool = false
var pulse_strength: float = 0.0
var pulse_decay: float = 5.0
var beat_label_left: float = 0.0

var combo: int = 0
var best_combo: int = 0

var base_enemy_hp: int = 35
var enemy_max_hp: int = base_enemy_hp
var enemy_hp: int = base_enemy_hp
var enemy_alive: bool = true

var player_max_hp: int = 20
var player_hp: int = player_max_hp
var player_alive: bool = true

var last_beat_time: float = -1.0
const PERFECT_WINDOW := 0.03
const GOOD_WINDOW := 0.09

const ENEMY_NORMAL_ATTACK_BEATS := 8
const ENEMY_ALERT_ATTACK_BEATS := 6

# Enemy alert / pattern state
var enemy_alert: bool = false
var enemy_alert_beats_left: int = 0
const ENEMY_ALERT_BEATS := 2
const ENEMY_ALERT_DAMAGE_BONUS := 1
var beats_since_last_attack: int = 0
var warned_missing_spectrum_bus: bool = false
var warned_missing_spectrum_effect: bool = false

# SURGE ability state
var surge_ready: bool = true
var surge_active: bool = false
var surge_cooldown: float = 6.0
var surge_cd_left: float = 0.0
var surge_active_window: float = 3.0
var surge_active_left: float = 0.0

# Round system
var current_round: int = 1
var max_rounds: int = 3

# Guard / defensive mechanic
var guard_active: bool = false
var guard_perfect: bool = false
var guard_window_left: float = 0.0
const GUARD_WINDOW_DURATION := 0.25  # seconds


func _ready() -> void:
	print(">>> TESTARENA READY <<<")
	print("Resonantia - Duel + SURGE + Enemy Patterns + Rounds + Guard online.")

	if pulse_engine:
		pulse_engine.set_audio_player(audio_player)
		pulse_engine.set_bpm(bpm)
		pulse_engine.beat_offset = beat_offset
		pulse_engine.latency_offset = latency_offset
		if not use_spectrum_beats:
			pulse_engine.beat.connect(_on_pulse_beat)
	if use_spectrum_beats:
		_ensure_spectrum_available()

	_reset_pulse()
	_reset_duel_visuals()

	surge_ready = true
	surge_active = false
	surge_cd_left = 0.0
	surge_active_left = 0.0

	_set_enemy_alert(false, 0)

	guard_active = false
	guard_perfect = false
	guard_window_left = 0.0

	current_round = 1
	_start_round(true)

	_update_surge_ui()
	_update_enemy_alert_visual()

	label.text = ""
	feedback.text = ""
	if not pulse_engine:
		push_warning("PulseEngine node not found!")


# 🔊 called by PulseEngine every beat
func _on_pulse_beat(_beat_index: int, beat_time: float) -> void:
	if use_spectrum_beats:
		return
	if not enemy_alive or not player_alive:
		print(">>> PULSE BEAT IGNORED (someone dead) <<<")
		return

	print(">>> PULSE BEAT RECEIVED IN TESTARENA <<<")

	_register_beat(beat_time)


func _process(delta: float) -> void:
	if use_spectrum_beats:
		if spectrum == null:
			if spectrum_retry_cooldown_left > 0.0:
				spectrum_retry_cooldown_left = max(spectrum_retry_cooldown_left - delta, 0.0)
			else:
				_ensure_spectrum_available()
				spectrum_retry_cooldown_left = SPECTRUM_RETRY_INTERVAL
			if spectrum == null:
				label.text = "NO SPECTRUM"
		else:
			debug_timer += delta
			var vec: Vector2 = spectrum.get_magnitude_for_frequency_range(spectrum_low_hz, spectrum_high_hz)
			var energy: float = vec.length()
			spectrum_energy_ema = lerp(spectrum_energy_ema, energy, spectrum_smooth)
			var flux: float = energy - spectrum_energy_prev
			spectrum_energy_prev = energy

			var now: float = _get_timing_time()
			var min_interval: float = spectrum_min_interval
			if bpm > 0.0:
				min_interval = max(min_interval, (60.0 / bpm) * 0.5)
			var threshold: float = max(beat_threshold, spectrum_energy_ema * spectrum_peak_multiplier)

			if debug_enabled and debug_timer > 0.3:
				print("Energy:", energy, "Threshold:", threshold, "Flux:", flux)
				debug_timer = 0.0

			var was_on_beat: bool = spectrum_beat_state
			var is_above: bool = energy > threshold
			if is_above and not was_on_beat and flux > 0.0 and (now - spectrum_last_beat_time) >= min_interval:
				spectrum_last_beat_time = now
				print(">>> SPECTRUM BEAT DETECTED <<<")
				_register_beat(now)
			spectrum_beat_state = is_above

	pulse_strength = max(pulse_strength - pulse_decay * delta, 0.0)
	pulse_rect.modulate.a = pulse_strength * 0.25

	if beat_label_left > 0.0:
		beat_label_left = max(beat_label_left - delta, 0.0)
		if beat_label_left == 0.0:
			label.text = ""

	_update_surge_timers(delta)
	_update_guard_timer(delta)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("restart_duel"):
		_restart_duel()
		return

	if event.is_action_pressed("use_surge"):
		_try_activate_surge()
		return

	if event.is_action_pressed("guard_on_beat"):
		_try_guard()
		return

	if event.is_action_pressed("strike_on_beat"):
		if not player_alive:
			feedback.text = "YOU FALL INTO DISSONANCE"
			feedback.modulate = Color(1, 0.5, 0.5)
			await get_tree().create_timer(0.4).timeout
			feedback.text = ""
			return

		if not enemy_alive:
			# round or trial already ended
			return

		var timing := _classify_timing()

		match timing:
			"PERFECT":
				var dmg_perfect := _calculate_damage(2, 1.5, "PERFECT")
				_apply_enemy_damage(dmg_perfect, true)
				_good_feedback("PERFECT", Color(0, 1, 1))
			"GOOD":
				var dmg_good := _calculate_damage(1, 1.0, "GOOD")
				_apply_enemy_damage(dmg_good, false)
				_good_feedback("GOOD", Color(0, 1, 0))
			"MISS":
				combo = 0
				_update_combo_label()
				_miss_feedback()
				# Desync punish if enemy is alerted
				if enemy_alert and enemy_alive and player_alive:
					feedback.text = "DESYNC PUNISH"
					feedback.modulate = Color(1, 0.3, 0.3)
					await get_tree().create_timer(0.15).timeout
					feedback.text = ""
					_enemy_attack_player(1)


func _on_beat_pulse() -> void:
	if not enemy_alive or not player_alive:
		return

	# handle alert beat countdown
	if enemy_alert:
		enemy_alert_beats_left -= 1
		if enemy_alert_beats_left <= 0:
			enemy_alert_beats_left = 0
			_set_enemy_alert(false, 0)

	var attack_interval: int = ENEMY_ALERT_ATTACK_BEATS if enemy_alert else ENEMY_NORMAL_ATTACK_BEATS

	beats_since_last_attack += 1
	if beats_since_last_attack >= attack_interval:
		beats_since_last_attack = 0
		_enemy_attack_player(1)


func _classify_timing() -> String:
	if use_spectrum_beats:
		if last_beat_time < 0.0:
			return "MISS"
		var now: float = _get_timing_time()
		var offset: float = abs(now - last_beat_time)
		if offset <= PERFECT_WINDOW:
			return "PERFECT"
		elif offset <= GOOD_WINDOW:
			return "GOOD"
		return "MISS"

	if pulse_engine == null:
		return "MISS"

	var pulse_offset: float = pulse_engine.get_offset_from_nearest_beat()
	if pulse_offset <= PERFECT_WINDOW:
		return "PERFECT"
	elif pulse_offset <= GOOD_WINDOW:
		return "GOOD"
	return "MISS"


func _calculate_damage(base: int, perfect_mult: float, timing: String) -> int:
	combo += 1
	if combo > best_combo:
		best_combo = combo
	_update_combo_label()

	var combo_mult := 1.0 + combo * 0.1

	var surge_mult := 1.0
	if surge_active:
		surge_mult += 0.4
		if timing == "PERFECT":
			surge_mult += 0.2
		# consume SURGE on first hit
		surge_active = false
		_update_surge_ui()

	var total := base * perfect_mult * combo_mult * surge_mult

	# PERFECT during alert breaks the alert
	if timing == "PERFECT" and enemy_alert:
		_set_enemy_alert(false, 0)
		_enemy_alert_broken_feedback()

	return int(round(total))


func _apply_enemy_damage(amount: int, from_perfect: bool) -> void:
	if not enemy_alive:
		return

	enemy_hp = max(enemy_hp - amount, 0)
	_update_enemy_hp_label()

	var flash_color := Color(0.4, 0.8, 1.0) if from_perfect else (Color(1, 1, 0) if amount >= 3 else Color(1, 0, 0))
	enemy_rect.modulate = flash_color
	await get_tree().create_timer(0.1).timeout
	enemy_rect.modulate = Color(1, 1, 1, enemy_rect.modulate.a)
	_update_enemy_alert_visual()

	if enemy_hp == 0:
		_on_round_won()


func _on_round_won() -> void:
	_set_enemy_alert(false, 0)
	enemy_alive = false
	enemy_rect.modulate.a = 0.3
	_update_enemy_alert_visual()

	feedback.text = "ENEMY DEFEATED"
	feedback.modulate = Color(1, 1, 0)
	await get_tree().create_timer(0.5).timeout

	if current_round < max_rounds:
		current_round += 1
		feedback.text = "NEXT ROUND"
		feedback.modulate = Color(0.6, 0.9, 1.0)
		await get_tree().create_timer(10.0).timeout
		feedback.text = ""
		_start_round(false)
	else:
		feedback.text = "TRIAL COMPLETE"
		feedback.modulate = Color(0.4, 1.0, 0.4)
		await get_tree().create_timer(15.0).timeout
		feedback.text = ""


func _enemy_attack_player(base_amount: int) -> void:
	if not player_alive:
		return

	var amount := base_amount
	if enemy_alert:
		amount += ENEMY_ALERT_DAMAGE_BONUS

	# Apply Guard
	if guard_active:
		if guard_perfect:
			amount = 0  # full parry
			feedback.text = "PERFECT GUARD"
			feedback.modulate = Color(0.4, 1.0, 0.7)
		else:
			amount = max(amount - 1, 0)  # reduce damage
			feedback.text = "GUARD"
			feedback.modulate = Color(0.3, 0.8, 0.6)

		guard_active = false
		guard_perfect = false
		guard_window_left = 0.0

		await get_tree().create_timer(0.2).timeout
		feedback.text = ""

	if amount > 0:
		player_hp = max(player_hp - amount, 0)
		_update_player_hp_label()

		var original := player_rect.modulate
		player_rect.modulate = Color(1, 0.5, 0.5)
		feedback.text = "ENEMY STRIKE"
		feedback.modulate = Color(1, 0.6, 0.2)
		await get_tree().create_timer(0.2).timeout
		player_rect.modulate = original
		feedback.text = ""

	if player_hp == 0 and player_alive:
		player_alive = false
		_on_player_defeated()


func _on_player_defeated() -> void:
	feedback.text = "YOU FALL INTO DISSONANCE"
	feedback.modulate = Color(1, 0.3, 0.3)
	print("Player defeated.")
	await get_tree().create_timer(25.0).timeout
	feedback.text = ""


func _enemy_alert_broken_feedback() -> void:
	enemy_rect.modulate = Color(0.4, 0.8, 1.0, enemy_rect.modulate.a)
	feedback.text = "ALERT SHATTERED"
	feedback.modulate = Color(0.6, 0.9, 1.0)
	await get_tree().create_timer(0.25).timeout
	feedback.text = ""
	_update_enemy_alert_visual()


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


func _update_round_label() -> void:
	round_label.text = "ROUND %d / %d" % [current_round, max_rounds]


func _set_enemy_for_round() -> void:
	var hp_mult := 1.0 + 0.5 * float(current_round - 1)
	enemy_max_hp = int(round(float(base_enemy_hp) * hp_mult))
	enemy_hp = enemy_max_hp
	_update_enemy_hp_label()


func _reset_pulse() -> void:
	var c := pulse_rect.modulate
	c.a = 5.0
	pulse_rect.modulate = c


func _reset_duel_visuals() -> void:
	enemy_rect.modulate = Color(1, 1, 1, 1)
	player_rect.modulate = Color(1, 1, 1, 1)
	enemy_rect.modulate.a = 1.0


func _start_round(reset_player: bool) -> void:
	# Restart audio at the beginning of each round
	audio_player.stop()
	audio_player.play()
	if pulse_engine:
		pulse_engine.start()

	beats_since_last_attack = 0
	last_beat_time = -1.0
	if use_spectrum_beats:
		spectrum_energy_ema = 0.0
		spectrum_energy_prev = 0.0
		spectrum_last_beat_time = -1.0
		spectrum_beat_state = false

	_set_enemy_alert(false, 0)
	enemy_alive = true
	enemy_rect.modulate.a = 1.0

	_set_enemy_for_round()
	_update_enemy_alert_visual()

	if reset_player:
		player_alive = true
		player_hp = player_max_hp
		_update_player_hp_label()

	combo = 0
	_update_combo_label()
	_update_round_label()

	# reset guard state
	guard_active = false
	guard_perfect = false
	guard_window_left = 0.0


func _restart_duel() -> void:
	print("Restarting duel (full trial).")

	surge_ready = true
	surge_active = false
	surge_cd_left = 0.0
	surge_active_left = 0.0

	enemy_alert = false
	enemy_alert_beats_left = 0

	guard_active = false
	guard_perfect = false
	guard_window_left = 0.0

	current_round = 1

	_reset_pulse()
	_reset_duel_visuals()
	_update_surge_ui()
	_start_round(true)

	feedback.text = "RITUAL RESTARTED"
	feedback.modulate = Color(0.6, 0.8, 1.0)
	await get_tree().create_timer(10.0).timeout
	feedback.text = ""


func _update_surge_timers(delta: float) -> void:
	if surge_active:
		surge_active_left -= delta
		if surge_active_left <= 0.0:
			surge_active_left = 0.0
			surge_active = false
			_update_surge_ui()
	elif not surge_ready:
		if surge_cd_left > 0.0:
			surge_cd_left -= delta
			if surge_cd_left <= 0.0:
				surge_cd_left = 0.0
				surge_ready = true
			_update_surge_ui()


func _try_activate_surge() -> void:
	if not player_alive or not enemy_alive:
		return
	if not surge_ready or surge_active:
		return

	surge_ready = false
	surge_active = true
	surge_active_left = surge_active_window
	surge_cd_left = surge_cooldown

	_set_enemy_alert(true, ENEMY_ALERT_BEATS)

	feedback.text = "SURGE!"
	feedback.modulate = Color(0.6, 1.0, 1.0)
	await get_tree().create_timer(0.25).timeout
	feedback.text = ""

	_update_surge_ui()


func _update_surge_ui() -> void:
	if surge_active:
		surge_label.text = "SURGE ACTIVE"
		surge_rect.modulate = Color(0.4, 1.0, 1.0, 1.0)
	elif surge_ready:
		surge_label.text = "SURGE READY"
		surge_rect.modulate = Color(0.2, 0.8, 0.8, 1.0)
	else:
		var cd_text := "SURGE CD: %.1fs" % max(surge_cd_left, 0.0)
		surge_label.text = cd_text
		surge_rect.modulate = Color(0.2, 0.2, 0.2, 1.0)


func _update_enemy_alert_visual() -> void:
	if not enemy_alive:
		return

	if enemy_alert:
		enemy_rect.modulate = Color(1.0, 0.6, 0.2, enemy_rect.modulate.a)
	else:
		enemy_rect.modulate = Color(1, 1, 1, enemy_rect.modulate.a)


func _ensure_spectrum_available() -> void:
	var bus_index := AudioServer.get_bus_index("Spectrum")
	if bus_index == -1:
		if not warned_missing_spectrum_bus:
			push_warning("Spectrum bus not found; beat detection offline.")
			warned_missing_spectrum_bus = true
		return

	var instance := AudioServer.get_bus_effect_instance(bus_index, 0)
	if instance != null:
		spectrum = instance
	else:
		if not warned_missing_spectrum_effect:
			push_warning("Spectrum analyzer effect not ready; retrying.")
			warned_missing_spectrum_effect = true


func _set_enemy_alert(state: bool, beats: int = ENEMY_ALERT_BEATS) -> void:
	enemy_alert = state
	enemy_alert_beats_left = beats if state else 0
	beats_since_last_attack = 0
	_update_enemy_alert_visual()


func _try_guard() -> void:
	if not player_alive:
		return

	var timing := _classify_timing()
	match timing:
		"PERFECT":
			guard_active = true
			guard_perfect = true
			guard_window_left = GUARD_WINDOW_DURATION
			feedback.text = "GUARD READY"
			feedback.modulate = Color(0.4, 1.0, 0.7)
			await get_tree().create_timer(0.15).timeout
			feedback.text = ""
		"GOOD":
			guard_active = true
			guard_perfect = false
			guard_window_left = GUARD_WINDOW_DURATION
			feedback.text = "GUARD READY"
			feedback.modulate = Color(0.3, 0.8, 0.6)
			await get_tree().create_timer(0.15).timeout
			feedback.text = ""
		_:
			# Missed guard timing: optional light feedback
			feedback.text = "GUARD MISS"
			feedback.modulate = Color(0.8, 0.4, 0.4)
			await get_tree().create_timer(0.15).timeout
			feedback.text = ""


func _update_guard_timer(delta: float) -> void:
	if guard_active:
		guard_window_left -= delta
		if guard_window_left <= 0.0:
			guard_window_left = 0.0
			guard_active = false
			guard_perfect = false


func _get_timing_time() -> float:
	if pulse_engine:
		return pulse_engine.get_clock_time()
	return Time.get_ticks_msec() / 1000.0


func _register_beat(beat_time: float) -> void:
	label.text = "BEAT"
	beat_label_left = 0.12
	last_beat_time = beat_time
	pulse_strength = 1.0
	_on_beat_pulse()
