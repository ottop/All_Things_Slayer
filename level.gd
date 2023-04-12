extends TileMap

var grid = []

func remove_cell(ppos):
	print(ppos)
	for i in get_used_cells(0):
		if i.x > ppos.x + 7 or i.x < ppos.x - 24 or i.y > ppos.y+4 or i.y < ppos.y - 13:
			erase_cell(0,i)

func make_grid(pos):
	grid.resize(33)
	for n in 33:
		grid[n] = []
		grid[n].resize(33)
		for m in 18:
			grid[n][m] = 0

	for n in range (0,32):
		for m in range(0,18):
			if !(pos + Vector2i(n,m) in get_used_cells(0)):
				set_cell(0,pos + Vector2i(n,m),0,Vector2i(randi_range(0,2),0))
