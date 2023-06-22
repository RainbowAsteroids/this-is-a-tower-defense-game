extends WaveSection
class_name Pause

@export var duration: float

func execute(enemy_parent: Node):
	await enemy_parent.get_tree().create_timer(duration).timeout
	finished.emit()
