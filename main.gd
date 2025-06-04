extends Node2D

var solution = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_ready()
	$Word.undo_button = $UndoButton

func get_ready():
	solution = GameMangager.solution
	spawn_letters()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_letters():
	var shuffled = solution.duplicate()
	if solution is PackedStringArray:
		shuffled = Array(solution.duplicate())
	shuffled.shuffle()
	print(shuffled)
	
	var letter_pos = []
	
	for l in shuffled:
		var letter = preload("res://falling_letter.tscn").instantiate()
		#get_parent().add_child(letter)
		add_child(letter)
		letter.position = Vector2(randi_range(100, get_viewport_rect().size.x - 100), -80)
		
		check_letter_position(letter_pos, letter)
		
		letter.letter = l
		letter.get_ready()


func check_letter_position(letter_pos, letter):
	var safe = false
	if letter_pos.is_empty():
		letter_pos.append(letter.position)
		return
	for pos in letter_pos:
		if abs(pos.x - letter.position.x) > 100:
			safe = true
			break
	if safe == true:
		letter_pos.append(letter.position)
		return
	else:
		letter.position = Vector2(randi_range(100, get_viewport_rect().size.x - 100), -80)
		check_letter_position(letter_pos, letter)
