extends Node


var speciesName
var speciesID
var rarity
var weight
var length
var inceptionTime

#TODO: (dan:) i need this to return a fish object, with attributes:
## species: string
## image: string (a reference value to the image location)
## length: int (can be randomized)
## weight: int (same as above)
## lore: string (just the description of the fish.)

func roll_fish():
	# TODO: add luck in some way?
	#FishSpecies.rollSpecies()
	var query_string = "SELECT COUNT(*) FROM fishspecies"
	var speciesCountSuccess = FishDB.db.query(query_string)
	if speciesCountSuccess:
		var speciesCount = FishDB.db.query_result.pop_front()["COUNT(*)"]
		print("speciesCount: ", speciesCount)
	
