extends Label

@export var resource: ResourcesManager.GameResourceType
@export var UPDATE_EVERY_X_FRAMES: int = 5

var real_value = 0 ## Real value of the resource
var showing_value = 0 ## Value showed to the player right now
var frame_number = 0

func _ready() -> void:
	match resource:
		ResourcesManager.GameResourceType.MONEY:
			ResourcesManager.money_changed.connect(update_text)
		ResourcesManager.GameResourceType.BARLEY:
			ResourcesManager.barley_changed.connect(update_text)
		ResourcesManager.GameResourceType.BEER:
			ResourcesManager.beer_changed.connect(update_text)
	update_text()

func update_text() -> void:
	real_value = get_resource_data()

func _physics_process(_delta):
	if real_value != showing_value:
		frame_number += 1
		if frame_number % UPDATE_EVERY_X_FRAMES != 0:
			return
		if real_value > showing_value:
			showing_value += 1
		else:
			showing_value -= 1
		text = str(showing_value)

func get_resource_data():
	match resource:
		ResourcesManager.GameResourceType.MONEY:
			return ResourcesManager.money
		ResourcesManager.GameResourceType.BARLEY:
			return ResourcesManager.barley
		ResourcesManager.GameResourceType.BEER:
			return ResourcesManager.beer
	return null
