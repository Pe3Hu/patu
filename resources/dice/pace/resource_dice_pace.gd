class_name ResourceDicePace
extends ResourceDice

#@export var types: Array[String]

var expectations: Dictionary


func process_values() -> void:
	init_expectations()
	
func init_expectations() -> void:
	expectations = {}
	
	for value in values:
		var type = Global.dict.pace.type[value]
		
		if !expectations.has(type):
			expectations[type] = 0
		
		expectations[type] += float(1) / values.size()
	
func roll():
	var index = randi_range(0, values.size() - 1)
	var value = values[index]
	return Global.dict.pace.type[value]
