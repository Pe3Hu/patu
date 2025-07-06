class_name ResourceEssence
extends Resource


@export_enum("will", "mind", "body") var type: String :
	get : return type
	set(value_): 
		type = value_ 
		
		init_defense()
		init_offense()
		add_element()
@export_enum("block", "parry", "dodge") var defense: String
@export_enum("puncture", "slash", "pressure") var offense: String
@export var elements: Array[ResourceDiceElement]


func init_defense() -> void:
	defense = Global.get_random_key(Global.dict.essence[type]["defense"])
	
func init_offense() -> void:
	offense = Global.get_random_key(Global.dict.essence[type]["offense"])
	
func add_element() -> void:
	var element = Global.get_random_key(Global.dict.essence[type]["element"])
	element = "aqua"
	var resource = load("res://resources/dice/element/d6_element_" + element + ".tres")
	elements.append(resource)
