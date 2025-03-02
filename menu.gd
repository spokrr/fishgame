extends Control

func _on_play_pressed() -> void:
	# this should attach to our main game scene, assumingly  start scene
	get_tree().change_scene_to_file("res://starter scene.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
