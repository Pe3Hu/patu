class_name ResourceClicheEssence
extends ResourceCliche


@export_enum("will", "mind", "body") var aspect: String
@export_enum("block", "parry", "dodge") var defense: String
@export_enum("puncture", "slash", "pressure") var offense: String
@export var element: ResourceDiceElement


func _init(aspect_: String, defense_: String, offense_: String, element_: String) -> void:
	aspect = aspect_
	defense = defense_
	offense = offense_
	element = load("res://resources/dice/element/d6_element_" + element_ + ".tres")
