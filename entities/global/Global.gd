extends Node


var rng = RandomNumberGenerator.new()
var arr = {}
var num = {}
var vec = {}
var color = {}
var dict = {}
var flag = {}
var node = {}
var scene = {}


func _ready() -> void:
	if dict.keys().is_empty():
		init_arr()
		init_color()
		init_dict()
	
	#get_tree().bourse.resource.after_init()
	
func init_arr() -> void:
	arr.aspect = ["will", "mind", "body"]
	arr.success = [-6, -3, -1, 0, 1, 3, 6]
	arr.pace = [-3, -2, -1, 0, 1, 2, 3]
	arr.element = ["aqua", "wind", "fire", "earth", "acid", "ice", "vapor", "dirt", "cloud", "lightning", "dust", "plasma", "lava", "metal"]
	arr.template = ["weapon", "totem", "pace"]
	arr.role = ["offense", "defense"]
	arr.archetype = ["weapon", "totem"]
	arr.mediator = ["vendor", "customer"]
	arr.temperament = ["calm", "greedy"]
	
	#arr.cliche = ["offense", "defense", "element"]
	
func init_dict() -> void:
	init_direction()
	
	init_synergy()
	init_combo()
	init_pace()
	init_essence()
	init_swap()
	init_archetype()
	
	dict.step = {}
	dict.step.role = {}
	dict.step.role["vendor"] = "surcharge"
	dict.step.role["customer"] = "discount"
	
func init_direction() -> void:
	dict.direction = {}
	dict.direction.linear2 = [
		Vector2i( 0,-1),
		Vector2i( 1, 0),
		Vector2i( 0, 1),
		Vector2i(-1, 0)
	]
	dict.direction.diagonal = [
		Vector2i( 1,-1),
		Vector2i( 1, 1),
		Vector2i(-1, 1),
		Vector2i(-1,-1)
	]
	
	dict.direction.hybrid = []
	
	for _i in dict.direction.linear2.size():
		var direction = dict.direction.linear2[_i]
		dict.direction.hybrid.append(direction)
		direction = dict.direction.diagonal[_i]
		dict.direction.hybrid.append(direction)
	
func init_color():
	pass
	#var h = 360.0
	
	#color.  Color.from_hsv(160 / h, 0.8, 0.5)
	
func init_synergy() -> void:
	dict.synergy = {}
	dict.synergy.value = {}
	
	dict.tag = {}
	dict.tag.all = {}
	dict.tag.defense = ["block", "parry", "dodge"]
	dict.tag.offense = ["puncture", "slash", "pressure"]
	dict.tag.pace = ["fast", "basic", "slow"]
	dict.tag.weapon = ["spear", "dagger", "axe", "sword", "hammer"]
	dict.tag.totem = ["snake", "mantis", "bear", "tiger", "elephant"]
	
	for type in dict.tag:
		if type != "all":
			for subtype in dict.tag[type]:
				dict.tag.all[subtype] = type
	
	var path = "res://entities/synergy/synergy.json"
	var array = load_data(path)
	
	for type in dict.tag:
		for subtype in dict.tag[type]:
			dict.synergy.value[subtype] = {}
	
	for synergy in array:
		#var tags = [synergy["first"], synergy["second"]]
		var first = synergy["first"]
		var second = synergy["second"]
		var value = int(synergy["value"])
		
		dict.synergy.value[first][second] = value
		dict.synergy.value[second][first] = value
	
	#for tag in dict.synergy.tag:
		#print([tag, dict.synergy.tag[tag].keys().size(), dict.synergy.tag[tag].keys()])
	
func init_combo() -> void:
	dict.combo = {}
	dict.combo.value = {}
	dict.combo.group = {}
	
	for totem in dict.tag.totem:
		for weapon in dict.tag.weapon:
			for pace in dict.tag.pace:
				for defense in dict.tag.defense:
					var value = 0
					var combo = [totem, weapon, pace, defense]
					
					for _i in combo.size():
						for _j in range(_i + 1, combo.size(), 1):
							#var first = combo[combo.keys()[_i]]
							#var second = combo[combo.keys()[_j]]
							var first = combo[_i]
							var second = combo[_j]
							value += dict.synergy.value[first][second]
					
					if !dict.combo.group.has(value):
						dict.combo.group[value] = []
					
					dict.combo.group[value].append(combo)
					dict.combo.value[combo] = value
				
				for offense in dict.tag.offense:
					var value = 0
					#var combo = {}
					#combo.totem = totem
					#combo.weapon = weapon
					#combo.pace = pace
					#combo.offense = offense
					
					#for _i in combo.keys().size():
						#for _j in range(_i + 1, combo.keys().size(), 1):
						
					var combo = [totem, weapon, pace, offense]
					
					for _i in combo.size():
						for _j in range(_i + 1, combo.size(), 1):
							#var first = combo[combo.keys()[_i]]
							#var second = combo[combo.keys()[_j]]
							var first = combo[_i]
							var second = combo[_j]
							value += dict.synergy.value[first][second]
					
					if !dict.combo.group.has(value):
						dict.combo.group[value] = []
					
					dict.combo.group[value].append(combo)
					dict.combo.value[combo] = value
	
	var values = dict.combo.group.keys()
	values.sort()
	
	#for value in values:
	#	print([value,  dict.combo.group[value].size()])
	#print([values[0], dict.combo.group[values[0]]])
	#print([values[values.size()-1], dict.combo.group[values[values.size()-1]]])
	
