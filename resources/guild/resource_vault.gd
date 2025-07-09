class_name ResourceVault
extends Resource


var guild: ResourceGuild
var gold: int = 1000
var cliches: Dictionary


func _init(guild_: ResourceGuild) -> void:
	guild = guild_
	
func change_cliche(type_: String, cliche_: ResourceCliche, value_: int) -> void:
	if !cliches.has(type_):
		cliches[type_] = {}
	
	if !cliches[type_].has(cliche_) and value_ > 0:
		cliches[type_][cliche_] = 0
	
	cliches[type_][cliche_] += value_
	
	if cliches[type_][cliche_] == 0:
		cliches[type_].erase(cliche_)
