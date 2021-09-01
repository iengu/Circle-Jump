extends Area2D

onready var orbit_position = $Pivot/OrbitPosition

enum MODES {STATIC, LIMITED}
var radius = 100
var rotation_speed = PI
var mode = MODES.STATIC
var num_orbits
var current_orbits = 0
var orbits_start = null

var jumper = null




func init(_position, _radius = radius, _mode = MODES.LIMITED):
	set_mode(_mode)
	position = _position
	radius = _radius
	$CollisionShape2D.shape = $CollisionShape2D.shape.duplicate()
	$CollisionShape2D.shape.radius = radius
	var img_size = $Sprite.texture.get_size().x / 2
	$Sprite.scale = Vector2(1, 1) * radius / img_size
	orbit_position.position.x = radius + 25
	rotation_speed *= pow(-1, randi() % 2)

func set_mode(_mode):
	mode = _mode
	match mode:
		MODES.STATIC:
			$Label.hide()
		MODES.LIMITED:
			$Label.text = str(current_orbits)
			$Label.show()

func _process(delta):
	$Pivot.rotation += rotation_speed * delta
	
func implode():
	$AnimationPlayer.play("implode")
	yield($AnimationPlayer, "animation_finished")
	queue_free()	

func capture(target):
	jumper = target
	$AnimationPlayer.play("Capture")
	$Pivot.rotation = (jumper.position - position).angle()
	orbits_start = $Pivot.rotation





