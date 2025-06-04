extends TextureButton

var normal_color : Color = Color("ffffff")
var pressed_color : Color = Color("617cff")
var hovered_color : Color = Color("ffffff")
var disabled_color : Color = Color("041e40")

var level : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_level()

func set_level():
	$Label.text = str(level)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if disabled:
		self_modulate = disabled_color
	elif button_pressed:
		self_modulate = pressed_color
	elif is_hovered():
		self_modulate = hovered_color
	else:
		self_modulate = normal_color
	
	#if get_parent().get_node("Word").undo_history:
		#disabled = false
	#else:
		#disabled = true
#
	#if get_parent().get_node("Word").completed:
		#disabled = true


func _on_pressed() -> void:
	GameMangager.current_level = level
	GameMangager.load_level(level)
	get_tree().change_scene_to_file("res://main.tscn")
