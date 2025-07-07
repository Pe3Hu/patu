class_name ResourceStrategy
extends Resource


var warrior: ResourceWarrior
var kits: Array[ResourceKit]
var templates: Array[ResourceTemplate]
var tactics: Array[ResourceTactic]


func duel_preparation() -> void:
	init_kits()
	init_templates()
	init_tactics()
	warrior.avatar.tactic = tactics.front()
	
func init_kits() -> void:
	kits.clear()
	var essences = []
	
	for aspect_type in Global.arr.aspect:
		var aspect = warrior.get(aspect_type)
		essences.append_array(aspect.essences)
	
	essences.shuffle()
	var m = int(float(essences.size()) / warrior.n)
	
	for _i in warrior.n:
		var kit_essences: Array[ResourceEssence]
		
		for _j in m:
			var essence = essences.pop_front()
			kit_essences.append(essence)
		
		var kit = ResourceKit.new()
		kit.essences = kit_essences
		kits.append(kit)
	
func init_templates() -> void:
	templates.clear()
	
	for weapon in warrior.weapons:
		for totem in warrior.totems:
			for pace in warrior.paces:
				for kit in kits:
					var template = ResourceTemplate.new()
					template.strategy = self
					template.weapon = weapon
					template.totem = totem
					template.pace = pace
					template.kit = kit
					template.index = templates.size()
					templates.append(template)
	
	templates.sort_custom(func(a, b): return a.synergy.avg > b.synergy.avg)
	
func init_tactics() -> void:
	tactics.clear()
	##selection of the best options
	var top_n = 9
	#var top_n = int(float(templates.size()) / warrior.n)
	
	for _i in top_n:
		var template_index = _i
		var tactic = ResourceTactic.new()
		tactic.strategy = self
		tactic.origin_template = templates[template_index]
	
	tactics.sort_custom(func(a, b): return a.synergy.avg > b.synergy.avg)
	
	#for tactic in tactics:
	#	print([tactic.template_indexs, tactic.index, tactic.synergy.avg])
		
		#print([template.synergy.avg, template.weapon.type, template.totem.type])#, template.pace.expectations
	
	#var tactic = tactics.front()
	#
	#for template in tactic.templates:
		#print(template.get_indexs())
	
