#@tool
extends Label

signal letter_changed(node, letter)

var scripted_parent : Node2D

var letter = "A"
var colliding_body : RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_on_resized()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func change_letter(new_letter : String):
	letter_changed.emit(self, new_letter)
	#var node = await scripted_parent.word_confirmed
	#if node == self:
		#print("sucseces")
		#text = new_letter.to_upper()
		#letter = new_letter.to_upper()

func _on_resized() -> void:
	var new_pos = size/2
	$Sprite2D.position = new_pos
	$Sprite2D.position.y -= 3


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("falling letter"):
		if body.being_draged:
			var new_letter = body.letter
			colliding_body = body
			letter_changed.emit(self, new_letter)

func _on_word_confirmed(node, new_letter : String):
	if node == self:
		if colliding_body:
			print("sucseces")
			text = new_letter.to_upper()
			letter = new_letter.to_upper()
			
			colliding_body.queue_free()
			colliding_body = null
			
			$Sprite2D.modulate = Color("617cff")
			$AnimationPlayer.play("flash")

func _on_word_not_found(node):
	$Sprite2D.modulate = Color("ff6161")
	$AnimationPlayer.play("flash")
	if node == self:
		colliding_body.modulate = Color("ff6161")
		var tween = get_tree().create_tween()
		tween.tween_property(colliding_body, "modulate", Color("ff6161"), 0.5)


func succses():
	$Sprite2D.modulate = Color("76ff60")
	$AnimationPlayer.play("flash")

func flash_undo():
	$Sprite2D.z_index = 0
	$Sprite2D.modulate = Color("617cff")
	$AnimationPlayer.play("flash")
	await $AnimationPlayer.animation_finished
	$Sprite2D.z_index = -1
