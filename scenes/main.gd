extends Node2D

@onready var path_follow_2d: PathFollow2D = $SpawnLine/PathFollow2D
@onready var spawn_line_timer: Timer = $SpawnLineTimer
@onready var godot: Area2D = $Godot
@onready var spawn_things: Marker2D = $SpawnThings
@onready var spawn_things_timer: Timer = $SpawnThingsTimer

var engine_icons: Array = [
	preload("res://assets/gamemaker.png"),
	preload("res://assets/unity.png"),
	preload("res://assets/unreal.png")
]

var engine_scene: PackedScene = preload("res://scenes/engine.tscn")


func _ready() -> void:
	spawn_line_timer.timeout.connect(_on_spawn_line_timer_timeout)
	spawn_things_timer.timeout.connect(_on_spawn_things_timeout)


func _on_spawn_things_timeout() -> void:
	var engine = engine_scene.instantiate()
	engine.speed = 100.0
	engine.counter = randi_range(0, 5)
	add_child(engine)
	engine.set_texture(engine_icons.pick_random())
	engine.set_target_position(godot.position)
	engine.position = spawn_things.position


func _on_spawn_line_timer_timeout() -> void:
	path_follow_2d.progress_ratio = randf()

	var engine = engine_scene.instantiate()
	add_child(engine)
	engine.set_texture(engine_icons.pick_random())
	engine.set_target_position(godot.position)
	engine.position = path_follow_2d.position
