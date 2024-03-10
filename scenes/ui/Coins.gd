extends Label

func _ready() -> void:
	ResourcesManager.money_changed.connect(update_text)

func update_text() -> void:
	text = str(ResourcesManager.money)
