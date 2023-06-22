extends Area2D
class_name Bullet

@export var speed: float = 100.0
@export var damage: float = 10.0
@export var penetration: int = 1

func _physics_process(delta):
	position += Vector2(speed * delta, 0).rotated(rotation)

func _on_despawn_timer_timeout():
	queue_free()
