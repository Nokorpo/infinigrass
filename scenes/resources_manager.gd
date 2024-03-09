extends Node

enum GameResourceType { MONEY, BARLEY, BEER }

signal money_changed
signal barley_changed
signal beer_changed

var money: int = 0
var barley: int = 0
var beer: int = 0

func add_resource(amount: int, resource_type: GameResourceType) -> void:
	match resource_type:
		GameResourceType.MONEY:
			money += amount
			money_changed.emit()
		GameResourceType.BARLEY:
			barley += amount
			barley_changed.emit()
		GameResourceType.BEER:
			beer += amount
			beer_changed.emit()
	print("Add %d units of %s" % [amount, GameResourceType.keys()[resource_type]])

func subtract_resource(amount: int, resource_type: GameResourceType) -> void:
	match resource_type:
		GameResourceType.MONEY:
			money -= amount
			money_changed.emit()
		GameResourceType.BARLEY:
			barley -= amount
			barley_changed.emit()
		GameResourceType.BEER:
			beer -= amount
			beer_changed.emit()
	print("Subtract %d units of %s" % [amount, GameResourceType.keys()[resource_type]])
