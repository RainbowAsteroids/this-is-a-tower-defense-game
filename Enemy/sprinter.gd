extends Enemy

@export var after_speed: float

func _on_timer_timeout():
	speed = after_speed
