@tool
extends VBoxContainer

@export var turrets: Array[PurchasableTurret]
@export var turret_parent: Node
@export var shop_button: PackedScene

func _ready():
	for turret in turrets:
		var button = shop_button.instantiate()
		
		button.turret_parent = turret_parent
		button.turret_scene = turret.turret
		button.cost = turret.price
		button.text = "{0} (${1})".format([turret.name, turret.price])
		
		add_child(button)
