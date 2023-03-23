extends CanvasLayer

func _on_character_turn(turned):
	$Label.text = str(turned)
