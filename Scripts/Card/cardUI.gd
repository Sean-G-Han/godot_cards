extends Node2D
class_name Card

var cardData: CardData

enum STATE {
	selected,
	unselected,
}

var state: STATE = STATE.unselected:
	set = setState
	
var targetPosition: Vector2 = Vector2.ZERO: #Change vector zero to the deck location
	set = setTargetPosition

func _initialize(cardData) -> void:
	self.cardData = cardData
	$CardGraphic/Textbox/Text.text = cardData.name

func _on_area_2d_mouse_entered():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(1.1, 1.1), 0.1)
	
func _on_area_2d_mouse_exited():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1), 0.1)

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		state = STATE.selected if state == STATE.unselected else STATE.unselected 

func setState(newState: STATE) -> void:
	state = newState
	var tween = get_tree().create_tween()
	if state == STATE.selected:
		tween.tween_property(self, "modulate", Color(0.5,0.5,0.5), 0.1)
		SignalBus.emit_signal("addCombo", self)
	else:
		tween.tween_property(self, "modulate", Color(1,1,1), 0.1)
		SignalBus.emit_signal("removeCombo", self)

func setTargetPosition(newPosition: Vector2) -> void:
	targetPosition = newPosition
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", targetPosition, 0.1)
