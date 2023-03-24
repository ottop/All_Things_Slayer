extends CharacterBody2D

var speed = 850
var bullet_dmg = 30

func start(_position, _direction):
	rotation = _direction
	position = _position
	velocity = Vector2(speed, 0).rotated(rotation)

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		if collision.get_collider().has_method("hit"):
			collision.get_collider().hit(bullet_dmg)
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
