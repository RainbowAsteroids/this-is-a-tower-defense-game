extends Area2D

@export var radius: float = 500

@export var damage := 10.0
@export var bullet_scene: PackedScene
@export var bullet_parent: Node
@export var bullets_per_second: float
@export var bullet_penetration: int = 1

var enabled = false:
	set(value):
		enabled = value
		queue_redraw()
var cost: float

@onready var fire_timer = $FireTimer
@onready var barrel = $Barrel
@onready var fire_positions: Node = $Barrel/FirePositions
@onready var turret_collider = $TurretCollider

var fire_position_index = 0
func get_fire_position():
	var fps = fire_positions.get_children()
	var index = fire_position_index
	fire_position_index = (fire_position_index + 1) % len(fps)
	
	return fps[index]

func _draw():
	if not enabled:
		draw_circle(Vector2(), radius, Color(1, 1, 1, 0.1))

func _ready():
	$CollisionShape2D.shape.radius = radius
	fire_timer.wait_time = 1 / bullets_per_second

func _physics_process(_delta):
	if enabled:
		var areas = get_overlapping_areas()
		var enemies = areas.filter(func(area): return area is EnemyArea2D)
		if len(enemies) != 0:
			enemies.sort_custom(func(a, b): return a.get_parent().progress > b.get_parent().progress)
			
			look_at(enemies[0].global_position)
			
			if fire_timer.is_stopped():
				_on_fire_timer_timeout()
				fire_timer.start()
		else:
			fire_timer.stop()
	else:
		global_position = get_global_mouse_position()
	
func _input(_event):
	if not enabled:
		if Input.is_action_just_pressed("left_click"):
			var other_areas = turret_collider.get_overlapping_areas()
			var other_turret_colliders = other_areas.filter(func(area): return area is TurretCollidier)
			if len(other_turret_colliders) == 0:
				if MoneyManager.money >= cost:
					self.enabled = true
					MoneyManager.money -= cost
		elif Input.is_action_just_pressed("right_click"):
			queue_free()

func _on_fire_timer_timeout():
	var bullet = bullet_scene.instantiate()
	bullet.global_rotation = barrel.global_rotation
	bullet.global_position = get_fire_position().global_position
	bullet.damage = damage
	bullet.penetration = bullet_penetration
	bullet_parent.add_child(bullet)
