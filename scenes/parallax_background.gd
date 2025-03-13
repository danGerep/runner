extends ParallaxBackground


@export var scroll_speed: float = -2000.0  # Adjust speed as needed

func _process(delta):
	scroll_offset.x += scroll_speed * delta
