extends Node2D

@onready var levelsDict = {
		0: %level0,
		1: %level1,
		2: %level2,
		#3: %level3, #removing these bc they're technically not CC
		#4: %level4,
}

#game starts in this level.
var currentLevel = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#debug
	print("readyupbackground")
	
	#cycles all levels visibility to off; in case the editor had them visible.
	for i in levelsDict:
		levelsDict[i].cycle_visible(false)
	
	#sets the base level's visibility to true.
	levelsDict[currentLevel].cycle_visible(true)
	
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


#when entering the trigger on the left side of the screen
#go to the previous biome
func _on_left_area_body_entered(body: Node2D) -> void:
	if currentLevel != 0 && body == %playerRigidbody:
		levelsDict[currentLevel].cycle_visible(false)
		currentLevel-=1
		levelsDict[currentLevel].cycle_visible(true)		
		%playerRigidbody.position = Vector2(1740,340)

#when entering the trigger on the right side of the screen
#go to the next biome
func _on_right_area_body_entered(body: Node2D) -> void:
	if currentLevel < 2 && body == %playerRigidbody:
		levelsDict[currentLevel].cycle_visible(false)
		currentLevel+=1
		levelsDict[currentLevel].cycle_visible(true)
		%playerRigidbody.position = Vector2(240,340)
