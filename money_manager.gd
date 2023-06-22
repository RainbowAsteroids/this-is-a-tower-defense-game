extends Node

signal money_changed

var money: int = 0:
	set(value):
		money = value
		money_changed.emit()
