extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("hi im main script")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("moveLeft"):
		pass #debugging
		#move left
	if Input.is_action_pressed("moveRight"):
		pass # debugging
		#move right
