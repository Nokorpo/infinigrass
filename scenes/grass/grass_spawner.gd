extends Node2D

signal grass_pulled

const GRASS = preload("res://scenes/grass/grass.tscn")
var max_grass = 12

func _on_timer_timeout():
	var grass_count := 0
	for child in $Grasses.get_children():
		if child is Grass:
			grass_count += 1
	if grass_count < max_grass:
		spawn_grass()

func _ready():
	spawn_grass()
	
func spawn_grass():
	var this_grass = GRASS.instantiate()
	this_grass.pulled.connect(on_grass_pulled)
	this_grass.target_pull_distance = %UpgradesManager.get_current_pruner().target_pull_distance
	this_grass.position = Vector2(randf_range(50, 750), randf_range(50,630))
	$Grasses.add_child(this_grass)

func on_grass_pulled():
	ResourcesManager.add_resource(5, ResourcesManager.GameResourceType.MONEY)
	grass_pulled.emit()
