extends Node
class_name AbilitySystem

# Basic ability data container
class Ability:
	var name: String
	var cost: int = 0
	var cooldown: int = 0
	var target_type: String = "single" # single, aoe, self, zone
	var required_beat_window: int = -1 # -1 = no requirement

	func cast(caster, target, context := {}) -> void:
		# To be implemented per-ability
		pass

var abilities := {} # key: String id, value: Ability

func _ready() -> void:
	# Register prototype abilities here or from data later
	pass

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
	# Cost, cooldown, and beat window checks will be added here.
	return true

func cast_ability(id: String, caster, target, context := {}) -> void:
	if not can_cast(id, caster, target, context):
		return
	var ability := get_ability(id)
	if ability == null:
		return
	ability.cast(caster, target, context)
