extends CharacterBody2D


const speed = 500
@onready var screen_size = get_viewport_rect().size

		
func _physics_process(delta: float) -> void:
	# Add the gravity.
	var direction = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown")
	velocity = direction*speed
	#print(position)
	move_and_slide()
	position = position.clamp(Vector2(0,0), Vector2(1920,1080))
	
	if Input.is_action_pressed("moveRight"):
		$playerSprite.play("default")
		#position.x += speed * delta
	elif Input.is_action_pressed("moveLeft"):
		$playerSprite.play("default")
		#position.x -= speed * delta
	elif Input.is_action_pressed("moveDown"):
		$playerSprite.play("default")
		#position.y += speed * delta
	elif Input.is_action_pressed("moveUp"):
		$playerSprite.play("default")
		#position.y -= speed * delta
	else:
		$playerSprite.stop()
