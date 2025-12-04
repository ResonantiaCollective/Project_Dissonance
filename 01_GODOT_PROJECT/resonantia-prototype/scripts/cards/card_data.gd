extends Resource
class_name CardData

enum CardType {
	OFFENSE,
	DEFENSE,
	RHYTHM,
	CORRUPTION
}

@export var id: String
@export var display_name: String
@export var description: String
@export var type: CardType = CardType.OFFENSE
@export var cost: int = 0
@export var tags: Array[String] = []
