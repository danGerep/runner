extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D

var target: Vector2

var speed: float = 500.0


func _process(delta: float) -> void:
	position = position.move_toward(target, delta*speed)


func set_target_position(pos: Vector2) -> void:
	target = pos


func set_texture(texture: Texture2D) -> void:
	sprite_2d.texture = texture
