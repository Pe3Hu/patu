class_name ResourcePool
extends Resource


@export var dices: Array[ResourceDiceSuccess]


var successes: Array[int]


func roll_dices() -> void:
	successes.clear()
	
	for dice in dices:
		var result = dice.roll()
		successes.append(result)
	
	successes.sort()
