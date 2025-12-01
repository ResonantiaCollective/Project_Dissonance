extends Node2D

@onready var label := $Label                   # BEAT indicator
@onready var feedback := $FeedbackLabel       # GOOD / MISS
@onready var audio_player := $AudioStreamPlayer

var spectrum : AudioEffectSpectrumAnalyzerInstance = null
var beat_threshold := 0.15        # VERY LOW on purpose, we’ll tune later
var beat_state := false
var debug_timer := 0.0            # for printing energy sometimes

func _ready() -> void:
	print("Resonantia A3 — Spectrum Pulse Online.")

	# 1) Get the analyzer instance from the 'Spectrum' bus
	var bus_index := AudioServer.get_bus_index("Spectrum")
	if bus_index == -1:
		push_error("Spectrum bus not found. Check Audio > Buses: name must be exactly 'Spectrum'.")
	else:
		spectrum = AudioServer.get_bus_effect_instance(bus_index, 0)
		if spectrum == null:
			push_error("SpectrumAnalyzer instance is null. Check that Spectrum bus has a SpectrumAnalyzer effect in slot 0.")

	audio_player.play()
	label.text = ""
	feedback.text = ""

func _process(delta: float) -> void:
	if spectrum == null:
		# If we ever get here, text will show that spectrum is missing
		label.text = "NO SPECTRUM"
		beat_state = false
		return

	debug_timer += delta

	# 2) Read overall energy (wide band so *any* clap/kick shows up)
	var vec := spectrum.get_magnitude_for_frequency_range(500.0, 3000.0)
	var energy := vec.length()

	# Print energy every 0.3s so you can see values in Output tab
	if debug_timer > 0.3:
		print("Energy:", energy)
		debug_timer = 0.0

	# 3) Detect beat
	if energy > beat_threshold:
		label.text = "BEAT"
		beat_state = true
		await get_tree().create_timer(0.05).timeout  # 50ms flash
		label.text = ""
		beat_state = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("strike_on_beat"):
		if beat_state:
			feedback.text = "GOOD"
			feedback.modulate = Color(0, 1, 0)
		else:
			feedback.text = "MISS"
			feedback.modulate = Color(1, 0, 0)

		await get_tree().create_timer(0.25).timeout
		feedback.text = ""
