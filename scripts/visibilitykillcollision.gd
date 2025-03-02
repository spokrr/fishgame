extends StaticBody2D

func _ready() -> void:
	#_on_visible_changed(visible)
	pass

func cycle_visible(visibility):
	#print("visibility changed")
	self.visible = visibility
	if not visible:
		for shape in get_children():
			if shape is CollisionPolygon2D:
				shape.set_deferred("disabled",true)
				#print("visibility changed")
				#print(shape)
	else:
		for shape in get_children():
			if shape is CollisionPolygon2D:
				shape.set_deferred("disabled",false)
				#print("visibility changed")
				#print(shape)
