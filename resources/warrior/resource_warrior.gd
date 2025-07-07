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
var will: ResourceAspect = ResourceAspect.new()
var mind: ResourceAspect = ResourceAspect.new()
var body: ResourceAspect = ResourceAspect.new()
var strategy: ResourceStrategy = ResourceStrategy.new()
var avatar: ResourceAvatar = ResourceAvatar.new()

var n = 3


func _init() -> void:
	strategy.warrior = self
	avatar.warrior = self
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
	will.type = "will"
	mind.type = "mind"
	body.type = "body"
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
	
