extends Label

func _ready():
	MoneyManager.money_changed.connect(func(): 
		text = str(MoneyManager.money))
