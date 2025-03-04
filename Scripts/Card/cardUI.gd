extends Node2D
class_name CardUI

enum STATE {
	INIT, # onready doesn't trigger on time
	DISCARD,
	DISCARDING,
	HOVER,
	NOT_HOVER,
	DISPLAY,
}

var clickable = true
var cardData: CardData
var state: STATE = STATE.INIT:
	set = setState
var targetPosition: Vector2 = Vector2.ZERO:
	set = _setTargetPosition

func move(targetPos: Vector2) -> void:
	self.targetPosition = targetPos

func initialize(cardData) -> void:
	state = STATE.INIT
	self.position = Game.DRAW_PILE
	self.cardData = cardData
	$CardGraphic/Textbox/Text.text = cardData.name
	$CardGraphic/Textbox/Combo.text = str(cardData.comboValue)

func play() -> void:
	$AnimationPlayer.play("playCard")

func _activateCard() -> void:
	state = STATE.DISPLAY
	cardData.applyEffect()
	move(Vector2(Game.CENTER_SCREEN_X, Game.CENTER_SCREEN_Y))

func _discardCard() -> void:
	state = STATE.DISCARDING
	move(Game.DISCARD_PILE)

func _poolCard() -> void:
	state = STATE.DISCARD
	SignalBus.emit_signal("poolCard", self)

func _on_area_2d_mouse_entered():
	if clickable:
		state = STATE.HOVER
	
func _on_area_2d_mouse_exited():
	if clickable:
		state = STATE.NOT_HOVER

func _on_area_2d_input_event(viewport, event, shape_idx):
	if clickable and event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		SignalBus.emit_signal("playCard", self)

func _setTargetPosition(newPosition: Vector2) -> void:
	targetPosition = newPosition
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", targetPosition, 0.3)

func setState(newState: STATE) -> void:
	state = newState
	visible = true
	match state:
		STATE.INIT:
			scale = Vector2(1,1)
			clickable = true
		STATE.DISCARD:
			clickable = false
		STATE.DISCARDING:
			clickable = false
			var tween = get_tree().create_tween()
			tween.tween_property($CardGraphic, "scale", Vector2(1, 1), 0.1)
		STATE.HOVER:
			var tween = get_tree().create_tween()
			tween.tween_property($CardGraphic, "scale", Vector2(1.1, 1.1), 0.1)
		STATE.NOT_HOVER:
			var tween = get_tree().create_tween()
			tween.tween_property($CardGraphic, "scale", Vector2(1, 1), 0.1)
		STATE.DISPLAY:
			clickable = false
			var tween = get_tree().create_tween()
			tween.tween_property($CardGraphic, "scale", Vector2(1.25, 1.25), 0.1)
