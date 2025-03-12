extends Node

var engine_scene: PackedScene = preload("res://scenes/engine.tscn")
var good_thing_scene: PackedScene = preload("res://scenes/good_thing.tscn")

@onready var spawn_things_timer: Timer = $SpawnThingsTimer
@onready var spawn_things_with_counter: Timer = $SpawnThingsWithCounter
@onready var spawn_good_things: Timer = $SpawnGoodThings

var engine_icons: Array = [
	preload("res://assets/gamemaker.png"),
	preload("res://assets/unity.png"),
	preload("res://assets/unreal.png")
]

@export var godot: Area2D
@export var path_follow_2d: PathFollow2D


func _ready() -> void:
	spawn_things_timer.timeout.connect(_on_spawn_things_timer_timeout)
	spawn_things_with_counter.timeout.connect(_on_spawn_things_with_counter_timeout)
	spawn_good_things.timeout.connect(_on_spawn_good_things_timeout)


func _on_spawn_good_things_timeout() -> void:
	path_follow_2d.progress_ratio = randf()

	var good_thing = good_thing_scene.instantiate()
	good_thing.speed = 100.0
	add_child(good_thing)

	#engine.set_texture(engine_icons.pick_random())
	# TODO: should the good thing fly on a different direction?
	good_thing.set_target_position(godot.global_position)
	good_thing.position = path_follow_2d.global_position


func _on_spawn_things_with_counter_timeout() -> void:
	path_follow_2d.progress_ratio = randf()

	var engine = engine_scene.instantiate()
	engine.speed = 100.0
	engine.counter = randi_range(1, 5)
	engine.type = engine.TYPE.COUNTER
	add_child(engine)
	engine.set_texture(engine_icons.pick_random())
	engine.set_target_position(godot.global_position)
	engine.position = path_follow_2d.global_position


func _on_spawn_things_timer_timeout() -> void:
	path_follow_2d.progress_ratio = randf()

	var engine = engine_scene.instantiate()
	add_child(engine)
	engine.set_texture(engine_icons.pick_random())
	engine.set_target_position(godot.global_position)
	engine.position = path_follow_2d.global_position
