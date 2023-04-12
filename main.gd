extends Node

var Enemy = preload("res://enemy.tscn")

var enemylist = []

var tilelist = []

func _physics_process(delta):
	for enemy in enemylist:
		if (enemy != null and $Character != null):
			var direction = $Character.get_global_position() - enemy.get_global_position() 
			enemy.velocity = direction.normalized() * 350
			enemy.move_and_slide()
	
	spawn_tile()

func make_enemy(pos):
	var enemy = Enemy.instantiate()
	enemy.start(pos)
	add_child(enemy)
	enemylist.append(enemy)


func _on_spawn_timer_timeout():
	$SpawnTimer.stop()
	if $Character != null:
		var enemy_spawn_location = get_node("Character/SpawnPath/SpawnLocation")
		enemy_spawn_location.progress_ratio = randf()
		var pos = $Character.position
		var alterchance = randi_range(1,3)
		
		if (randi_range(1,2) == 1):
			pos.x += randf_range(600,700)
			
		else:
			pos.x -= randf_range(600,700)
			
		if (randi_range(1,2) == 1):
			pos.y += randf_range(600,700)
			
			if (alterchance == 1):
				pos.x = $Character.position.x + randf_range(-600,600)
			else: if (alterchance == 2):
				pos.y = $Character.position.y + randf_range(-600,600)
			
		else:
			pos.y -= randf_range(600,700)
			if (alterchance == 1):
				pos.x = $Character.position.x + randf_range(-600,600)
			else: if (alterchance == 2):
				pos.y = $Character.position.y + randf_range(-600,600)
			
		make_enemy(pos)
	$SpawnTimer.start()

func spawn_tile():
	if $Character != null:
		var playerpos = $Character.position
		var tm = $Level.get_pattern(0, [Vector2i(randi_range(0,2),0)])
		tilelist = $Level.get_used_cells(0)
		if !($Level.get_neighbor_cell(playerpos / 64, TileSet.CELL_NEIGHBOR_BOTTOM_RIGHT_SIDE) in tilelist):
			$Level.set_pattern(0,playerpos / 64,tm)
		
		
	

