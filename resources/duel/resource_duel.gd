class_name ResourceDuel
extends Resource


var warriors: Array[ResourceWarrior]
var offense: ResourceAvatar
var defense: ResourceAvatar
var cycles: Array[ResourceCycle]
var cycle_current: int = 0
var cycle_cycle: int = 3


func add_warrior(warrior_: ResourceWarrior) -> void:
	warrior_.duel = self
	warriors.append(warrior_)
	
func start() -> void:
	warriors.shuffle()
	warriors.front().avatar.role = "offense"
	warriors.back().avatar.role = "defense"
	
	init_cycles()
	start_cycle()
	
func init_cycles() -> void:
	for _i in cycle_cycle:
		var cycle = ResourceCycle.new(self)
		cycles.append(cycle)
	
func start_cycle() -> void:
	for warrior in warriors:
		warrior.avatar.cycle = cycles[cycle_current]
	
	cycles[cycle_current].start()
	
func end_cycle() -> void:
	cycle_current += 1
	
	if cycle_cycle > cycle_current:
		start_cycle()
	else:
		finish()
	
func finish() -> void:
	for cycle in cycles:
		print([cycles.find(cycle), cycle.winner, cycle.episodes.size()])
