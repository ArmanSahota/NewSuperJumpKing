extends Node2D
@onready var game_manager = %GameManager


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	game_manager.key_founded.append(self.name)
	queue_free()
	game_manager.add_keys()
	
