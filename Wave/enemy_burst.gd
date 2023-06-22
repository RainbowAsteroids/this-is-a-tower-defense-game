extends WaveSection
class_name EnemyBurst

@export var enemy: PackedScene
@export var number_of_enemies: int
@export var enemies_per_second: float

func execute(enemy_parent: Node):
	for i in range(number_of_enemies):
		enemy_parent.add_child(enemy.instantiate())
		await enemy_parent.get_tree().create_timer(1 / enemies_per_second).timeout
	finished.emit()
