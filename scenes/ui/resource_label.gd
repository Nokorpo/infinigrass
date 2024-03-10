extends Label

@export var resource: ResourcesManager.GameResourceType

func _ready() -> void:
	match resource:
		ResourcesManager.GameResourceType.MONEY:
			ResourcesManager.money_changed.connect(update_text)
		ResourcesManager.GameResourceType.BARLEY:
			ResourcesManager.barley_changed.connect(update_text)
		ResourcesManager.GameResourceType.BEER:
			ResourcesManager.beer_changed.connect(update_text)

func update_text() -> void:
	text = str(get_resource_data())

func get_resource_data():
	match resource:
		ResourcesManager.GameResourceType.MONEY:
			return ResourcesManager.money
		ResourcesManager.GameResourceType.BARLEY:
			return ResourcesManager.barley
		ResourcesManager.GameResourceType.BEER:
			return ResourcesManager.beer
	return null
