extends Resource
class_name CardData

enum TYPE {
	TYPELESS,
	WATER,
	FIRE,
	EARTH,
	WIND,
	DARK,
	LIGHT,
	SLASH,
	IMPACT,
	PIERCE,
}

@export var comboValue: int = 0
@export var name: String = ""
@export var type: TYPE = TYPE.TYPELESS
@export var value: int = 0
@export var image: Texture2D = null
@export var effectScript: EffectScript = null  # Ensure only EffectBase resources are assigned

func applyEffect() -> void:
	if effectScript:
		effectScript.execute()
	else:
		push_error("No effect script assigned to card:", name)
