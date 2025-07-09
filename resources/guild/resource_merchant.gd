class_name ResourceMerchant
extends Resource


var guild: ResourceGuild
var needs: Dictionary
var customers: Array[MediatorResource]
var vendors: Array[MediatorResource]

var bonus_cliches = 12


func _init(guild_: ResourceGuild) -> void:
	guild = guild_
	
func get_start_cliches() -> void:
	get_start_essence_cliches()
	
func get_start_essence_cliches() -> void:
	var type = "essence"
	
	for _i in bonus_cliches:
		var cliche = guild.auction.get_random_cliche(type)
		guild.vault.change_cliche(type, cliche, 1)
	
func init_start_mediators() -> void:
	init_start_essence_mediators()
	
func init_start_essence_mediators() -> void:
	var type = "essence"
	var income = guild.mentor.priority_cliches.keys()
	var outcome = guild.vault.cliches[type].keys()
	outcome.filter(func (a): return !income.has(a))
	
	for cliche in income:
		var room = guild.auction.rooms[type][cliche]
		add_mediator(room, "customer")
		#var mediator = MediatorResource.new(self, room, "customer")
		#customers.append(mediator)
		
	for cliche in outcome:
		var room = guild.auction.rooms[type][cliche]
		add_mediator(room, "vendor")
		#var mediator = MediatorResource.new(self, room, "vendor")
		#vendors.append(mediator)

func add_mediator(room_: RoomResource, role_: String) -> void:
	var mediator = MediatorResource.new(self, room_, role_)
	
	var mediators = get(role_ + "s")
	mediators.append(mediator)
	
	var room_mediators = room_.get(role_ + "s")
	room_mediators.append(mediator)
