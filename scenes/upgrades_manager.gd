extends Node
class_name UpgradesManager

enum UpgradeTypes { PRUNER, FERTILIZER }

const PRUNER_DATA: Dictionary = {
	0: {
		"upgrade_cost": 0,
		"target_pull_distance": 4000,
		"sprite": "res://assets/sprites/ui/pruner-1.png"
	},
	1: {
		"upgrade_cost": 30,
		"target_pull_distance": 1700,
		"sprite": "res://assets/sprites/ui/pruner-2.png"
	},
	2: {
		"upgrade_cost": 60,
		"target_pull_distance": 500,
		"sprite": "res://assets/sprites/ui/pruner-3.png"
	},
	3: {
		"upgrade_cost": 150,
		"target_pull_distance": 150,
		"sprite": "res://assets/sprites/ui/pruner-4.png"
	}
}
const FERTILIZER_DATA: Dictionary = {
	0: {
		"upgrade_cost": 0,
		"max_grass": 8,
		"grass_cooldown": 2.5,
		"sprite": "res://assets/sprites/ui/poop-1.png"
	},
	1: {
		"upgrade_cost": 10,
		"max_grass": 14,
		"grass_cooldown": 1.2,
		"sprite": "res://assets/sprites/ui/poop-2.png"
	},
	2: {
		"upgrade_cost": 20,
		"max_grass": 20,
		"grass_cooldown": 0.5,
		"sprite": "res://assets/sprites/ui/poop-3.png"
	},
	3: {
		"upgrade_cost": 40,
		"max_grass": 30,
		"grass_cooldown": 0.1,
		"sprite": "res://assets/sprites/ui/poop-4.png"
	}
}
var pruner_level := 0
var fertilizer_level := 0

func _ready():
	apply_fertilizer_upgrade()

func upgrade_pruner():
	if pruner_level + 1 < PRUNER_DATA.size() and \
		ResourcesManager.money >= PRUNER_DATA[pruner_level + 1].upgrade_cost:
		var cost = PRUNER_DATA[pruner_level + 1].upgrade_cost
		pruner_level += 1
		if pruner_level + 1 == PRUNER_DATA.size():
			%PrunerButton.is_upgrade_max = true
		ResourcesManager.subtract_resource(cost, ResourcesManager.GameResourceType.MONEY)
		for sibling in $"../GrassSpawner/Grasses".get_children():
			if sibling is Grass:
				sibling.target_pull_distance = get_current_pruner().target_pull_distance
		
		%PrunerButton/TextureRect.texture = load(get_current_pruner().sprite)
		%PurchaseSound.play(0)

func get_current_pruner():
	return PRUNER_DATA[pruner_level]

func get_next_pruner():
	if pruner_level + 1 < PRUNER_DATA.size():
		return PRUNER_DATA[pruner_level + 1]
	else:
		return PRUNER_DATA[PRUNER_DATA.size() - 1]

func upgrade_fertilizer():
	if fertilizer_level + 1 < FERTILIZER_DATA.size() and \
		ResourcesManager.money >= FERTILIZER_DATA[fertilizer_level + 1].upgrade_cost:
		var cost = FERTILIZER_DATA[fertilizer_level + 1].upgrade_cost
		fertilizer_level += 1
		if fertilizer_level + 1 == FERTILIZER_DATA.size():
			%FertilizerButton.is_upgrade_max = true
		ResourcesManager.subtract_resource(cost, ResourcesManager.GameResourceType.BEER)
		
		%FertilizerButton/TextureRect.texture = load(get_current_fertilizer().sprite)
		apply_fertilizer_upgrade()
		%PurchaseSound.play(0)

func get_current_fertilizer():
	return FERTILIZER_DATA[fertilizer_level]

func get_next_fertilizer():
	if fertilizer_level + 1 < FERTILIZER_DATA.size():
		return FERTILIZER_DATA[fertilizer_level + 1]
	else:
		return FERTILIZER_DATA[FERTILIZER_DATA.size() - 1]

func _on_pruner_button_pressed():
	upgrade_pruner()

func apply_fertilizer_upgrade():
	$"../GrassSpawner/Timer".wait_time = get_current_fertilizer().grass_cooldown
	$"../GrassSpawner".max_grass = get_current_fertilizer().max_grass
