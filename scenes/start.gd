extends Node2D

@onready var start: Button = %Start


func _ready() -> void:
	start.pressed.connect(_on_start_pressed)


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")
