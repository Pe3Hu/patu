class_name ResourceWarrior
extends Resource


@export var weapons: Array[ResourceWeapon]
@export var totems: Array[ResourceTotem]
@export var essences: Array[ResourceEssence]
@export var temps: Array[ResourceDiceTemp]


var n = 3


func _init() -> void:
	init_weapons()
	init_totems()
	init_temps()
	init_essences()
	
func init_weapons() -> void:
	var options = Global.dict.tag.weapon.duplicate()
	options.shuffle()
	
	for _i in n:
		var resource = ResourceWeapon.new()
		resource.type = options.pop_front()
		weapons.append(resource)
	
func init_totems() -> void:
	var options = Global.dict.tag.totem.duplicate()
	options.shuffle()
	
	for _i in n:
		var resource = ResourceTotem.new()
		resource.type = options.pop_front()
		totems.append(resource)
	
func init_temps() -> void:
	for _i in n:
		var temp = 0
		#var temp = Global.get_random_key(Global.dict.temp.weight)
		var resource = load("res://resources/dice/temp/d6_temp_" + str(temp) + ".tres")
		temps.append(resource)
	
func init_essences() -> void:
	var values = {}
	var bonuses = [5, 1]
	
	for essence in Global.arr.essence:
		values[essence] = 4
	
	for bonus in bonuses:
		var essence = Global.arr.essence.pick_random()
		values[essence] += bonus
	
	for essence in values:
		for _i in values[essence]:
			var resource = ResourceEssence.new()
			resource.type = essence
			essences.append(resource)
		
