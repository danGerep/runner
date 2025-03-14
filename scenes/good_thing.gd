extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D

enum TYPE {LIFE, SLOW_DOWN_TIME, REVERT_TIME}

var target: Vector2
var speed: float = 200.0
var type: TYPE = TYPE.LIFE

var icons: Dictionary = {
	TYPE.LIFE: preload("res://assets/heart.png"),
	TYPE.SLOW_DOWN_TIME: preload("res://assets/slow.png"),
	TYPE.REVERT_TIME: preload("res://assets/revert.png")
}


func _ready() -> void:
	area_entered.connect(_on_area_entered)
	mouse_entered.connect(_on_mouse_entered)


func get_random_type() -> void:
	type = TYPE.values().pick_random()
	sprite_2d.texture = icons[type]


func _on_mouse_entered() -> void:
	GameManager.good_thing_collected.emit(TYPE.keys()[type])
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	queue_free()


func _process(delta: float) -> void:
	position = position.move_toward(target, delta*speed)


func set_target_position(pos: Vector2) -> void:
	target = pos
