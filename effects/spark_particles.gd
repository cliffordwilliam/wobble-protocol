class_name SparkParticles
extends GPUParticles2D


func _ready() -> void:
	finished.connect(queue_free)
	emitting = true
