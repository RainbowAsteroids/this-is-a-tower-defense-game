extends Node2D
class_name World

signal health_changed(value)
signal wave_count_changed(value)
signal next_round
signal round_ended

@export var waves: Array[Wave]
@export var health: float = 100:
	set(value):
		health = value
		health_changed.emit(value)
@export var money: int = 500

@export var enemy_parent: Path2D
@export var start_button: Button

@export var lose_screen: CanvasLayer
@export var win_screen: CanvasLayer

var wave_count: int:
	set(value):
		wave_count = value
		wave_count_changed.emit(value)

func _ready():
	MoneyManager.money = money
	self.health = health
	
	for wave_index in waves.size():
		wave_count = wave_index + 1
		var wave = waves[wave_index]
		round_ended.emit()
		await next_round
		wave.execute(enemy_parent)
		await wave.finished
	
	while true:
		if enemy_parent.get_child_count() == 1: # Remeber there's a Line2D in enemy_parent
			win_screen.visible = true
			get_tree().paused = true
		await get_tree().process_frame

func _on_exit_area_entered(area: Area2D):
	if area is EnemyArea2D:
		self.health -= area.get_parent().damage
		area.get_parent().queue_free()
		
		if health <= 0:
			lose_screen.visible = true
			get_tree().paused = true

func _on_start_button_pressed():
	start_button.disabled = true
	next_round.emit()

func _on_round_ended():
	start_button.disabled = false

func _on_speed_button_toggled(button_pressed):
	var speed = 2 if button_pressed else 1
	Engine.time_scale = speed
