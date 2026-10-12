extends Node2D

@onready var left_bodies: Node2D = $LeftBodies
@onready var right_bodies: Node2D = $RightBodies
@onready var platforms: Node2D = $Platforms

@onready var player: CharacterBody2D = $Player

@onready var lava: StaticBody2D = $Lava

const platform_scene = preload("res://Scenes/platform.tscn")

var index = 1

var platform_offset_start = 243.0
var platform_offset_end = 517.0

var platform_vertical_offset_1 = 135.0
var platform_vertical_offset_2 = 405.0

var lava_speed = 0.5

func spawn_platforms():
	var offset = -540.0 * (index - 1)
	
	var low_platform_1 = platform_scene.instantiate()
	var low_platform_2 = platform_scene.instantiate()
	var high_platform_1 = platform_scene.instantiate()
	var high_platform_2 = platform_scene.instantiate()
	
	low_platform_1.position = Vector2(randi_range(platform_offset_start, platform_offset_end), platform_vertical_offset_2 + offset)
	low_platform_2.position = Vector2(randi_range(platform_offset_start, platform_offset_end), platform_vertical_offset_2 + offset)
	high_platform_1.position = Vector2(randi_range(platform_offset_start, platform_offset_end), platform_vertical_offset_1 + offset)
	high_platform_2.position = Vector2(randi_range(platform_offset_start, platform_offset_end), platform_vertical_offset_1 + offset)
	
	print(low_platform_1.position.x)
	
	platforms.add_child(low_platform_1)
	platforms.add_child(low_platform_2)
	platforms.add_child(high_platform_1)
	platforms.add_child(high_platform_2)

func spawn_next_level():
	var current_left_body = left_bodies.get_children().back()
	var current_right_body = right_bodies.get_children().back()
	
	index += 1
	
	var new_left_body = current_left_body.duplicate()
	var new_right_body = current_right_body.duplicate()
	
	#new_left_body.name = "LeftBody" + str(body_index)
	#new_right_body.name = "RightBody" + str(body_index)
	
	new_left_body.position.y -= 540
	new_right_body.position.y -= 540
	
	left_bodies.add_child(new_left_body)
	right_bodies.add_child(new_right_body)
	
	spawn_platforms()

func _ready() -> void:
	pass #spawn_next_level()
	
func _process(delta: float) -> void:
	if player.get_gravity_enabled():
		lava.position.y -= lava_speed
	
	var height_creation = -540 * (index - 1) + 405.0
	
	if player.position.y <= height_creation:
		spawn_next_level()
