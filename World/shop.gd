@tool
extends VBoxContainer

@export var turrets: Array[PurchasableTurret]
@export var world: World
@export var shop_button: PackedScene

func _ready():
	for turret in turrets:
		var button = shop_button.instantiate()
		
		button.turret_parent = world
		button.turret_scene = turret.turret
		button.cost = turret.price
		button.text = "{0} (${1})".format([turret.name, turret.price])
		
		add_child(button)
