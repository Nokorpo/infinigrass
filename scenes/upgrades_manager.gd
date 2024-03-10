extends Node
class_name UpgradesManager

var pruner_level := 0
const PRUNER_DATA: Dictionary = {
	0: {
		"upgrade_cost": 0,
		"target_pull_distance": 4000,
		"sprite": "res://assets/sprites/ui/pruner-1.png"
	},
	1: {
		"upgrade_cost": 50,
		"target_pull_distance": 1700,
		"sprite": "res://assets/sprites/ui/pruner-2.png"
	},
	2: {
		"upgrade_cost": 100,
		"target_pull_distance": 500,
		"sprite": "res://assets/sprites/ui/pruner-3.png"
	},
	3: {
		"upgrade_cost": 200,
		"target_pull_distance": 150,
		"sprite": "res://assets/sprites/ui/pruner-4.png"
	}
}

func upgrade_pruner():
	if pruner_level + 1 < PRUNER_DATA.size() and \
		ResourcesManager.money >= PRUNER_DATA[pruner_level + 1].upgrade_cost:
		var cost = PRUNER_DATA[pruner_level + 1].upgrade_cost
		pruner_level += 1
		if pruner_level + 1 == PRUNER_DATA.size():
			%PrunerButton.is_upgrade_max = true
		ResourcesManager.subtract_resource(cost, ResourcesManager.GameResourceType.MONEY)
		for sibling in $"../GrassSpawner/Grasses".get_children():
			sibling.target_pull_distance = get_current_pruner().target_pull_distance
		
		%PrunerButton/TextureRect.texture = load(get_current_pruner().sprite)

func get_current_pruner():
	return PRUNER_DATA[pruner_level]

func get_next_pruner():
	if pruner_level + 1 < PRUNER_DATA.size():
		return PRUNER_DATA[pruner_level + 1]
	else:
		return PRUNER_DATA[PRUNER_DATA.size() - 1]

func _on_pruner_button_pressed():
	upgrade_pruner()
