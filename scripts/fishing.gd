extends Sprite2D

var fishingTimer: Timer  # waiting for fish to get caught on hook 
var catchTimer: Timer # waiting for person to click screen to catch
var currentlyFishing: bool = false # is rod currently in fishing timer
var fishCaught: bool = false # was fish caught

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fishingTimer = Timer.new() # create a new Timer object
	add_child(fishingTimer) # child of our current node (?)
	fishingTimer.connect("timeout", onFishingTimerTimeout) # when timer reaches 0, call onFishingTimerTimeout
	
	catchTimer = Timer.new() # same as above, but for catching timer
	add_child(catchTimer)
	catchTimer.connect("timeout", onCatchTimerTimeout)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if currentlyFishing and Input.is_action_just_pressed("spaceBar") and catchTimer.is_stopped() == false: # ui_accept should map to left click (?), just saw this line in a youtube video for godot fishing...
		catchFish()

func fishing():
	if currentlyFishing:
		return # can't start multiple fishing sessions
		# add a animated_sprite_2d.play("name") ?
		
	currentlyFishing = true
	fishCaught = false
	var randomTime = randf_range(5.0, 30.0) # timer randomized between 5 to 30 sec
	fishingTimer.start(randomTime) # start timer
	print("Casting the fishing line...")
	
func onFishingTimerTimeout() -> void:
	print("Fish on the hook!") # when timer runs out, print
	catchTimer.start(3.0) # then start catch timer
	
func onCatchTimerTimeout() -> void:
	if not fishCaught: # if catch timer runs out, this function runs
		print("The fish got away!")
	currentlyFishing = false

func catchFish() -> void:
	# if catchTimer doesn't run out, run our process function.
	print("You got a fish!") # maybe supplement this with the fish name?
	fishCaught = true
	currentlyFishing = false
	catchTimer.stop()
	
