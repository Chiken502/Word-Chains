extends Node2D

var difficulty : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var difficulty = GameMangager.level_mode
	print(difficulty)
	
	match GameMangager.level_mode:
		GameMangager.EASY:
			$Control/TextureButton.pressed_color = Color("76ff60")
			$Control/TextureButton.hovered_color = Color("dcffd7")
		GameMangager.MEDIUM:
			$Control/TextureButton.pressed_color = Color("617cff")
			$Control/TextureButton.hovered_color = Color("d6ddff")
		GameMangager.HARD:
			$Control/TextureButton.pressed_color = Color("ff6161")
			$Control/TextureButton.hovered_color = Color("ffd6d6")
	
	
	spawn_buttons()

func spawn_buttons():
	print("spawning")
	var levels : Array[Array]
	
	match GameMangager.level_mode:
		0:
			levels = LevelsDatabase.EASY_LEVELS
		1:
			levels = LevelsDatabase.MEDIUM_LEVELS
		2:
			levels = LevelsDatabase.HARD_LEVELS
		#_: # this is an else statment
			#print("failed ", difficulty)
			#return
	
	print(levels)
	
	var size = levels.size()
	print(size)
	for i in size:
		var button = preload("res://level_select/level_Select_button.tscn").instantiate()
		button.level = i + 1
		$Control/GridContainer.add_child(button)
		
		match GameMangager.level_mode:
			GameMangager.EASY:
				button.normal_color = Color("9bff8b")
				button.pressed_color = Color("76ff60")
				button.hovered_color = Color("beffb4")
			GameMangager.MEDIUM:
				button.normal_color = Color("8a9eff")
				button.pressed_color = Color("617cff")
				button.hovered_color = Color("b3c0ff")
			GameMangager.HARD:
				button.normal_color = Color("ff8a8a")
				button.pressed_color = Color("ff6161")
				button.hovered_color = Color("ffb3b3")


func _on_texture_button_pressed() -> void:
	get_tree().change_scene_to_file("res://menu/menu.tscn")
