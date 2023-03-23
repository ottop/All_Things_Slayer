extends CharacterBody2D

signal turn

var Bullet = preload("res://bullet.tscn")

var speed = 700
var dash_multiplier = 4
var knife_dmg = 50
var health = 100
var input_dir

var turned = false

func _ready():
	turn.emit(!turned)
	$Gun/ShotTimer.start()
	
func get_input():
	if $DashTimer.is_stopped() == true:
		input_dir = Input.get_vector("left", "right", "up", "down")
	
	velocity = input_dir * speed
	
	if Input.is_action_just_pressed("turn"):
		turned = !turned
		turn.emit(!turned)
	
	if Input.is_action_just_pressed("dash"):
		if ($DashCooldown.is_stopped() == true):
			$Knife.show()
			$DashTimer.start()
		
			$Knife.set_collision_mask_value(2,true)
			$DashCooldown.start()
		
	if $DashTimer.is_stopped() == false:
		
		$Knife.rotation = velocity.angle()
		if turned:
			$Knife.rotation += PI
		
		if $Knife.get_overlapping_bodies().size() > 0:
			for i in $Knife.get_overlapping_bodies():
				if i.has_method("hit"):
					i.hit(knife_dmg)
		
		velocity = velocity * dash_multiplier
		
	if $DashTimer.is_stopped() == true:
		$Knife.hide()
		$Knife.set_collision_mask_value(2,false)
		get_tree().call_group("enemies", "hitbox_restore")
		
	if Input.is_action_pressed("click"):
		var dir = get_global_mouse_position() - global_position
		"""if (dir.angle() > 0.5 * PI):
			$AnimatedSprite2D.animation = "default"
		else:
			$AnimatedSprite2D.animation = "new_animation"""
		$Gun.rotation = dir.angle()
		if ($Gun/ShotTimer.is_stopped()):
			shoot()
			$Gun/ShotTimer.start()
			
func shoot():
	var b = Bullet.instantiate()
	var b2 = Bullet.instantiate()
	var b3 = Bullet.instantiate()
	b.speed += speed
	b.start($Gun/Muzzle.global_position, $Gun.rotation)
	get_tree().root.add_child(b)
	b2.speed += speed
	b2.start($Gun/Muzzle.global_position, $Gun.rotation + (0.0625 * PI))
	get_tree().root.add_child(b2)
	b3.speed += speed
	b3.start($Gun/Muzzle.global_position, $Gun.rotation - (0.0625 * PI))
	get_tree().root.add_child(b3)

func _physics_process(delta):
	$Knife.position = $Camera2D.position
	get_input()
	move_and_slide()

func _on_shot_timer_timeout():
	$Gun/ShotTimer.stop()

func _on_dash_timer_timeout():
	$DashTimer.stop()

func hit(dmg):
	health -= dmg
	if health <= 0:
		queue_free()
