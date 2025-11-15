extends RigidBody2D

@onready var _animated_sprite = $AnimatedSprite2D

var speed = 1250
var bounce = 0
var jump_strength: int = 0
var walking_right: bool = false
var walking_left: bool = false
var looking_right: bool = false
var looking_left: bool = false
var on_floor: bool = false

func _process(delta: float) -> void:
	process_inputs(delta)
	if position.y < 0:
		gravity_scale = 0.75
		speed = 750
	else:
		gravity_scale = 1.5
		speed = 1250

func process_inputs(_delta: float) -> void:
	if Input.is_action_pressed('ui_cancel'):
		get_tree().quit()
	
	if on_floor == true:
		if Input.is_action_pressed('ui_up'):
			jump_strength += 20
			_animated_sprite.play('charge_jump')
		else:
			if Input.is_action_pressed('ui_right'):
				apply_force(Vector2.RIGHT * speed)
				_animated_sprite.play("walk_right")
				walking_right = true
				looking_right = true
				looking_left = false
			else:
				walking_right = false
				
			if Input.is_action_pressed('ui_left'):
				apply_force(Vector2.LEFT * speed)
				_animated_sprite.play("walk_left")
				walking_left = true
				looking_left = true
				looking_right = false
			else:
				walking_left = false
				
			if (not walking_right and not walking_left) or (walking_left and walking_right):
				if looking_right:
					_animated_sprite.play('stand_right')
				elif looking_left:
					_animated_sprite.play('stand_left')
				else:
					_animated_sprite.play('stand_straight')
				
		if Input.is_action_just_released('ui_up') or jump_strength >= 1650:
			apply_impulse(Vector2.UP * jump_strength)
			if Input.is_action_pressed('ui_right'):
				apply_impulse(Vector2.RIGHT * jump_strength * 1/2)
			if Input.is_action_pressed('ui_left'):
				apply_impulse(Vector2.LEFT * jump_strength * 1/2)
			jump_strength = 0
			looking_right = false
			looking_left = false
	
	else:
		if linear_velocity[1] > 0:
			if linear_velocity[0] > 0:
				_animated_sprite.play("jump_right_down")
			elif linear_velocity[0] < 0:
				_animated_sprite.play("jump_left_down")
			else:
				_animated_sprite.play("jump_straight_down")
		else:
			if linear_velocity[0] > 0:
				_animated_sprite.play("jump_right_up")
			elif linear_velocity[0] < 0:
				_animated_sprite.play("jump_left_up")
			else:
				_animated_sprite.play("jump_straight_up")
		
func _on_body_entered(_body: Node) -> void:
	on_floor = true

func _on_body_exited(_body: Node) -> void:
	on_floor = false
