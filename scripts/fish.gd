extends Object
class_name Fish

#i put this script on an empty node, because the script needs to be on an object 
#for me to access it from another script. weird, idk how else to do it
var speciesName
var speciesID
var rarity
var weight
var length
var inceptionTime
var lore

func rarity_upgrade():
	match rarity:
		"COMMON":
			rarity = "UNCOMMON"
		"UNCOMMON":
			rarity = "RARE"
		"RARE":
			rarity = "EPIC"
		"EPIC":
			rarity = "LEGENDARY"
		"LEGENDARY":
			rarity = "MYTHIC"
		"MYTHIC":
			rarity = "EXOTIC"
		"EXOTIC":
			rarity = "TUNGSTEN"
		_: # add +s if already tungsten
			rarity = str(rarity,"+")

func roll_fish() -> Fish: # will return err in some broken states (db not open?)
	# TODO: add luck in some way?
	#FishSpecies.rollSpecies()
	var returnFish: Fish = Fish.new();
	var catch_pool = ((randi() % 100) + 1)
	var chosen_pool
	# this match should set chosen_pool to one of the catch_pools
	match catch_pool:
		100:
			chosen_pool = 1
		[90, ..]:
			chosen_pool = 9
		[70, ..]:
			chosen_pool = 20
		[40, ..]:
			chosen_pool = 30
		_:
			chosen_pool = 40
	var query_string = str("SELECT COUNT(*) FROM fishspecies WHERE catch_pool=",chosen_pool)
	if not FishDB.db.query(query_string):
		# print("failed to query DB for COUNT(*) where catch pool")
		assert(false, "failed to query DB for COUNT(*) where catch pool")
	# parse the value from the DB to get the total species in that catch pool
	var speciesCount = FishDB.db.query_result.pop_front()["COUNT(*)"]
	query_string = str("SELECT * FROM fishspecies WHERE catch_pool=", chosen_pool)
	if not FishDB.db.query(query_string):
		# print("failed to query DB for fish of that catch pool")
		assert(false, "failed to query DB for fish of that catch pool")
	# roll a random number between 0 and speciesCount-1 then use it to pick the index of our species
	var pickedSpeciesIndex = randi() % speciesCount
	var speciesDict = FishDB.db.query_result[pickedSpeciesIndex]
	print(str(speciesDict["name"], "<== that's the species we picked from this fishing"))
	returnFish.speciesName = speciesDict["name"]
	returnFish.speciesID = speciesDict["id"]
	returnFish.rarity = speciesDict["base_rarity"]
	while randi() % 2 == 1:
		returnFish.rarity_upgrade()
	returnFish.lore = speciesDict["lore"]
	returnFish.inceptionTime = Time.get_time_string_from_system()
	returnFish.weight = randfn(1, 0.2) * speciesDict["base_weight"]
	returnFish.length = randfn(1, 0.2) * speciesDict["base_length"]
	
	
	
	return returnFish
	
