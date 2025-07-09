class_name DealResource extends Resource


var vendor: MediatorResource
var customer: MediatorResource
var price: int


func _init(vendor_: MediatorResource, customer_: MediatorResource) -> void:
	vendor = vendor_
	customer = customer_
	price = vendor_.current_price
	
	vendor.is_deal = true
	customer.is_deal = true
	
	vendor.merchant.guild.vault.change_cliche(vendor.room.type, vendor.room.cliche, -1)
	customer.merchant.guild.vault.change_cliche(vendor.room.type, customer.room.cliche, 1)
	
	customer.merchant.guild.vault.gold -= price
	vendor.merchant.guild.vault.gold += price
	
	print(["deal", "vendor " + str(vendor), "customer " + str(customer)])
