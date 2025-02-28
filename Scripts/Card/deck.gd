extends Resource

class_name Deck

@export var deck: Array[CardData] = []
var index: int = 0

func shuffle() -> void:
	deck.shuffle()
	index = 0

func pop() -> CardData:
	index += 1
	return deck[index - 1]

func isEmpty() -> bool:
	if index >= deck.size():
		return true
	return false
