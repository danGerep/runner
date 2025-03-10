extends Node2D

@onready var path_follow_2d: PathFollow2D = $SpawnLine/PathFollow2D
@onready var spawn_line_timer: Timer = $SpawnLineTimer
@onready var godot: Sprite2D = $Godot

var engine_icons: Array = [
	preload("res://assets/gamemaker.png"),
	preload("res://assets/unity.png"),
	preload("res://assets/unreal.png")
]

var engine_scene: PackedScene = preload("res://scenes/engine.tscn")


func _ready() -> void:
	spawn_line_timer.timeout.connect(_on_spawn_line_timer_timeout)


func _on_spawn_line_timer_timeout() -> void:
	path_follow_2d.progress_ratio = randf()

	var engine = engine_scene.instantiate()
	add_child(engine)
	engine.set_texture(engine_icons.pick_random())
	engine.set_target_position(godot.position)
	engine.position = path_follow_2d.position
