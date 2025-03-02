extends Node

var db = SQLite.new();
var db_path = "res://data/fishbase.db"
var table_name = "fishspecies"
#var fish_species_table_dict: Dictionary = {
	#"id": {"data_type":"int", "primary_key": true, "not_null": true, "auto_increment": true},
	#"name": {"data_type":"text", "not_null": true},
	#"portrait": {"data_type":"blob", "not_null": false},
	#"base_weight": {"data_type":"real", "not_null": true},
	#"base_length": {"data_type":"real", "not_null": true},
	## should be one of the Rarities defined in the enum below (all caps!)
	#"base_rarity": {"data_type":"text", "not_null": true},
	## Should be one of 40%, 30%, 20%, 9%, and 1%
	## determines which probability pool the fish can be caught in
	#"catch_pool": {"data_type":"int", "not_null": true}
#}
enum Rarities {
	COMMON,
	UNCOMMON,
	RARE,
	EPIC,
	LEGENDARY,
	MYTHIC,
	EXOTIC,
	TUNGSTEN
}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("hi im main script")
	openDB();


# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta: float) -> void:
# 	pass

func openDB():
	#var db_open_sucess = db_open();
	db.path = db_path
	db.open_db()
	
	# if the table already existed, delete it and make the new one
	# removed because fishDB is going to be static
	#db.query_with_bindings("SELECT name FROM sqlite_master WHERE type='table' AND name=?;", [table_name])
	#if not db.query_result.is_empty():
		#db.drop_table(table_name)
	#db.create_table(table_name, fish_species_table_dict)
	
	# (dan:) we don't need to preload the texture here. all we need to do is save the filepath; then we can access that later. 
	#var salmonTexture := preload("res://fish/salmon.png")
	#var tex_data: PackedByteArray = salmonTexture.get_image().save_png_to_buffer()
	#var row_dict: Dictionary = { # construct the salmon row and insert it to the db
		#"name": "salmon",
		#"portrait": tex_data,
		#"base_weight": 10,
		#"base_length": 40,
		#"base_rarity": "COMMON",
		#"catch_pool": 40
	#}
	#db.insert_row(table_name, row_dict)
