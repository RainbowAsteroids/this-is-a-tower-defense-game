extends "res://Turret/turret.gd"

func _on_fire_timer_timeout():
	for fire_position in fire_positions.get_children():
		var bullet = bullet_scene.instantiate()
		bullet.global_rotation = fire_position.global_rotation
		bullet.global_position = fire_position.global_position
		bullet.damage = damage
		bullet.penetration = bullet_penetration
		bullet_parent.add_child(bullet)
