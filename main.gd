extends Node

func _physics_process(delta):
	if ($enemy != null and $Character != null):
		var direction = $Character.get_global_position() - $enemy.get_global_position() 
		$enemy.velocity = direction.normalized() * 350
		$enemy.move_and_slide()
		if ($enemy.get_last_slide_collision() != null):
			if ($enemy/Cooldown.is_stopped() == true):
				if ($enemy.get_last_slide_collision().get_collider().has_method("hit")):
					$enemy.get_last_slide_collision().get_collider().hit($enemy.dmg)
					$enemy/Cooldown.start()
