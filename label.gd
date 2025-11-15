extends Label

var time_elasped: float = 0.0
var is_active: bool = true

func _process(delta: float) -> void:
	if is_active:
		time_elasped += delta
		text = ' ' + str(time_elasped).pad_decimals(3)
