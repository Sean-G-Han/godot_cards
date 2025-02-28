extends Node2D

var centerScreenX
var centerScreenY
const CARD_TEMPLATE = preload("res://card.tscn")
const CARDWIDTH = 88
var hand = []
@export var deck : Deck

func _ready():
	SignalBus.handReset.connect(spreadHand)
	SignalBus.playCard.connect(playCard)
	centerScreenX = get_viewport().size.x/2
	centerScreenY = get_viewport().size.y
	deck.shuffle()
	for i in range(6):
		drawCard()
		await(get_tree().create_timer(0.25).timeout)

func drawCard() -> void:
	if deck.isEmpty():
		push_error("Deck is Empty!")
	else:
		var newCard = CARD_TEMPLATE.instantiate()
		newCard._initialize(deck.pop())
		hand.append(newCard)
		add_child(newCard)
		spreadHand()

func playCard(card: Card) -> void:
	#todo: Add Execute card
	discardCard(card)

func discardCard(card: Card) -> void:
	hand.erase(card)
	remove_child(card)
	card.queue_free() #todo: Place holder place them in discard pile later
	spreadHand()

func spreadHand() -> void:
	var width = (hand.size() - 1) * CARDWIDTH
	for cardIndex in hand.size():
		hand[cardIndex].targetPosition.y = centerScreenY - 15
		hand[cardIndex].targetPosition.x = centerScreenX - width/2 + cardIndex  * CARDWIDTH
