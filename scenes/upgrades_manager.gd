extends Node
class_name UpgradesManager

var pruner_level := 0
const PRUNER_DATA: Dictionary = {
	0: {
		"upgrade_cost": 0,
		"target_pull_distance": 4000
	},
	1: {
		"upgrade_cost": 50,
		"target_pull_distance": 1700
	},
	2: {
		"upgrade_cost": 100,
		"target_pull_distance": 500
	},
	3: {
		"upgrade_cost": 200,
		"target_pull_distance": 150
	}
}

func upgrade_pruner():
	if pruner_level + 1 < PRUNER_DATA.size() and \
		%ResourcesManager.money >= PRUNER_DATA[pruner_level + 1].upgrade_cost:
		var cost = PRUNER_DATA[pruner_level + 1].upgrade_cost
		pruner_level += 1
		%ResourcesManager.add_money(-cost)
		$"../BottomPanel/HBoxContainer/PrunerButton".text = "Pruner " + str(pruner_level + 1)
		
		for sibling in $"../GrassSpawner/Grasses".get_children():
			sibling.target_pull_distance = get_current_pruner().target_pull_distance
		

func get_current_pruner():
	return PRUNER_DATA[pruner_level]

func _on_pruner_button_pressed():
	upgrade_pruner()
