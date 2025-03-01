extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func setNextBackground() -> void:
	var image = Image.load_from_file("res://Backgrounds/The_damaged_unit_4_reactor_and_shelter_at_Chernobyl_(02710141).jpg")
	
func setPerviousBackground() -> void:
	var image = Image.load_from_file("res://Backgrounds/Backyard-Swim-Pond-and-Fountain-1024x636.jpg")
	
