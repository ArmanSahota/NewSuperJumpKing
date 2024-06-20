extends Area2D

@onready var character_body_2d = $CharacterBody2D  # Ensure this path is correct
@onready var game_manager = %GameManager

func _ready():
	$AnimationPlayer.connect("animation_finished", Callable(self, "_on_animation_finished"))

func _input(event):
	pass
		
			
	

func _on_animation_finished(anim_name):
	if anim_name == "open_door":
		next_level()

func next_level():
	var ERR = get_tree().change_scene_to_file("res://Scenes/Level3.tscn")
	if ERR != OK:
		print("Failed to change scene: ", ERR)

func character_checker(body):
	if body.is_in_group("Main"):
		if game_manager.keys == 1:
			$AnimationPlayer.play("open_door")
			
		else:
			return
		

func _on_body_entered(body):
	character_checker(body)
