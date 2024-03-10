extends Node

const SPRITES = {
	ResourcesManager.GameResourceType.MONEY: "res://assets/sprites/ui/coin.png",
	ResourcesManager.GameResourceType.BARLEY: "res://assets/sprites/ui/barley-icon.png",
	ResourcesManager.GameResourceType.BEER: "res://assets/sprites/ui/beer.png"
}

func set_price(quantity):
	$Price.text = str(quantity)

func set_texture(resource_type: ResourcesManager.GameResourceType):
	$PriceIcon.texture = load(SPRITES[resource_type])
