extends Node2D

const CARD_TEMPLATE = preload("res://card.tscn")
@onready var cardPool = $"../CardPool"
var hand = []
@export var deck : Deck

func _ready():
	SignalBus.playCard.connect(playCard)
	deck.shuffle()
	draw(6)

func draw(numCards: int) -> void:
	if not deck.isEmpty():
		for i in range(numCards):
			var newCard = cardPool.getCard(deck.pop())
			drawCard(newCard)
			spreadHand()
			await(get_tree().create_timer(0.1).timeout)
	else:
		spreadHand()
		if hand.is_empty():
			print("Shuffle")
			deck.shuffle()
			draw(6)

# Draws a card from draw pile, but doesnt take from pool
func drawCard(card: CardUI) -> void:
	hand.append(card)
	if card.get_parent() != self: # This is a card manager so all card will be a child of this node
		add_child(card)

# Activates the effect of a card
func activateCard(card: CardUI) -> void: 
	card.play()
	hand.erase(card)

func playCard(card: CardUI) -> void:
	activateCard(card)
	draw(1)

func spreadHand() -> void:
	var width = (hand.size() - 1) * Game.CARD_WIDTH
	var pos: Vector2 = Vector2.ZERO
	for cardIndex in hand.size():
		pos.y = 560
		pos.x = Game.CENTER_SCREEN_X + width/2 - cardIndex  * Game.CARD_WIDTH 
		hand[cardIndex].move(pos)
