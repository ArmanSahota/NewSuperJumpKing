extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func take_damage():
	$AnimatedSprite.animation = "open_door";
	var t = Timer.new()
	t.set_wait_time(0.1)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
