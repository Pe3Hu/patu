class_name ResourceCycle
extends Resource


var duel: ResourceDuel
var episodes: Array[ResourceEpisode]
var winner: ResourceAvatar:
	get : return winner
	set(value_): 
		winner = value_ 
		
		duel.finish()


func _init(duel_: ResourceDuel) -> void:
	duel = duel_
	
func start() -> void:
	while !winner:
		add_episode()
	
	duel.end_cycle()
	
func add_episode() -> void:
	var episdoe = ResourceEpisode.new(self)
	episodes.append(episdoe)
