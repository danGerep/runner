extends Node2D

var heart_scene: PackedScene = preload("res://scenes/heart.tscn")
var custom_cursor = preload("res://assets/mouse-aim.png")

@onready var path_follow_2d: PathFollow2D = $SpawnLine/PathFollow2D
@onready var godot: Area2D = $Godot
@onready var life_container: HBoxContainer = %LifeContainer
@onready var points_label: Label = %PointsLabel
@onready var engine_manager: Node = $EngineManager
@onready var game_over: Control = %GameOver
@onready var game_over_score: Label = %GameOverScore
@onready var try_again: Button = %TryAgain
@onready var game_timer: Timer = $GameTimer
@onready var timer: Label = %Timer

var total_points: int
var elapsed_time = 0

func _ready() -> void:
	Input.set_custom_mouse_cursor(custom_cursor, Input.CURSOR_ARROW, Vector2(32, 32))

	try_again.pressed.connect(_on_try_again_pressed)
	game_timer.timeout.connect(_on_game_timer_timeout)
	GameManager.engine_killed.connect(_on_engine_killed)
	GameManager.player_damaged.connect(_on_player_damaged)
	GameManager.good_thing_collected.connect(_on_good_thing_collected)


func _on_game_timer_timeout() -> void:
	elapsed_time += 1
	var minutes = elapsed_time  / 60
	var seconds = elapsed_time  % 60
	timer.text = str(minutes).pad_zeros(2) + ":" + str(seconds).pad_zeros(2)

func _on_good_thing_collected(type: String) -> void:
	if type == "LIFE":
		var heart = heart_scene.instantiate()
		life_container.add_child(heart)
	if type == "SLOW_DOWN_TIME":
		engine_manager.slow_down_time()
	if type == "REVERT_TIME":
		engine_manager.rever_time()


func _stop_the_world() -> void:
	engine_manager.stop_everything()
	

func _on_player_damaged() -> void:
	var total_life: int = life_container.get_child_count()
	if total_life == 1:
		game_over.visible = true
		game_over_score.text = "%d points" % total_points
		_stop_the_world()

	if life_container.get_child_count() > 0:
		life_container.remove_child(life_container.get_child(0))


func _on_engine_killed(points: int) -> void:
	total_points += points
	points_label.text = str(total_points)


func _on_try_again_pressed() -> void:
	get_tree().reload_current_scene()
