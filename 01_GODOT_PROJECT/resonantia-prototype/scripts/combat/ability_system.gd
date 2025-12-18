extends Node
class_name AbilitySystem

# Basic ability data container
class Ability:
	var name: String
	var cost: int = 0
	var cooldown: int = 0
	var target_type: String = "single" # single, aoe, self, zone
	var required_beat_window: int = -1 # -1 = no timing requirement

	func cast(caster, target, context := {}) -> void:
		# To be implemented per-ability
		pass

var abilities := {} # key: String id, value: Ability

func _ready() -> void:
	# Register prototype abilities
	var pulse_slash = Ability.new()
	pulse_slash.name = "Pulse Slash"
	pulse_slash.cost = 1
	pulse_slash.cooldown = 0
	pulse_slash.target_type = "single"
	register_ability("pulse_slash", pulse_slash)

	var fracture_guard = Ability.new()
	fracture_guard.name = "Fracture Guard"
	fracture_guard.cost = 1
	fracture_guard.cooldown = 1
	fracture_guard.target_type = "self"
	register_ability("fracture_guard", fracture_guard)

	var overdrive_burst = Ability.new()
	overdrive_burst.name = "Overdrive Burst"
	overdrive_burst.cost = 2
	overdrive_burst.target_type = "aoe"
	register_ability("overdrive_burst", overdrive_burst)

func register_ability(id: String, ability: Ability) -> void:
	abilities[id] = ability

func has_ability(id: String) -> bool:
	return abilities.has(id)

func get_ability(id: String) -> Ability:
	if abilities.has(id):
		return abilities[id]
	return null

func can_cast(id: String, caster, target, context := {}) -> bool:
	var ability := get_ability(id)
	if ability == null:
		return false
	# Later: cost, cooldown, timing checks
	return true

func cast_ability(id: String, caster, target, context := {}) -> void:
	if not can_cast(id, caster, target, context):
		print("Cannot cast ability: ", id)
		return
	var ability := get_ability(id)
	if ability == null:
		return
	print("Casting ability: ", ability.name)
	# Later: actually apply effects
