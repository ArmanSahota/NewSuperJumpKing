extends Area2D
const EXPLOSTION = preload("res://Scenes/explostion.tscn")
var direction = 0.05
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	translate(Vector2.RIGHT * direction)
	$AnimatedSprite2D.flip_h = direction <0



func _on_timer_timeout():
	direction *= -1
	
func die():
	var new_explostion = EXPLOSTION.instantiate()
	new_explostion.global_position = global_position
	get_tree().current_scene.add_child(new_explostion)
	queue_free()
