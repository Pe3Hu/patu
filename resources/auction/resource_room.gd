class_name RoomResource extends Resource


var auction: ResourceAuction
var cliche: ResourceCliche
var type: String
var vendors: Array[MediatorResource]
var customers: Array[MediatorResource]
var showcases: Array[MediatorResource]
var queue: Array[MediatorResource]
var deals: Array[DealResource]

var is_closed: bool = true:
	set(value_):
		is_closed = value_
		
		if value_:
			auction.active_rooms.erase(self)
		else:
			auction.active_rooms.append(self)
var avg_price: float = 50.0


func _init(auction_: ResourceAuction, type_: String, cliche_: ResourceCliche) -> void:
	auction = auction_
	type = type_
	cliche = cliche_
	
func start_trade_round() -> void:
	reset_mediators()
	
	is_closed = false
	queue.clear()
	showcases.clear()
	
	queue.append_array(customers)
	showcases.append_array(vendors)
	
	queue.shuffle()
	showcases.shuffle()
	
	while !queue.is_empty() and !showcases.is_empty():
		match_customer_and_vendor()
	
func sort_mediators() -> void:
	for role in Global.arr.mediator:
		var mediators = get(role + "s")
		
		match role:
			"vendor":
				mediators.sort_custom(func(a, b): return a.current_price < b.current_price)
			"customer":
				mediators.sort_custom(func(a, b): return a.current_price > b.current_price)
	
func reset_mediators() -> void:
	sort_mediators()
	
	for role in Global.arr.mediator:
		var mediators = get(role + "s")
		
		for mediator in mediators:
			mediator.reset()
	
func match_customer_and_vendor() -> void:
	var customer = queue.pop_front()
	var _vendors = showcases.filter(func(a): return !customer.rejections.has(a))
	
	if !_vendors.is_empty():
		var vendor = _vendors.front()
		customer.evaluate_offer(vendor)
	
		if !vendor.is_deal:
			showcases.append(vendor)
	
		if !customer.is_deal:
			queue.append(customer)
	
func add_deal(deal_: DealResource) -> void:
	deals.append(deal_)
