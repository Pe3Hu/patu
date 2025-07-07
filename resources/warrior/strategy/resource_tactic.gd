class_name ResourceTactic
extends Resource


var strategy: ResourceStrategy
var origin_template: ResourceTemplate:
	get : return origin_template
	set(value_): 
		origin_template = value_ 
		
		init_couples()
var templates: Array[ResourceTemplate]
var couples: Array
var synergy: Dictionary
var index: int
var template_indexs: Array[int]


func init_couples() -> void:
	index = strategy.tactics.size()
	var halfs = strategy.templates.filter(func (a): return a.weapon != origin_template.weapon and a.totem != origin_template.totem and a.pace != origin_template.pace and a.kit != origin_template.kit)
	
	while !halfs.is_empty():
		var first_half = halfs.pop_front()
		var second_halfs = halfs.filter(func (a): return a.weapon != first_half.weapon and a.totem != first_half.totem and a.pace != first_half.pace and a.kit != first_half.kit)
		var second_half = second_halfs.front()
		halfs.erase(second_half)
		couples.append([first_half, second_half])
	
	couples.sort_custom(func(a, b): return a.front().synergy.avg + a.back().synergy.avg > b.front().synergy.avg + b.back().synergy.avg)
	
	templates = [origin_template]
	templates.append_array(couples.front())
	templates.sort_custom(func(a, b): return a.index > b.index)
	
	var repeats = strategy.tactics.filter(func(a): return a.templates == templates)
	
	if repeats.is_empty():
		var tags = ["avg", "offense", "defense"]
		synergy = {}
		
		for tag in tags:
			synergy[tag] = 0
			
			for template in templates:
				synergy[tag] += template.synergy[tag] / templates.size()
		
		for template in templates:
			template_indexs.append(strategy.templates.find(template))
			
		
		strategy.tactics.append(self)
