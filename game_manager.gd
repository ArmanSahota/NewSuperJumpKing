extends Node

@onready var keys_label = %KeysLabel
var key_founded = []
var keys = 0

	
func add_keys():
	keys += 1
	print(keys)
	keys_label.text = "Keys: " + str(keys)
