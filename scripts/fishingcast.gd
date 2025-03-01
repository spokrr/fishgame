extends Node2D

var isCast
#@onready var fishingRodSprite = get_node("fishingRod")
var speed = 500


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	isCast = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	


func _input(event):
	if event.is_action_pressed("spaceBar"):
		isCast = castLine(isCast) # run the code for casting a line.

func castLine(isCast) -> bool:
	if isCast == false:
		isCast = true
		print("casting! teehee")
		visible = true
		pass
	elif isCast == true:
		isCast = false
		print("reeling in! teehee")
		visible = false
		pass
	
	return isCast
