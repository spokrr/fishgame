extends Control

var seen: bool = false

@onready var description= get_node("lore/description")
@onready var species = get_node("species/fishSpeciesLabel")
@onready var length = get_node("stats/length")
@onready var weight = get_node("stats/weight")
@onready var image = get_node("fishImage")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	seen = false
	$Timer.start(2)

func _input(event):
	if event is InputEventKey and event.pressed:
		if seen:
			queue_free()


func _on_timer_timeout() -> void:
	seen = true
	$Timer.call_deferred("queue_free")
	pass # Replace with function body.
