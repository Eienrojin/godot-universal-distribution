extends GutTest

var zero_numbers : DistributionResult
var first_num_is_negative : DistributionResult
var default_case : DistributionResult
var two_numbers_is_negative : DistributionResult
var object_count_is_negative : DistributionResult
var first_num_smaller_than_second : DistributionResult
var too_many_objects : DistributionResult
var vector2_negative_arguments : DistributionResult

func before_all():
	zero_numbers = Distribution.by_float(0, 0, 0)
	first_num_is_negative = Distribution.by_float(-100, 684.0, 10)
	default_case = Distribution.by_float(582, 897, 10)
	two_numbers_is_negative = Distribution.by_float(-674, -583, 5)
	object_count_is_negative = Distribution.by_float(900, 2000, -5)
	first_num_smaller_than_second = Distribution.by_float(10, 3000, 5)
	too_many_objects = Distribution.by_float(127, 300, 200000)
	vector2_negative_arguments = Distribution.by_vector2(Vector2.ZERO, Vector2(100, 100), -39, 5)


func test_first_num_smaller_than_second():
	assert_eq(first_num_smaller_than_second.values[0], 10.0, "Should Pass")
	assert_eq(first_num_smaller_than_second.values[4], 3000.0, "Should Pass")
	assert_eq(first_num_smaller_than_second.is_valid, true, "Should be true")


func test_zero_numbers():
	assert_null(zero_numbers.values.front(), "Should be null")


func test_first_num_is_negative():
	assert_eq(first_num_is_negative.values.front(), -100.0, "Should Pass")
	assert_eq(first_num_is_negative.values.back(), 684.0, "Should Pass")


func test_two_numbers_is_negative():
	#-674, -583
	assert_eq(two_numbers_is_negative.values.front(), -674.0, "Should Pass")
	assert_eq(two_numbers_is_negative.values.back(), -583.0, "Should Pass")


func test_default_case():
	#582, 897
	assert_eq(default_case.values.front(), 582.0, "Should Pass")
	assert_eq(default_case.values.back(), 897.0, "Should Pass")


func test_object_count_is_negative():
	assert_eq(object_count_is_negative.is_valid, false, "Should be false")
	assert_eq(object_count_is_negative.values, [], "Must return an empty array")


func test_too_many_objects():
	assert_not_null(too_many_objects.values, "Should be not null")
	assert_eq(too_many_objects.values.size(), 200000, "Should be equal")


func test_vector2_negative_argument():
	assert_eq(vector2_negative_arguments.is_valid, false, "Should be false")
	assert_eq(vector2_negative_arguments.values, [], "Must return an empty array")
