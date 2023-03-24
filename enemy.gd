extends CharacterBody2D

var health = 100
var dmg = 20

func start(pos):
	position = pos

func hit(dmg):
	health -= dmg
	if health <= 0:
		queue_free()
	set_collision_layer_value(2,false)

func hitbox_restore():
	set_collision_layer_value(2,true)
	
func _physics_process(delta):
	if (get_last_slide_collision() != null):
			if ($Cooldown.is_stopped()):
				if (get_last_slide_collision().get_collider().has_method("playerhit")):
					get_last_slide_collision().get_collider().playerhit(dmg)
					$Cooldown.start()
	
func _on_cooldown_timeout():
	$Cooldown.stop()
