extends Node2D

signal word_confirmed(letter_node, new_letter : String)
signal word_not_found(letter_node)

var starting_word : String
var target_word : String
var current_word : String

var undo_history :Array[String] = []

var completed = false

var undo_button : TextureButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	modulate = Color.TRANSPARENT
	_get_ready()

func _get_ready():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", Color.WHITE, 1.0)
	
	print("word ready")
	starting_word = GameMangager.starting_word
	target_word = GameMangager.target_word
	GameMangager.current_word = starting_word
	current_word = starting_word
	
	$Control/target.text = target_word
	
	completed = false
	undo_history = []
	
	populate_current()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if undo_history:
		undo_button.disabled = false
	else:
		undo_button.disabled = true
	
	if completed:
		undo_button.disabled = true
	
	if current_word == target_word:
		if not completed:
			completed = true
			await get_tree().create_timer(1).timeout
			for child in $Control/HBoxContainer.get_children():
				print(child)
				child.succses() 
			
			$complete.play()
			await get_tree().create_timer(2).timeout #TODO: ADD CHIME SOUND
			var tween = get_tree().create_tween()
			tween.tween_property(self, "modulate", Color.TRANSPARENT, 2)
			await tween.finished
			
			
			var sucseces = GameMangager.load_level(GameMangager.current_level + 1)
			
			if sucseces:
				get_parent().get_ready()
				reset_self()
				
				_get_ready()

func populate_current():
	var box = $Control/HBoxContainer
	for l in range(len(starting_word)):
		var letter = preload("res://Word/current_word_letter.tscn").instantiate()
		box.add_child(letter)
		letter.text = starting_word[l].to_upper()
		letter.letter = starting_word[l].to_upper()
		letter.scripted_parent = self
		letter.letter_changed.connect(_on_current_word_letter_changed)
		word_confirmed.connect(letter._on_word_confirmed)
		word_not_found.connect(letter._on_word_not_found)

func _on_current_word_letter_changed(node, letter):
	var box = $Control/HBoxContainer
	var index = box.get_children().find(node)
	
	if index == -1:
		return
	
	var char = current_word.split("")
	if char[index] == letter:
		return
	char[index] = letter
	var new_word = "".join(char)
	
	#print(new_word)
	
	if DictionaryManager.is_legal_word(new_word):
		undo_history.append(current_word) #save current before changing to save history for undo
		print(undo_history)
		current_word = new_word
		GameMangager.current_word = current_word
		word_confirmed.emit(node, letter)
		$succses.play()
	else:
		word_not_found.emit(node) #TODO: ADD ERROR SOUND

func _on_undo_button_pressed() -> void:
	if undo_history: #TODO: ADD UNDO SOUND?
		var prev_word = undo_history.pop_back() # pop_back removes and returns last value
		print(prev_word)
		
		var prev_char = prev_word.split("")
		var current_char = current_word.split("")
		
		var index : int
		
		for i in range(len(prev_char)):
			if prev_char[i] == current_char[i]:
				continue
			else:
				index = i
		
		var letter_node : Label = $Control/HBoxContainer.get_children()[index]
		letter_node.text = prev_char[index]
		
		var letter_node_sprite : Sprite2D = letter_node.get_node("Sprite2D")
		var letter_node_pos = letter_node_sprite.global_position
		
		var falling_letter = preload("res://Main Scene/falling letter/falling_letter.tscn").instantiate()
		get_parent().add_child(falling_letter) # adds letter to main scene
		falling_letter.position = letter_node_pos
		falling_letter.letter = current_char[index]
		falling_letter.get_ready() # sets everything up
		
		letter_node.flash_undo()
		
		current_word = prev_word
		GameMangager.current_word = current_word

func reset_self():
	var box = $Control/HBoxContainer
	for child in box.get_children():
		child.queue_free()


func _on_home_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Level Select/level_select.tscn")
