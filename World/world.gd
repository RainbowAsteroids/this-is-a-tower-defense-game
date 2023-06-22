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
@export var wave_count: int:
	set(value):
		wave_count = value
		wave_count_changed.emit(value)
@export var money: float = 500

@export var enemy_parent: Path2D
@export var start_button: Button

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
	
	pass # the game is over

func _on_exit_area_entered(area: EnemyArea2D):
	health -= area.get_parent().damage
	area.get_parent().queue_free()

func _on_start_button_pressed():
	start_button.disabled = true
	next_round.emit()

func _on_round_ended():
	start_button.disabled = false

func _on_speed_button_toggled(button_pressed):
	var speed = 2 if button_pressed else 1
	Engine.time_scale = speed
