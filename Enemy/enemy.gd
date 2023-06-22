@tool
extends PathFollow2D
class_name Enemy

signal dead

@export var radius: float = 25.0
@export var color: Color = Color.WHITE
@export var speed: float = 10.0
@export var health: float = 1.0

@export var damage: float = 1.0
@export var bounty: int = 1

func _draw():
	draw_circle(Vector2(), radius + 1, Color.BLACK)
	draw_circle(Vector2(), radius, color)

func _ready():
	$Area2D/CollisionShape2D.shape.radius = radius

func _physics_process(delta):
	if not Engine.is_editor_hint():
		progress += speed * delta

func _on_bullet_area_entered(bullet: Bullet):
	if bullet:
		health -= bullet.damage
		bullet.penetration -= 1
		if bullet.penetration <= 0:
			bullet.queue_free()
		
		if health <= 0:
			MoneyManager.money += bounty
			dead.emit()
			queue_free()
