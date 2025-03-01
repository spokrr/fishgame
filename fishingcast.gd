extends Node

var isCast

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	isCast = false
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("spaceBar"):
		castLine(isCast) # run the code for casting a line.

func castLine(isCast) -> void:
	if isCast == false:
		$player/fishingRod.show()
		pass
	if isCast == true:
		$player/fishingRod.hide()
		pass
