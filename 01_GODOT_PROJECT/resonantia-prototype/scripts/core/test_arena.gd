extends Node2D

@onready var label: Label = $Label
@onready var feedback: Label = $FeedbackLabel
@onready var combo_label: Label = $ComboLabel
@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var pulse_rect: ColorRect = $BeatFlash
@onready var enemy_rect: ColorRect = $EnemyRect
@onready var enemy_hp_label: Label = $EnemyHPLabel

var spectrum: AudioEffectSpectrumAnalyzerInstance = null
var beat_threshold: float = 0.05
var beat_state: bool = false

var debug_timer: float = 0.0
var pulse_strength: float = 0.0
var pulse_decay: float = 5.0

var combo: int = 0
var best_combo: int = 0

var enemy_max_hp: int = 20
var enemy_hp: int = enemy_max_hp
var enemy_alive: bool = true

func _ready() -> void:
	print("Resonantia A3 — Spectrum Pulse + Enemy System Online.")

	# Get analyzer instance from 'Spectrum' bus
	var bus_index := AudioServer.get_bus_index("Spectrum")
	if bus_index == -1:
		push_error("Spectrum bus not found. Make sure you have a 'Spectrum' bus in Audio -> Buses.")
	else:
		spectrum = AudioServer.get_bus_effect_instance(bus_index, 0)
		if spectrum == null:
			push_error("SpectrumAnalyzer instance is null. Check that the Spectrum bus has a SpectrumAnalyzer effect in slot 0.")

	audio_player.play()
	label.text = ""
	feedback.text = ""

	# Make sure BeatFlash starts invisible
	var c := pulse_rect.modulate
	c.a = 0.0
	pulse_rect.modulate = c

	_update_combo_label()
	_update_enemy_hp_label()

func _process(delta: float) -> void:
	if spectrum == null:
		label.text = "NO SPECTRUM"
		beat_state = false
		return

	debug_timer += delta

	# Read mid / high where claps or transient hits live (adjust to taste)
	var vec: Vector2 = spectrum.get_magnitude_for_frequency_range(500.0, 3000.0)
	var energy: float = vec.length()

	if debug_timer > 0.3:
		print("Energy:", energy)
		debug_timer = 0.0

	# BEAT detection
	if energy > beat_threshold:
		label.text = "BEAT"
		beat_state = true
		pulse_strength = 1.0
	else:
		label.text = ""
		beat_state = false

	# Screen pulse fade
	pulse_strength = max(pulse_strength - pulse_decay * delta, 0.0)
	var c := pulse_rect.modulate
	c.a = pulse_strength * 0.25
	pulse_rect.modulate = c

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("strike_on_beat"):
		if not enemy_alive:
			# Enemy is already dead; ignore further strikes
			feedback.text = "ENEMY DEFEATED"
			feedback.modulate = Color(1, 1, 0)
			await get_tree().create_timer(0.25).timeout
			feedback.text = ""
			return

		if beat_state:
			# GOOD HIT
			feedback.text = "GOOD"
			feedback.modulate = Color(0, 1, 0)
			combo += 1
			if combo > best_combo:
				best_combo = combo
			_apply_enemy_damage(1)  # 1 damage per good hit for now
			_update_combo_label()
		else:
			# MISS
			feedback.text = "MISS"
			feedback.modulate = Color(1, 0, 0)
			combo = 0
			_update_combo_label()

		await get_tree().create_timer(0.25).timeout
		feedback.text = ""

func _update_combo_label() -> void:
	if combo > 0:
		combo_label.text = "COMBO: %d  (BEST: %d)" % [combo, best_combo]
	else:
		combo_label.text = "COMBO: 0  (BEST: %d)" % [best_combo]

func _update_enemy_hp_label() -> void:
	enemy_hp_label.text = "ENEMY HP: %d / %d" % [enemy_hp, enemy_max_hp]

func _apply_enemy_damage(amount: int) -> void:
	if not enemy_alive:
		return

	enemy_hp = max(enemy_hp - amount, 0)
	_update_enemy_hp_label()

	# Flash enemy on hit
	var original_color := enemy_rect.modulate
	enemy_rect.modulate = Color(1, 0, 0)  # hit flash red
	await get_tree().create_timer(0.1).timeout
	enemy_rect.modulate = original_color

	if enemy_hp == 0:
		enemy_alive = false
		_on_enemy_defeated()

func _on_enemy_defeated() -> void:
	feedback.text = "ENEMY DEFEATED"
	feedback.modulate = Color(1, 1, 0)
	print("Enemy defeated.")

	# Optional: dim or fade enemy rect
	var c := enemy_rect.modulate
	c.a = 0.3
	enemy_rect.modulate = c
