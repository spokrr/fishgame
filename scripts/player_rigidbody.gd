extends CharacterBody2D


const speed = 500
@onready var screen_size = get_viewport_rect().size
enum CharState {
	FISHIN,
	WALKIN,
}
var state = CharState.WALKIN

func _ready() -> void:
	position = Vector2(400,200)

#this function will be called from the script on the rod, which handles the fishing.
#this specific function will update the visuals of the sprites.
func castLine(fishingstate):
	if fishingstate == "casting": #if the calling function calls to cast the line.
		state = CharState.FISHIN #cast, and fishin now.
		get_node("fishingRod").visible = true
		$playerSprite.play("fishing")
		$fishingRod/fishingBob/fishingBobberAnimation.play("in water")

		
	elif fishingstate == "reeling":
		state = CharState.WALKIN #  we walkin now
		$playerSprite.play("default")
		get_node("fishingRod").visible = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if state == CharState.WALKIN:
		var direction = Input.get_vector("moveLeft", "moveRight", "ui_text_delete_all_to_right.macos", "ui_text_delete_all_to_right")
		
		velocity = direction*speed
		move_and_slide()
		position = position.clamp(Vector2(0,0), screen_size)
		
		if Input.is_action_pressed("moveRight"):
			$playerSprite.play("MoveR")
		elif Input.is_action_pressed("moveLeft"):
			$playerSprite.play("MoveL")
		#elif Input.is_action_pressed("moveDown"):
			#$playerSprite.play("MoveL")
		#elif Input.is_action_pressed("moveUp"):
			#$playerSprite.play("MoveR")
		else:
			$playerSprite.play("default")
