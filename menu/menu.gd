extends Node2D

enum difficult {EASY, MEDIUM, HARD}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Time.get_ticks_msec()/1000 == 10: # Only Fades after Logo intro and never after
		$TransitionLayer/AnimationPlayer.play("Fade")
	else:
		$TransitionLayer.hide()


func _on_easy_button_pressed() -> void:
	to_level_select(difficult.EASY)


func _on_medium_button_pressed() -> void:
	to_level_select(difficult.MEDIUM) 


func _on_hard_button_pressed() -> void:
	to_level_select(difficult.HARD)


func to_level_select(diffuclty : difficult):
	GameMangager.level_mode = diffuclty # saves difficulty
	#print(GameMangager.level_mode) #debuging
	#print(diffuclty)
	get_tree().change_scene_to_file("res://level_select/level_select.tscn")
