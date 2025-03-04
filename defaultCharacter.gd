extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.playAnimation.connect(attack) # Todo Use a different signal thjat contains the animtion name


func attack(animationName: String):
	$AnimationPlayer.play(animationName)

func _on_animation_player_animation_finished(anim_name):
	SignalBus.emit_signal("finishAnimation")
