extends RigidBody2D



# Called when the node enters the scene tree for the first time.
func _ready():
	var collisionArea = $Area2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_area_2d_body_entered(body):
	queue_free()
