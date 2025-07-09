class_name ResourceWarrior
extends Resource


var duel: ResourceDuel:
	get : return duel
	set(value_): 
		duel = value_ 
		
		strategy.duel_preparation()
var weapons: Array[ResourceWeapon]
var totems: Array[ResourceTotem]
var paces: Array[ResourceDicePace]
var aspects: Array[ResourceAspect]
var will: ResourceAspect = ResourceAspect.new(self, "will")
var mind: ResourceAspect = ResourceAspect.new(self, "mind")
var body: ResourceAspect = ResourceAspect.new(self, "body")
var strategy: ResourceStrategy = ResourceStrategy.new(self)
var avatar: ResourceAvatar = ResourceAvatar.new(self)
var guild: ResourceGuild

var n = 3


func _init(guild_: ResourceGuild) -> void:
	guild = guild_
	
	init_weapons()
	init_totems()
	init_paces()
	init_aspects()
	
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
	
func init_paces() -> void:
	var options = Global.dict.pace.weight.duplicate()
	
	for _i in n:
		#var pace = 0
		var pace = Global.get_random_key(options)
		var resource = load("res://resources/dice/pace/d6_pace_" + str(pace) + ".tres")
		paces.append(resource)
		options.erase(pace)
	
func init_aspects() -> void:
	aspects = [will, mind, body]
	
	var values = {}
	var bonuses = [5, 1]
	
	for aspect in aspects:
		values[aspect.type] = 4
	
	for bonus in bonuses:
		var aspect = aspects.pick_random()
		values[aspect.type] += bonus
	
	for aspect in aspects:
		for _i in values[aspect.type]:
			aspect.add_essence()
		
		aspect.reset()
	
func get_saturated_aspects() -> Array:
	var saturation_value = 149
	var saturated_aspects = []
	
	for aspect in aspects:
		var lack_of_saturation = int(pow(aspect.limit_value + 1, 2)) - aspect.essences.size()
		
		if lack_of_saturation < saturation_value:
			saturation_value = lack_of_saturation
			saturated_aspects = [aspect]
		if lack_of_saturation == saturation_value:
			saturated_aspects.append(aspect)
	
	return saturated_aspects
