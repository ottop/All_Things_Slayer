extends CharacterBody2D

var health = 100
var dmg = 20

func hit(dmg):
	health -= dmg
	if health <= 0:
		queue_free()
	set_collision_layer_value(2,false)

func hitbox_restore():
	set_collision_layer_value(2,true)
	


	
