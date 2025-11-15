extends Node2D

func _process(_delta: float) -> void:
	if $RigidBody2D.position.y < 0:
		$Label.is_active = false
		$Label.position.y = -1890
		$Camera2D.position.y = -945
	elif $RigidBody2D.position.y >= 0 and 0 <= $RigidBody2D.position.x and $RigidBody2D.position.x <= 3024:
		$Camera2D.position.y = 945
		$Label.position.y = 0
