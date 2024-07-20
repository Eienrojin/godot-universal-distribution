extends Node
class_name Distribution


static func by_float(start: float, end: float, obj_count: int) -> DistributionResult:
	var result = DistributionResult.new()
	var full_value = calc_area_size(start, end)
	var pos_bias = full_value / (obj_count - 1)
	var current_value = start
	var obj_positions = []
	
	if obj_count <= 0:
		result.is_valid = false
	
	if result.is_valid:
		for i in obj_count:
			result.values.append(current_value)
			current_value += pos_bias
		return result
	
	return result


static func by_vector2(start: Vector2, end: Vector2, obj_count_x: int, obj_count_y: int) -> DistributionResult:
	var x_result_line = by_float(start.x, end.x, obj_count_x)
	var y_result_line = by_float(start.y, end.y, obj_count_y)
	var full_result = DistributionResult.new()
	
	if x_result_line.is_valid == false && y_result_line.is_valid == false:
		full_result.is_valid = false
		return full_result
	if obj_count_x <= 0 || obj_count_y <= 0:
		full_result.is_valid = false
		return full_result
	
	for i in obj_count_x:
		for j in obj_count_y:
			full_result.values.append(Vector2(x_result_line.values[i], y_result_line.values[j]))
	
	return full_result


static func fill_straight_line(start: float, end: float, obj_size: float) -> DistributionResult:
	var obj_count = ceil(calc_area_size(start, end) / obj_size)
	return by_float(start, end, obj_count)


static func fill_full_rect(start: Vector2, end: Vector2, obj_size: Vector2):
	pass


static func calc_area_size(start, end) -> Variant:
	var area_size = start - end
	return abs(area_size)


static func calculate_padding(size):
	pass

static func by_padding(distr_method : Callable, padding):
	pass
