extends Node
class_name resources_manager2

var money: int = 0

func add_money(add: int):
	money += add
	$"../Coins".text = str(money)
