extends CharacterBody2D

var gravity_enabled = false
var gravity_multiplier = 0.1

var target_rotation = null

var target_impulse = null

var energy_loss = 0.8
var friction = 0.9

func set_gravity_enabled(condition: bool):
	gravity_enabled = condition
	
func get_gravity_enabled() -> bool:
	return gravity_enabled
	
func set_target_rotation(radians):
	target_rotation = radians

func apply_impulse(impulse):
	target_impulse = impulse

func _ready():
	pass
		
func _physics_process(delta: float) -> void:
	velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	
	if not is_on_floor() and gravity_enabled:
		velocity += get_gravity() * gravity_multiplier * delta
	
	if target_rotation != null:
		rotation = lerp_angle(rotation, target_rotation, 10.0 * delta)
		
		if absf(wrapf(target_rotation - rotation, -PI, PI)) < 0.01:
			rotation = target_rotation
			target_rotation = null
	
	if target_impulse != null:
		velocity += target_impulse
		target_impulse = null
	
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		var normal = collision.get_normal()
		var normal_speed = velocity.dot(normal)
		var tangent = velocity - normal * normal_speed
		
		velocity = -normal * normal_speed * energy_loss + tangent * friction
