extends Resource
class_name Wave

signal finished

@export var wave_sections: Array[WaveSection]

func execute(enemy_parent: Node):
	for wave_section in wave_sections:
		wave_section.execute(enemy_parent)
		await wave_section.finished
	finished.emit()
