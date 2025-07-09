class_name ResourceEpisode
extends Resource


var cycle: ResourceCycle
var index: int
var offenses: Array[int]
var defenses: Array[int]


func _init(cycle_: ResourceCycle) -> void:
	cycle = cycle_
	
	index = cycle.episodes.size()
	outcome_calculation()
	
func outcome_calculation() -> void:
	for warrior in cycle.duel.warriors:
		warrior.avatar.calc_synergy(index)
		set(warrior.avatar.role+"s", warrior.avatar.pool.successes)
	
	for _i in offenses.size():
		var wound = offenses[_i] - defenses[_i]
		
		if wound > 0:
			cycle.duel.defense.warrior.body.current_value += wound
	
	var wound_flag = cycle.duel.defense.check_new_wound()
	
	if wound_flag:
		cycle.winner = cycle.duel.offense
	
	for warrior in cycle.duel.warriors:
		warrior.avatar.swap_role()
