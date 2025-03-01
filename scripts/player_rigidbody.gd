extends CharacterBody2D


const speed = 500
@onready var screen_size = get_viewport_rect().size
var isCast = false

func _ready() ->void:
	position = Vector2(400,500)


func _input(event):
	if event.is_action_pressed("spaceBar"):
		isCast = castLine(isCast) # run the code for casting a line.

func castLine(isCast) -> bool:
	if isCast == false:
		isCast = true
		get_node("fishingRod").visible = true
		$playerSprite.play("fishing")
		$fishingRod.fishing();
		
	elif isCast == true:
		isCast = false
		get_node("fishingRod").visible = false
		
	return isCast

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if isCast == false: 
		var direction = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown")
		
		velocity = direction*speed
		move_and_slide()
		position = position.clamp(Vector2(0,0), screen_size)
		
		if Input.is_action_pressed("moveRight"):
			$playerSprite.play("MoveR")
		elif Input.is_action_pressed("moveLeft"):
			$playerSprite.play("MoveL")
		elif Input.is_action_pressed("moveDown"):
			$playerSprite.play("MoveL")
		elif Input.is_action_pressed("moveUp"):
			$playerSprite.play("MoveR")
		else:
			$playerSprite.play("default")
