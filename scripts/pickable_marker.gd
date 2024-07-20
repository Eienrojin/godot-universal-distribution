extends Marker2D

signal on_pickup(is_picked)
var is_picked: bool = false

func _physics_process(delta: float) -> void:
	if is_picked:
		self.global_position = get_global_mouse_position()
		on_pickup.emit(is_picked)
		#test


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			is_picked = true
		else:
			is_picked = false
	
