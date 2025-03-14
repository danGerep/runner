extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var counter_label: Label = $CounterLabel
@onready var slow_down_timer: Timer = $SlowDownTimer

enum TYPE { NORMAL, COUNTER }

var target: Vector2
var speed: float = 200.0
var counter: int
var type: TYPE = TYPE.NORMAL

# Checks if the engine is already slowed. I should be slowed once.
var slowed: bool

# Keep track of the slow amount to undo the effect later.
var slow_down_amount:float


func _ready() -> void:
	slow_down_timer.timeout.connect(_on_slow_down_timer_timeout)
	area_entered.connect(_on_area_entered)
	mouse_entered.connect(_on_mouse_entered)

	if counter > 0:
		counter_label.text = str(counter)


func _on_slow_down_timer_timeout() -> void:
	speed = speed / (1 - slow_down_amount)


func _on_mouse_entered() -> void:
	if type == TYPE.NORMAL:
		GameManager.engine_killed.emit(1)
		queue_free()

	if counter == 1:
		GameManager.engine_killed.emit(1)
		queue_free()

	counter -= 1
	counter_label.text = str(counter)


func _on_area_entered(area: Area2D) -> void:
	queue_free()


func _process(delta: float) -> void:
	position = position.move_toward(target, delta*speed)


func set_target_position(pos: Vector2) -> void:
	target = pos


func set_texture(texture: Texture2D) -> void:
	sprite_2d.texture = texture


func slow_down(amount: float) -> void:
	if slowed:
		return

	slowed = true

	slow_down_timer.start()
	slow_down_amount = amount

	speed -= speed * slow_down_amount
	print("updated speed ", speed)
