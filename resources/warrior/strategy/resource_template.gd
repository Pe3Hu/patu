class_name ResourceTemplate
extends Resource


var strategy: ResourceStrategy
var weapon: ResourceWeapon
var totem: ResourceTotem
var pace: ResourceDicePace
var kit: ResourceKit
var index : int :
	get : return index
	set(value_): 
		index = value_ 
		
		update_synergy()
var synergy: Dictionary


func update_synergy() -> void:
	synergy.avg = Global.dict.synergy.value[weapon.type][totem.type]
	
	for pace_type in pace.expectations:
		var weapon_value = Global.dict.synergy.value[weapon.type][pace_type]
		var totem_value = Global.dict.synergy.value[totem.type][pace_type]
		var expectation = pace.expectations[pace_type]
		synergy.avg += (weapon_value + totem_value) * expectation
	
	var tags = ["offense", "defense"]
	
	for tag in tags:
		for tag_type in kit.expectations[tag]:
			var weapon_value = Global.dict.synergy.value[weapon.type][tag_type]
			var totem_value = Global.dict.synergy.value[totem.type][tag_type]
			var expectation = kit.expectations[tag][tag_type]
			synergy[tag] = synergy.avg + (weapon_value + totem_value) * expectation
	
	synergy.avg = (synergy.offense + synergy.defense) / 2
	
	#for _i in Global.arr.template.size():
		#for _j in range(_i + 1, Global.arr.template.size(), 1):
			##var first = Global.arr.template[Global.arr.template.keys()[_i]]
			##var second = Global.arr.template[Global.arr.template.keys()[_j]]
			#var first = Global.arr.template[_i]
			#var second = Global.arr.template[_j]
			#synergy += Global.dict.synergy.value[first][second]
	
func get_indexs() -> Array:
	var indexs = []
	indexs.append(strategy.warrior.weapons.find(weapon))
	indexs.append(strategy.warrior.totems.find(totem))
	indexs.append(strategy.warrior.paces.find(pace))
	indexs.append(strategy.kits.find(kit))
	return indexs
