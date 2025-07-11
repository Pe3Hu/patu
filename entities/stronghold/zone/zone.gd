class_name Zone
extends Node2D


@export var stronghold: Stronghold
var index: int


func _init(stronghold_: Stronghold) -> void:
	stronghold = stronghold_
	index = stronghold.get_node("%Zones").get_child_count()
	
	init_regions()
	
func init_regions() -> void:
	for _i in index + 1:
		add_region()
	
	stronghold.region_offsets[index] = get_child_count()
	
	if index > 0:
		stronghold.region_offsets[index] += stronghold.region_offsets[index - 1] - 1
	
func add_region() -> void:
	var region = Region.new(self)
	add_child(region)
	stronghold.region_counter += 1
