class_name MediatorResource extends Resource


var room: RoomResource
var merchant: ResourceMerchant

@export_enum("calm", "greedy") var temperament: String
@export_enum("vendor", "customer") var role: String

var is_deal: bool = false

var index: int
var limit_price: int:
	get:
		return limit_price
	set(value_):
		limit_price = value_
		current_price = limit_price
var current_price: int

var step_standard: float = 0.05
var step_discount: float
var step_surcharge: float

var rejections: Array[MediatorResource]


func _init(merchant_: ResourceMerchant, room_: RoomResource, role_: String) -> void:
	merchant = merchant_
	room = room_
	role = role_
	
	#index = int(Global.num.index[role])
	#Global.num.index[role] += 1
	
	roll_temperament()
	roll_limit_price()
	roll_start_price()
	
func roll_temperament() -> void:
	temperament = "calm"
	
	match temperament:
		"calm":
			step_discount = -step_standard
			step_surcharge = step_standard
	
func roll_limit_price() -> void:
	var avg = int(room.avg_price)
	Global.rng.randomize()
	var shift = Global.rng.randi_range(0, floor(room.avg_price * 0.75))
	
	if role == "vendor":
		shift *= -1
	
	limit_price = avg + shift
	
func roll_start_price() -> void:
	Global.rng.randomize()
	var step = get("step_" + Global.dict.step.role[role])
	var steps = Global.rng.randf_range(2 * step, 5 * step)
	current_price = round(current_price * (1 + steps))#, 0.01)
	
func reset() -> void:
	is_deal = false
	rejections.clear()
	
func evaluate_offer(vendor_: MediatorResource) -> void:
	room.showcases.erase(vendor_)
	
	if merchant.guild.vault.gold >= limit_price:
		if vendor_.current_price <= current_price:
			make_deal(vendor_)
			return
	
	get_rejection(vendor_)
	
func make_deal(vendor_: MediatorResource) -> void:
	var deal = DealResource.new(vendor_, self)
	room.add_deal(deal)
	
	revaluation()
	vendor_.revaluation()
	
func get_rejection(vendor_: MediatorResource) -> void:
	rejections.append(vendor_)
	revaluation()
	vendor_.revaluation()
	
func revaluation() -> void:
	var decision
	
	if is_deal:
		match role:
			"vendor":
				decision = "surcharge"
			"customer":
				decision = "discount"
	else:
		match role:
			"vendor":
				decision = "discount"
			"customer":
				decision = "surcharge"
	
	var step = get("step_" + decision)
	var price = round(current_price * (1 + step))
	#print([index, role, decision, "revaluation"])
	match role:
		"vendor":
			current_price = max(price, limit_price)
		"customer":
			current_price = min(price, limit_price)
