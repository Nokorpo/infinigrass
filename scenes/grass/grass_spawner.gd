extends Node2D

const GRASS = preload("res://scenes/grass/grass.tscn")

func _on_timer_timeout():
	const MAX_GRASS = 12
	if $Grasses.get_child_count() < MAX_GRASS:
		spawn_grass()

func _ready():
	spawn_grass()
	
func spawn_grass():
	var this_grass = GRASS.instantiate()
	this_grass.pulled.connect(grass_pulled)
	this_grass.target_pull_distance = %UpgradesManager.get_current_pruner().target_pull_distance
	this_grass.position = Vector2(randf_range(50, 750), randf_range(50,630))
	$Grasses.add_child(this_grass)

func grass_pulled():
	ResourcesManager.add_resource(10, ResourcesManager.GameResourceType.MONEY)
