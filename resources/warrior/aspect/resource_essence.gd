class_name ResourceEssence
extends Resource


@export_enum("will", "mind", "body") var type: String :
	get : return type
	set(value_): 
		type = value_ 
		
		init_cliche()

@export var aspect: ResourceAspect
@export var cliche: ResourceCliche

var rank: int = 1

func _init(aspect_: ResourceAspect, type_: String) -> void:
	aspect = aspect_
	type = type_
	
func init_cliche() -> void:
	var offense = Global.get_random_key(Global.dict.essence[type]["offense"])
	var defense = Global.get_random_key(Global.dict.essence[type]["defense"])
	var element = Global.get_random_key(Global.dict.essence[type]["element"])
	cliche = aspect.warrior.guild.auction.cliche_essences[type][offense][defense][element]
