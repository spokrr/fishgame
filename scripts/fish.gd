extends Node2D


var speciesName
var speciesID
var rarity
var weight
var length
var inceptionTime

func roll_fish():
	# TODO: add luck in some way?
	#FishSpecies.rollSpecies()
	var query_string = "SELECT COUNT(*) FROM fishspecies"
	var speciesCountSuccess = FishDB.db.query(query_string)
	if speciesCountSuccess:
		var speciesCount = FishDB.db.query_result.pop_front()["COUNT(*)"]
		print("speciesCount: ", speciesCount)
	
