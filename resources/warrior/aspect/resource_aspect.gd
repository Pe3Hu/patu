class_name ResourceAspect
extends Resource


@export_enum("will", "mind", "body") var type: String

var warrior: ResourceWarrior
var essences: Array[ResourceEssence]
var current_value: int = 0
var limit_value: int = 0


func _init(warrior_: ResourceWarrior, type_: String) -> void:
	warrior = warrior_
	type = type_
	
func add_essence() -> void:
	var resource = ResourceEssence.new(self, type)
	essences.append(resource)
	
func reset() -> void:
	limit_value = floor(sqrt(essences.size()))
	current_value = 0
	
func get_unique_cliches() -> Dictionary:
	var cliches = {}
	
	for essence in essences:
		if !cliches.has(essence.cliche):
			cliches[essence.cliche] = 0
		
		cliches[essence.cliche] += int(pow(essence.rank + 1, 2)) - 1
	
	return cliches
