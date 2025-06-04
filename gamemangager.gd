extends Node

enum {EASY, MEDIUM, HARD, NOT_SET}
var level_mode : int = 1

var current_word = "CARE" # ALL THESE VALUES MUST BE UPPERCASE
var starting_word = "CARE"
var target_word = "BEAR"
var solution = ["B", "K", "E", "A", "R"]

var current_level = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_level(1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func load_level(level_num : int):
	var data : Array
	
	match level_mode:
		EASY:
			if LevelsDatabase.EASY_LEVELS.size() > level_num - 1:
				data = LevelsDatabase.EASY_LEVELS[level_num - 1]
			else:
				pass
		MEDIUM:
			if LevelsDatabase.MEDIUM_LEVELS.size() > level_num - 1:
				data = LevelsDatabase.MEDIUM_LEVELS[level_num - 1]
			else:
				pass
		HARD:
			if LevelsDatabase.HARD_LEVELS.size() > level_num - 1:
				data = LevelsDatabase.HARD_LEVELS[level_num - 1]
			else:
				pass
	
	
	#if LevelsDatabase.LEVELS.size() > level_num - 1:
		#data = LevelsDatabase.LEVELS[level_num - 1]
	#else:
		#print("quiting")
		#get_tree().quit()
		#return
	
	if data.is_empty():
		get_tree().change_scene_to_file("res://menu/menu.tscn")
		return false
	
	starting_word = data[0]
	target_word = data[1]
	
	var soulution_joined = data[2]
	
	solution = soulution_joined.split("")
	
	current_level = level_num
	
	#get_tree().reload_current_scene()
	
	#var new_scene = preload("res://main.tscn").instantiate()
	#get_tree().current_scene.queue_free()
	#get_tree().root.add_child(new_scene)
	#get_tree().current_scene = new_scene
	
	return true
