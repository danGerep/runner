extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D

var target: Vector2
var speed: float = 500.0


func _ready() -> void:
	area_entered.connect(_on_area_entered)
	mouse_entered.connect(_on_mouse_entered)


func _on_mouse_entered() -> void:
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	pass


func _process(delta: float) -> void:
	position = position.move_toward(target, delta*speed)


func set_speed(sp: float) -> void:
	speed = sp


func set_target_position(pos: Vector2) -> void:
	target = pos


func set_texture(texture: Texture2D) -> void:
	sprite_2d.texture = texture
