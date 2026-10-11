extends Control

@onready var start: ColorRect = $Start
@onready var end: ColorRect = $End

var start_inital_pos = null
var end_inital_pos = null

var start_pos = null
var end_pos = null

var mouse_held = false

const min_length = 25
const max_length = 400

const min_power = 50
const max_power = 250

var player = null

func _ready():
	start_inital_pos = start.position
	end_inital_pos = end.position
	
	call_deferred("find_player")

func find_player():
	player = get_tree().get_first_node_in_group("Player")

func get_power(length):
	var slope = (float) (max_power - min_power) / (max_length - min_length)
	var offset = min_power - (slope * min_length)
	
	return (slope * length) + offset

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			var pos = get_local_mouse_position() - (start.size / 2)
			
			if event.pressed:
				if player.get_gravity_enabled() == false:
					player.set_gravity_enabled(true)
				
				start_pos = pos
				start.position = pos
				
				mouse_held = true
			else:
				mouse_held = false
				
				var distance = sqrt(pow(start_pos.x - end_pos.x, 2) + pow(start_pos.y - end_pos.y, 2))
				
				if distance >= min_length:
					distance = clamp(distance, min_length, max_length)
					var trajectory = (start_pos - end_pos).normalized()
					
					player.set_target_rotation(atan2(trajectory.y, trajectory.x))
					
					var power = get_power(distance)
					
					print(power)
					
					var impulse = trajectory * power
					
					player.apply_impulse(impulse)
				
				start_pos = null
				end_pos = null
				
				start.position = start_inital_pos
				end.position = end_inital_pos

func _physics_process(delta: float) -> void:
	var pos = get_global_mouse_position() - (start.size / 2)
	
	if mouse_held:
		end_pos = pos
		end.position = pos
