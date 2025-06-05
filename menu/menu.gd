extends Node2D

enum difficult {EASY, MEDIUM, HARD}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TransitionLayer/AnimationPlayer.play("Fade")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_easy_button_pressed() -> void:
	to_level_select(difficult.EASY)


func _on_medium_button_pressed() -> void:
	to_level_select(difficult.MEDIUM) 


func _on_hard_button_pressed() -> void:
	to_level_select(difficult.HARD)

func to_level_select(diffuclty : difficult):
	GameMangager.level_mode = diffuclty
	print(GameMangager.level_mode)
	print(diffuclty)
	get_tree().change_scene_to_file("res://level_select/level_select.tscn")
