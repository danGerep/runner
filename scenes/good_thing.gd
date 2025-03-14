extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D

enum TYPE {LIFE, SLOW_DOWN_TIME, REVERT_TIME}

var target: Vector2
var speed: float = 200.0
var type: TYPE = TYPE.REVERT_TIME


func _ready() -> void:
	area_entered.connect(_on_area_entered)
	mouse_entered.connect(_on_mouse_entered)


func _on_mouse_entered() -> void:
	GameManager.good_thing_collected.emit(TYPE.keys()[type])
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	queue_free()


func _process(delta: float) -> void:
	position = position.move_toward(target, delta*speed)


func set_target_position(pos: Vector2) -> void:
	target = pos


func set_texture(texture: Texture2D) -> void:
	sprite_2d.texture = texture
