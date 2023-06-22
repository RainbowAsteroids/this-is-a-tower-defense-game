extends Resource
class_name WaveSection

signal finished

func execute(enemy_parent: Node):
	await enemy_parent.get_tree().process_frame
	push_error("Base class not overloaded!")
