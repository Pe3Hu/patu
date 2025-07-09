class_name ResourceKit
extends Resource


var essences: Array[ResourceEssence] :
	get : return essences
	set(value_): 
		essences = value_ 
		
		process_essences()
var expectations: Dictionary



func _init(essences_: Array[ResourceEssence]) -> void:
	essences = essences_
	
func process_essences() -> void:
	expectations = {}
	
	for role in Global.arr.role:
		expectations[role] = {}
	
	for essence in essences:
		for role in Global.arr.role:
			var essence_type = essence.get(role)
			
			if !expectations[role].has(essence_type):
				expectations[role][essence_type] = 0
			
			expectations[role][essence_type] += 1.0 / essences.size()
	
	#print(essences.size(), expectations)
