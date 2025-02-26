extends Panel


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_mouse_entered():
	var tween = get_tree().create_tween()
	var tween2 = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(self.position.x, -100), 0.2)
	tween2.tween_property(self, "scale", Vector2(1.5, 1.5), 0.2)

func _on_mouse_exited():
	var tween = get_tree().create_tween()
	var tween2 = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(self.position.x, 0), 0.2)
	tween2.tween_property(self, "scale", Vector2(1, 1), 0.2)
