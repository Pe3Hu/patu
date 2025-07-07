class_name ResourceAspect
extends Resource


@export_enum("will", "mind", "body") var type: String

var essences: Array[ResourceEssence]
var current_value: int = 0
var limit_value: int = 0


func add_essence() -> void:
	var resource = ResourceEssence.new()
	resource.type = type
	essences.append(resource)
	limit_value = essences.size()
	
func reset() -> void:
	limit_value = floor(sqrt(essences.size()))
	current_value = 0
