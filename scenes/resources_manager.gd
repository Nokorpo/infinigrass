extends Node
class_name ResourcesManager

enum GameResourceType { MONEY, BARLEY, BEER }

var money: int = 0

func add_money(add: int):
	money += add
	$"../Coins".text = str(money)
