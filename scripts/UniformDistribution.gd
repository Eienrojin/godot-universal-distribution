extends Node2D

@onready var test_object = preload("res://scenes/test_object.tscn")
const TEST_OBJECT = preload("res://scenes/test_object.tscn")
@onready var objects_manager = $ObjectsManager
@onready var start_marker = $StartMarker
@onready var end_marker = $EndMarker
@export var count_obj_x = 0
@export var count_obj_y = 0


func _ready() -> void:
	start_marker.on_pickup.connect(Callable(self, "_start_marker_pick_status_changed"))
	end_marker.on_pickup.connect(Callable(self, "_end_marker_pick_status_changed"))
	var result_dist = end_marker.global_position - start_marker.global_position
	var obj = TEST_OBJECT.instantiate()
	var size = obj.texture.get_size() * obj.scale
	print(result_dist / size)
	
	var objects = Distribution.fill_straight_line(start_marker.global_position.y, end_marker.global_position.y, size.y)
	
	for i in objects.values.size():
		var new_object = test_object.instantiate()
		objects_manager.add_child(new_object)
		new_object.global_position = Vector2(start_marker.global_position.x, objects.values[i])


func refresh():
	var children = objects_manager.get_children()
	for c in children:
		objects_manager.remove_child(c)
	
	var coordinates = Distribution.by_vector2(start_marker.global_position, end_marker.global_position, count_obj_x, count_obj_y)
	for i in count_obj_x * count_obj_y:
		var new_object = test_object.instantiate()
		objects_manager.add_child(new_object)
		new_object.global_position = coordinates.values[i]
	
	var to_print = "objects: [x: {x_count}, y: {y_count}]".format({
		"x_count" : count_obj_x,
		"y_count" : count_obj_y
	})
	print(to_print)


func _on_x_count_slider_value_changed(value):
	count_obj_x = value
	refresh()


func _on_y_count_slider_value_changed(value):
	count_obj_y = value
	refresh()


func _start_marker_pick_status_changed(is_picked):
	if is_picked:
		refresh()


func _end_marker_pick_status_changed(is_picked):
	if is_picked:
		refresh()
