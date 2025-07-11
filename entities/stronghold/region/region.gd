class_name Region
extends Polygon2D


@export var zone: Zone
var index: int


func _init(zone_: Zone) -> void:
	zone = zone_
	index = zone.get_child_count()
	
	init_vertexs()
	
func init_vertexs() -> void:
	var vertexs = []
	var n = 60
	var steps = zone.index + 1
	var l = zone.stronghold.l * steps
	var vertex_step = n / steps
	var angle_step = PI * 2 / n
	
	if zone.index > 0:
		vertexs.append(Vector2())
	
	for _i in vertex_step + 1:
		var vertex = Vector2.from_angle(-PI / 2 + angle_step * (_i + index * vertex_step)) * l
		vertexs.append(vertex)
	
	polygon = vertexs
	
func recolor() -> void:
	var shifted_index = index + zone.stronghold.region_offsets[zone.index]
	var h = float(shifted_index) / (zone.stronghold.region_counter + 1)
	var s = 0.8
	var v = 0.8
	
	if shifted_index % 2 == 1:
		h = float(zone.stronghold.region_counter + 1 - shifted_index) / (zone.stronghold.region_counter + 1)
		
		if h > 0.33 and h < 0.66:
			s = 0.6
			v = 0.6
	
	color = Color.from_hsv(h, s, v)
	#print([zone.index, index + zone.stronghold.region_offsets[zone.index], zone.stronghold.region_counter + 1])
