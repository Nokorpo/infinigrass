extends Node
class_name resourcesManager

var money: int = 0

func add_money(add: int):
	money += add
	$"../Coins".text = str(money)
