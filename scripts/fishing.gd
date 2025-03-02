extends Sprite2D

var fishingTimer: Timer  # waiting for fish to get caught on hook 
var catchTimer: Timer # waiting for person to click screen to catch
#var fishCaught: bool = false # was fish caught

#var defaultFish: Fish = %fish.rollFish()

#min and max for fish waiting times.
var waitingMin: float = 2.0
var waitingMax: float = 5.0

#possible fishing states. the fishing logic is a state machine.
enum FishingStatus {
	Walking,
	CastAndWaiting,
	FishHooked
}
var fishingState = FishingStatus.Walking

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#defaults visibility to false, in case it wasn't hidden in editor.
	visible = false
	pass
	
func playAlert():
	var fishHookAlert: AudioStreamPlayer = get_node("background/FishHookAlert") # Replace with correct path
	if fishHookAlert:
		fishHookAlert.play()
	else:
		print("Error: FishHookAlert node not found!")
		
#function to generate and start the fishing timer
func generateFishingTimer() -> void:
	fishingTimer = Timer.new() # create a new Timer object
	add_child(fishingTimer) # child of our current node (?)
	fishingTimer.connect("timeout", onFishingTimerTimeout) # when timer reaches 0, call onFishingTimerTimeout
	var randomTime = randf_range(waitingMin, waitingMax)
	fishingTimer.start(randomTime)

#function to generate the catch timer when needed.
func generateCatchTimer() -> void:
	catchTimer = Timer.new() # same as above, but for catching timer
	add_child(catchTimer)
	catchTimer.connect("timeout", onCatchTimerTimeout)
	catchTimer.start(3.0) # then start catch timer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _input(event):
	if event.is_action_pressed("fish"):
		fishing()
		

#this will get called every time we hit the spacebar. overload it for different circumstances
func fishing():
	
	#if we were walking...
	if fishingState == FishingStatus.Walking: 
		#this action casts the fishing line and starts the timer for wait.
		print("Casting the fishing line...")
		fishingState = FishingStatus.CastAndWaiting #and now we wait.
		%playerRigidbody.castLine("casting")
		$fishingBob.visible = true
		$fishingBob/fishingBobberAnimation.play("in water")
		$fishingBob/fishingAlert.play("waiting")
		
		#initialize and start the fishing timer.
		 # timer randomized between 5 to 30 sec
		generateFishingTimer()
		print("fishingTimer started")

	#if we were cast and waiting...
	elif fishingState == FishingStatus.CastAndWaiting:
		#this block indicates, we want to go back to walking without catching anytihng.
		print("Reeling back in to fish elsewhere.")
		fishingState = FishingStatus.Walking
		fishingTimer.call_deferred("queue_free") #this needs to be deleted, since we're no longer fishing.
		%playerRigidbody.castLine("reeling")
		$fishingBob.visible = false
		
		# add a animated_sprite_2d.play("name") ?
	
	#if there was a fish hooked...
	elif fishingState == FishingStatus.FishHooked:
		#hooking means reeling it in.
		%playerRigidbody.castLine("reeling")
		$fishingBob.visible = false
		print("Nice job!")
		#run the info for your caught fish!
		catchFish()
		#after catching a fish, go baclk to walking.
		fishingState = FishingStatus.Walking

	
func onFishingTimerTimeout() -> void:
	fishingTimer.call_deferred("queue_free") #queue deletion of timer since it's done its job.
	print("Fish on the hook!") # when timer runs out, print
	playAlert()
	fishingState = FishingStatus.FishHooked
	$fishingBob/fishingBobberAnimation.stop()
	$fishingBob/fishingAlert.play("fishHooked")
	#generates a catch timer when a fish is hooked.
	generateCatchTimer()
	
	
func onCatchTimerTimeout() -> void:
	catchTimer.call_deferred("queue_free") #queue deletion of timer, now that it's done.
	print("The fish got away!")
	
	#if the timer runs out, it means we didn't reel, we're back to cast and waiting.
	fishingState = FishingStatus.CastAndWaiting
	$fishingBob/fishingBobberAnimation.play("in water")
	$fishingBob/fishingAlert.play("waiting")
	
	#generates a new fishing timer.
	generateFishingTimer()
	print("new fishingTimer started")


func catchFish() -> void:
	# if catchTimer doesn't run out, run our process function.
	catchTimer.stop() #stops the current timer
	catchTimer.call_deferred("queue_free") #goodbye timer. thank u for ur service.
	print("You got a fish!") # maybe supplement this with the fish name? #will do that when we have fish.
	
	
	showCaughtFish(Fish.new().roll_fish())


func showCaughtFish(caughtFish: Fish) ->void:
	print(caughtFish)
	#this code generates a new instance of the caughtfish UI.
	var newfishpopup = load("res://caught_fish_ui.tscn")
	var fishcaught = newfishpopup.instantiate()
	%uipopup.add_child(fishcaught)
	
	#set the contents of the new ui to that of the caught fish.
	#TODO: IMPLEMENT THE ROLLFISH FUNCTION ABOVE, SO THESE LINES CAN WORK. NEEDS TO BE DONE.
	fishcaught.position = Vector2(960,540)
	fishcaught.species.text = str("[center]",str(caughtFish.speciesName),"[/center]")
	fishcaught.image = str("res://fish/", caughtFish.speciesName, ".png")
	if caughtFish.speciesName == "tungstencube":
		fishcaught.image = "res://fish/tungsten.jpg"
	fishcaught.description.text = caughtFish.lore
	fishcaught.length.text = str(snapped(caughtFish.length, 0.01)) #caughtFish.length
	fishcaught.weight.text = str(snapped(caughtFish.weight, 0.01))
	
	
	fishcaught.visible = true #we save the visibility set for last.
	
	
	#$fishcaught/Timer.start(1.0) #timer so you don't yeet through the UI

	
	
