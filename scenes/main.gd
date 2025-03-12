extends Node2D

@onready var path_follow_2d: PathFollow2D = $SpawnLine/PathFollow2D
@onready var godot: Area2D = $Godot
@onready var life_container: HBoxContainer = %LifeContainer
@onready var points_label: Label = %PointsLabel


var total_points: int


func _ready() -> void:
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
