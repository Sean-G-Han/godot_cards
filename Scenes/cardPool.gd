extends Node2D

const CARD_TEMPLATE = preload("res://card.tscn")
var pool: Array[CardUI]= []

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.connect("poolCard", freeCard)

func freeCard(card: CardUI):
	pool.append(card)

func getCard(data: CardData) -> CardUI:
	var newCard: CardUI
	if pool.is_empty():
		newCard = CARD_TEMPLATE.instantiate()
		newCard.initialize(data) #Todo: if there is Init, there should be DeInit right
		return newCard
	newCard = pool.pop_back()
	newCard.initialize(data)
	return newCard
