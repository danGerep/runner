extends Area2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var points: int


func _ready() -> void:
	area_entered.connect(_on_area_entered)


func _on_area_entered(_area: Area2D) -> void:
	GameManager.player_damaged.emit()
