extends CharacterBody2D


const speed = 500
@onready var screen_size = get_viewport_rect().size
enum CharState {
	FISHIN,
	WALKIN,
}
var state = CharState.WALKIN

func _ready() -> void:
	position = Vector2(400,500)

#this function will be called from the script on the rod, which handles the fishing.
#this specific function will update the visuals of the sprites.
func castLine():
	if state == CharState.WALKIN: # we're walkin, we want to fishin
		state = CharState.FISHIN
		#these visibility statements will get changed later.
		get_node("fishingRod").visible = true
		$playerSprite.play("fishing")
		
		#this gets removed for now, we'll call it on the rod itself
		#$fishingRod.fishing();
		
	elif state == CharState.FISHIN:
		state = CharState.WALKIN #  we walkin now
		get_node("fishingRod").visible = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if state == CharState.WALKIN:
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
