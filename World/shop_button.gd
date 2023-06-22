extends Button

var turret_parent: Node
var turret_scene: PackedScene
var cost: float

func _ready():
	MoneyManager.money_changed.connect(func():
		disabled = MoneyManager.money < cost	
	)

func _on_pressed():
	var turret = turret_scene.instantiate()
	turret.bullet_parent = turret_parent
	turret.cost = cost
	turret_parent.add_child(turret)
