extends Node

const CENTER_SCREEN_X = 1152/2
const CENTER_SCREEN_Y = 648/2

const CARD_WIDTH = 118

const DISCARD_PILE = Vector2(1090, 560)
const DRAW_PILE = Vector2(60, 560)

var moveArr: Array[CardData] = []
var moveArrSize: int = 0:
	set = playMove
var isAnimationFinished: bool = true

# Game Logic
func _ready():
	SignalBus.playCard.connect(addCardQueue)
	SignalBus.finishAnimation.connect(removeCardQueue)

func addCardQueue(card: CardUI):
	var cardData: CardData = card.cardData
	moveArr.push_front(cardData)
	moveArrSize += 1
	print(moveArr)

func removeCardQueue():
	moveArr.pop_back()
	moveArrSize -= 1
	print(moveArr)

func playMove(size):
	moveArrSize = size
	if moveArrSize != 0:
		var animationName: String = moveArr.back().animationName
		SignalBus.emit_signal("playAnimation", animationName) # Todo take animation from cardData
