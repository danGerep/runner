extends Node2D

var heart_scene: PackedScene = preload("res://scenes/heart.tscn")

@onready var path_follow_2d: PathFollow2D = $SpawnLine/PathFollow2D
@onready var godot: Area2D = $Godot
@onready var life_container: HBoxContainer = %LifeContainer
@onready var points_label: Label = %PointsLabel
@onready var engine_manager: Node = $EngineManager


var total_points: int


func _ready() -> void:
	GameManager.engine_killed.connect(_on_engine_killed)
	GameManager.player_damaged.connect(_on_player_damaged)
	GameManager.good_thing_collected.connect(_on_good_thing_collected)


func _on_good_thing_collected(type: String) -> void:
	if type == "LIFE":
		var heart = heart_scene.instantiate()
		life_container.add_child(heart)
	if type == "SLOW_DOWN_TIME":
		engine_manager.slow_down_time()
	if type == "REVERT_TIME":
		engine_manager.rever_time()


func _on_player_damaged() -> void:
	var total_life: int = life_container.get_child_count()
	if total_life == 0:
		print("you died")
		return

	life_container.remove_child(life_container.get_child(0))


func _on_engine_killed(points: int) -> void:
	total_points += points
	points_label.text = str(total_points)
