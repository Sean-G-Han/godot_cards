extends Button

func _on_pressed():
	SignalBus.emit_signal("playCombo")
