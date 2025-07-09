class_name ResourceAuction
extends Resource


var cliche_essences: Dictionary
var rooms: Dictionary
var active_rooms: Array[RoomResource]


func _init():
	init_cliches()
	#init_lots()
	pass
	
func init_cliches() -> void:
	var type = "essence"
	rooms[type] = {}
	
	for aspect in Global.arr.aspect:
		cliche_essences[aspect] = {}
		
		for offense in Global.dict.tag.offense:
			cliche_essences[aspect][offense] = {}
			
			for defense in Global.dict.tag.defense:
				cliche_essences[aspect][offense][defense] = {}
				
				for element in Global.arr.element:
					var cliche = ResourceClicheEssence.new(aspect, defense, offense, element)
					cliche_essences[aspect][offense][defense][element] = cliche
					rooms[type][cliche] = RoomResource.new(self, type, cliche)
	
func get_random_cliche(type_: String) -> ResourceCliche:
	var cliche = null
	
	match type_:
		"essence":
			var aspect = cliche_essences.keys().pick_random()
			var offense = cliche_essences[aspect].keys().pick_random()
			var defense = cliche_essences[aspect][offense].keys().pick_random()
			var element = cliche_essences[aspect][offense][defense].keys().pick_random()
			cliche = cliche_essences[aspect][offense][defense][element]
	
	return cliche
	
#func init_lots() -> void:
	#for lot in Global.arr.lot:
		#var lot_resource = ResourceLot.new()
		#lot_resource.set_title(lot).set_avg_price(50).set_auction(self)
		#lots[lot] = lot_resource
	
func init_trades() -> void:
	active_rooms.clear()
	
	for type in rooms:
		for cliche in rooms[type]:
			var room = rooms[type][cliche]
			
			if !room.vendors.is_empty() and !room.customers.is_empty():
				room.is_closed = false
	
	var room = active_rooms.front()
	room.start_trade_round()
	#for room in active_rooms:
	#	room.start_trade_round()
	
