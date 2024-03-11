extends Label

@export var resource: ResourcesManager.GameResourceType

var real_value = 0 ## Real value of the resource
var showing_value = 0 ## Value showed to the player right now

func _ready() -> void:
	match resource:
		ResourcesManager.GameResourceType.MONEY:
			ResourcesManager.money_changed.connect(update_text)
		ResourcesManager.GameResourceType.BARLEY:
			ResourcesManager.barley_changed.connect(update_text)
		ResourcesManager.GameResourceType.BEER:
			ResourcesManager.beer_changed.connect(update_text)
	ResourcesManager.not_enough.connect(_on_not_enough_resource)
	update_text()

func update_text() -> void:
	real_value = get_resource_data()

func _physics_process(_delta):
	if real_value != showing_value:
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

func _on_not_enough_resource(not_enugh_resource: ResourcesManager.GameResourceType):
	if resource == not_enugh_resource:
		$AnimationPlayer.play("red")
