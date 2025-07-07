class_name ResourceDice
extends Resource


@export var values: Array[int] :
	get : return values
	set(value_): 
		values = value_ 
		
		process_values()


func process_values() -> void:
	pass
	
func roll():
	var index = randi_range(0, values.size() - 1)
	return values[index]
