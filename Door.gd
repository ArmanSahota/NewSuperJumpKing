extends Area2D

@onready var character_body_2d = $CharacterBody2D  # Ensure this path is correct
@onready var game_manager = %GameManager

func _ready():
	$AnimationPlayer.connect("animation_finished", Callable(self, "_on_animation_finished"))

func _input(event):
	if event.is_action_pressed("ui_accept") and game_manager.keys == 1:
		for body in get_overlapping_bodies():
			if body is CharacterBody2D:
				$AnimationPlayer.play("open_door")
				body.play_walk_in_animation()  # Call the method on the specific character instance
				break
		
			
	

func _on_animation_finished(anim_name):
	if anim_name == "open_door":
		next_level()

func next_level():
	var ERR = get_tree().change_scene_to_file("res://Scenes/Level2.tscn")
	if ERR != OK:
		print("Failed to change scene: ", ERR)


func _on_body_entered(body):
	pass # Replace with function body.
