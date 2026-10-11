extends Node2D

@onready var left_bodies: Node2D = $LeftBodies
@onready var right_bodies: Node2D = $RightBodies

var body_index = 1

func spawn_next_level():
	var current_left_body = left_bodies.get_children().back()
	var current_right_body = right_bodies.get_children().back()
	
	body_index += 1
	
	var new_left_body = current_left_body.duplicate()
	var new_right_body = current_right_body.duplicate()
	
	#new_left_body.name = "LeftBody" + str(body_index)
	#new_right_body.name = "RightBody" + str(body_index)
	
	new_left_body.position.y -= 540
	new_right_body.position.y -= 540
	
	left_bodies.add_child(new_left_body)
	right_bodies.add_child(new_right_body)

func _ready() -> void:
	spawn_next_level()
	
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	pass
