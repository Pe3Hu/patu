class_name ResourceAvatar
extends Resource


var warrior: ResourceWarrior
var cycle: ResourceCycle:
	get : return cycle
	set(value_): 
		cycle = value_ 
		
		for aspect in warrior.aspects:
			aspect.reset()
		
		template = tactic.templates[warrior.duel.cycle_current]
var role: String:
	get : return role
	set(value_): 
		role = value_ 
		
		warrior.duel.set(role, self)
		pass
var tactic: ResourceTactic
var template: ResourceTemplate
var synergy: int
var pool: ResourcePool
var wound: int = 0


func calc_synergy(episode_index_: int) -> void:
	var essence_index =  episode_index_ % template.kit.essences.size()
	var essence_type = template.kit.essences[essence_index].get(role)
	var pace_type = template.pace.roll()
	var combo = [template.totem.type, template.weapon.type, pace_type, essence_type]
	synergy = Global.dict.combo.value[combo]
	pool = load("res://resources/dice/pool/pool_" + str(synergy) + ".tres")
	pool.roll_dices()
	
func check_new_wound() -> bool:
	if warrior.body.current_value > warrior.body.limit_value:
		var wound_scope = 1 - float(warrior.body.current_value - warrior.body.limit_value) / (warrior.body.current_value - warrior.body.limit_value + 1)
		var wound_rnd = randf()
		
		if wound_rnd > wound_scope:
			wound += 1
			print([warrior.body.current_value, warrior.body.limit_value, wound_rnd, wound_scope])
			return true
	
	return false
	
func swap_role() -> void:
	role = Global.dict.swap.role[role]
