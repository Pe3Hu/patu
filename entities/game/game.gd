class_name Game
extends Node


func _ready() -> void:
	init_warriors()
	
func init_warriors() -> void:
	for _i in 1:
		var warrior = ResourceWarrior.new()
		pass
