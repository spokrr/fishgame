class_name FishSpecies
extends Node2D

var speciesID
var speciesName
var portrait
var base_weight
var base_length
var base_rarity
var catch_pool

#func roll_species() -> FishSpecies:
	
	
	

func fish_species_from_id(id) -> FishSpecies:
	var retFishSpecies = FishSpecies.new()
	retFishSpecies.speciesID = id
	
	return retFishSpecies
