extends Node

var combos: Array[Card] = []

func _ready():
	SignalBus.addCombo.connect(addCombo)
	SignalBus.removeCombo.connect(removeCombo)
	SignalBus.playCombo.connect(playCombo)

func addCombo(card: Card) -> void:
	combos.append(card)

func removeCombo(card: Card) -> void:
	combos.erase(card)

func playCombo() -> void:
	if combos.size() > 0:
		for card in combos:
			SignalBus.emit_signal("playCard", card)
			await(get_tree().create_timer(0.25).timeout)
	else:
		push_error("Combo Array Empty")