func init_pace() -> void:
	dict.pace = {}
	dict.pace.weight = {}
	dict.pace.weight[-3] = 2
	dict.pace.weight[-2] = 3
	dict.pace.weight[-1] = 4
	dict.pace.weight[0] = 5
	dict.pace.weight[1] = 4
	dict.pace.weight[2] = 3
	dict.pace.weight[3] = 2
	dict.pace.type = {}
	dict.pace.type[-1] = "slow"
	dict.pace.type[0] = "basic"
	dict.pace.type[1] = "fast"
	
func init_essence() -> void:
	dict.essence = {}
	
	for essence in arr.aspect:
		dict.essence[essence] = {}
	
	var path = "res://entities/essence/essence.json"
	var array = load_data(path)
	
	for essence in array:
		for key in dict.essence:
			if !dict.essence[key].has(essence.type):
				dict.essence[key][essence.type] = {}
				
			dict.essence[key][essence.type][essence.subtype] = int(essence[key])
	
func init_swap() -> void:
	dict.swap = {}
	dict.swap.role = {}
	dict.swap.role["offense"] = "defense"
	dict.swap.role["defense"] = "offense"
	
func init_archetype() -> void:
	dict.archetype = {}
	dict.archetype.triple = {}
	dict.archetype.synergy = {}
	dict.archetype.index = {}
	
	for archetype in arr.archetype:
		dict.archetype.triple[archetype] = []
	
	var path = "res://entities/archetype/archetype.json"
	var array = load_data(path)
	
	for archetype in array:
		var values = archetype.values.split(",")
		dict.archetype.triple[archetype.type].append(values)
	
	for weapons in dict.archetype.triple.weapon:
		for totems in dict.archetype.triple.totem:
			var archetype = {}
			archetype.weapons = weapons
			archetype.totems = totems
			dict.archetype.index[archetype] = dict.archetype.index.keys().size()
			
			dict.archetype.synergy[archetype] = {}
			dict.archetype.synergy[archetype].total = 0
			
			for role in arr.role:
				dict.archetype.synergy[archetype][role] = {}
				
				for tag in dict.tag[role]:
					dict.archetype.synergy[archetype][role][tag] = 0
			
			for weapon in weapons:
				for totem in totems:
					dict.archetype.synergy[archetype].total += dict.synergy.value[weapon][totem]
					
			for role in arr.role:
				for tag in dict.tag[role]:
					for weapon in weapons:
						dict.archetype.synergy[archetype][role][tag] += dict.synergy.value[weapon][tag]
					
					for totem in totems:
						dict.archetype.synergy[archetype][role][tag] += dict.synergy.value[totem][tag]
	
	#var total_sum = {}
	#
	#for role in arr.role:
		#total_sum[role] = {}
		#
		#for tag in dict.tag[role]:
			#total_sum[role][tag] = 0
	#
	#for archetype in dict.archetype.synergy:
		#for role in arr.role:
			#for tag in dict.archetype.synergy[archetype][role]:
				#total_sum[role][tag] += dict.archetype.synergy[archetype][role][tag]
	#
	#print(total_sum)
	
func save(path_: String, data_): #: String
	var file = FileAccess.open(path_, FileAccess.WRITE)
	file.store_string(data_)
	
func load_data(path_: String):
	var file = FileAccess.open(path_, FileAccess.READ)
	var text = file.get_as_text()
	var json_object = JSON.new()
	var _parse_err = json_object.parse(text)
	return json_object.get_data()
	
func get_random_key(dict_: Dictionary):
	if dict_.keys().size() == 0:
		print("!bug! empty array in get_random_key func")
		return null
	
	var total = 0
	
	for key in dict_.keys():
		total += dict_[key]
	
	rng.randomize()
	var index_r = rng.randf_range(0, 1)
	var index = 0
	
	for key in dict_.keys():
		var weight = float(dict_[key])
		index += weight/total
		
		if index > index_r:
			return key
	
	print("!bug! index_r error in get_random_key func")
	return null
	
func get_all_combinations_based_on_size(array_: Array, size_: int) -> Array:
	var combinations = {}
	combinations[0] = array_.duplicate()
	combinations[1] = []
	
	for child in array_:
		combinations[1].append([child])
	
	for _i in size_ - 1:
		set_combinations_based_on_size(combinations, _i + 2)
	
	return combinations[size_]
	
func set_combinations_based_on_size(combinations_: Dictionary, size_: int) -> void:
	var parents = combinations_[size_ - 1]
	combinations_[size_] = []
	
	for parent in parents:
		for child in combinations_[0]:
			if !parent.has(child):
				var combination = []
				combination.append_array(parent)
				combination.append(child)
				combination.sort_custom(func(a, b): return combinations_[0].find(a) < combinations_[0].find(b))
				
				if !combinations_[size_].has(combination):
					combinations_[size_].append(combination)
