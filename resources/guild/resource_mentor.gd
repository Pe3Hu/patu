class_name ResourceMentor
extends Resource


var guild: ResourceGuild
var priority_cliches: Dictionary


func _init(guild_: ResourceGuild) -> void:
	guild = guild_
	
func prepare_development_plan() -> void:
	priority_cliches = {}
	
	for warrior in guild.warriors:
		var aspects = warrior.get_saturated_aspects() 
		
		for aspect in aspects:
			var cliches = aspect.get_unique_cliches()
			
			for cliche in cliches:
				if !priority_cliches.has(cliche):
					priority_cliches[cliche] = 0
			
				priority_cliches[cliche] += cliches[cliche]
	
	normalize_priority_cliches()
	
func normalize_priority_cliches() -> void:
	var min_priority = priority_cliches[priority_cliches.keys().front()]
	
	for cliche in priority_cliches:
		if min_priority > priority_cliches[cliche]:
			min_priority = priority_cliches[cliche]
	
	for cliche in priority_cliches:
		priority_cliches[cliche] = floor(priority_cliches[cliche] / min_priority)
	
