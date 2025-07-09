class_name ResourceGuild
extends Resource


var warriors: Array[ResourceWarrior]
var merchant: ResourceMerchant = ResourceMerchant.new(self)
var mentor: ResourceMentor = ResourceMentor.new(self)
var vault: ResourceVault = ResourceVault.new(self)
var auction: ResourceAuction
var warriors_limit: int = 6


func _init(auction_: ResourceAuction) -> void:
	auction = auction_
	
	init_warriors()
	mentor.prepare_development_plan()
	merchant.get_start_cliches()
	merchant.init_start_mediators()
	
func init_warriors() -> void:
	for _i in warriors_limit:
		add_warrior()
	
func add_warrior() -> void:
	var warrior = ResourceWarrior.new(self)
	warriors.append(warrior)
