extends Node

var dictoinary = ""
var words : Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dictoinary = get_file_contents()
	words = dictoinary.split("\n", false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if words.is_empty():
		dictoinary = get_file_contents()
		words = dictoinary.split("\n", false)

func is_legal_word(word : String) -> bool:
	return word.to_lower() in words

func get_file_contents():
	var file_path = "res://Globals/Auto Loads/dictionary/12dicts_words.txt"
	var file = FileAccess.open(file_path, FileAccess.READ)
	#var file = ResourceLoader.load(file_path)
	
	if file:
		var file_content = file.get_as_text()
		return file_content
	else:
		push_warning("Could not load dictioary")
		print("Could not load dictioary")
		return null
