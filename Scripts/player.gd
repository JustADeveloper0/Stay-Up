extends CharacterBody2D

var gravity_enabled = false
var gravity_multiplier = 0.1

var target_rotation = null

func set_gravity_enabled(condition: bool):
	gravity_enabled = condition
	
func get_gravity_enabled() -> bool:
	return gravity_enabled
	
func set_target_rotation(radians):
	target_rotation = radians

func apply_force(force):
	pass

func _ready():
	pass
		
func _physics_process(delta: float) -> void:
	if not is_on_floor() and gravity_enabled:
		velocity += get_gravity() * gravity_multiplier * delta
	
	if target_rotation != null:
		rotation = lerp_angle(rotation, target_rotation, 10.0 * delta)
		
		if absf(wrapf(target_rotation - rotation, -PI, PI)) < 0.01:
			rotation = target_rotation
			target_rotation = null
	
	move_and_slide()
