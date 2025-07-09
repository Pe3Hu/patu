class_name Game
extends Node

var warriors: Array[ResourceWarrior]
var guilds: Array[ResourceGuild]
var auction: ResourceAuction


func _ready() -> void:
	auction = ResourceAuction.new()
	init_guilds()
	auction.init_trades()
	
	#init_duels()
	#check_d6()
	
func init_guilds() -> void:
	for _i in 10:
		var guild = ResourceGuild.new(auction)
		guilds.append(guild)
	
func init_duels() -> void:
	var duel = ResourceDuel.new()
	duel.add_warrior(warriors[0])
	duel.add_warrior(warriors[1])
	duel.start()
	
func check_d6() -> void:
	for type in Global.dict.combo.group:
		var pool = load("res://resources/dice/pool/pool_" + str(type) + ".tres")
	
		var sum = 0
		
		for d6 in pool.dices:
			#print(d6.values)
			for value in d6.values:
				sum += value
		
		print([type == sum, type, sum])
		
		#var tenets = {}
		#
		#for _i in d6.values.size():
			#var value = d6.values[_i]
			#var tenet = d6.tenets[_i].left(3)
			#
			#if !tenets.has(tenet):
				#tenets[tenet] = 0
			#
			#tenets[tenet] += value
		#
		#print([type, d6.type, tenets])
