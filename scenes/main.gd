extends Node2D

@onready var path_follow_2d: PathFollow2D = $SpawnLine/PathFollow2D
@onready var spawn_things_timer: Timer = $SpawnThingsTimer
@onready var godot: Area2D = $Godot
@onready var spawn_things_with_counter: Timer = $SpawnThingsWithCounter
@onready var life_container: HBoxContainer = %LifeContainer

@onready var points_label: Label = %PointsLabel

var engine_icons: Array = [
	preload("res://assets/gamemaker.png"),
	preload("res://assets/unity.png"),
	preload("res://assets/unreal.png")
]

var engine_scene: PackedScene = preload("res://scenes/engine.tscn")
var total_points: int


func _ready() -> void:
	spawn_things_timer.timeout.connect(_on_spawn_things_timer_timeout)
	spawn_things_with_counter.timeout.connect(_on_spawn_things_with_counter_timeout)

	GameManager.engine_killed.connect(_on_engine_killed)
	GameManager.player_damaged.connect(_on_player_damaged)


func _on_player_damaged() -> void:
	var total_life: int = life_container.get_child_count()
	if total_life == 0:
		print("you died")
		return

	life_container.remove_child(life_container.get_child(0))


func _on_engine_killed(points: int) -> void:
	total_points += points
	points_label.text = str(total_points)


func _on_spawn_things_with_counter_timeout() -> void:
	path_follow_2d.progress_ratio = randf()

	var engine = engine_scene.instantiate()
	engine.speed = 100.0
	engine.counter = randi_range(1, 5)
	engine.type = engine.TYPE.COUNTER
	add_child(engine)
	engine.set_texture(engine_icons.pick_random())
	engine.set_target_position(godot.position)
	engine.position = path_follow_2d.position


func _on_spawn_things_timer_timeout() -> void:
	path_follow_2d.progress_ratio = randf()

	var engine = engine_scene.instantiate()
	add_child(engine)
	engine.set_texture(engine_icons.pick_random())
	engine.set_target_position(godot.position)
	engine.position = path_follow_2d.position
