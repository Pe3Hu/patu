class_name Stronghold
extends MarginContainer


var zone_count = 5
var l = 60
var region_counter =  0
var region_offsets = {}


func _ready() -> void:
	init_zones()
	
func init_zones() -> void:
	%Zones.position = custom_minimum_size / 2
	
	for _i in zone_count:
		add_zone()
	
	for zone in %Zones.get_children():
		for region in zone.get_children():
			region.recolor()
	
func add_zone() -> void:
	var zone = Zone.new(self)
	%Zones.add_child(zone)
	%Zones.move_child(zone, 0)
