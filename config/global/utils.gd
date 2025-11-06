class_name Utils extends Node


static func tween(node:Node, key:='tween') -> Tween:
	remove_tween(node, key)
	var tw:Tween = node.create_tween()
	node.set_meta(key, tw)
	return tw


static func remove_tween(node:Node, key:='tween'):
	if node.has_meta(key):
		var r = node.get_meta(key)
		if r is Tween:
			r.kill()


static func get_visible_ratio_time(text:String) -> float:
	const READING_SPEED_WORDS_PER_SECOND:float = 3.4
	var trimmed_text:String = text.strip_edges()
	if trimmed_text.is_empty():
		return 0.3
	var word_count := 1
	for symbol in trimmed_text:
		if symbol == " ":
			word_count += 1
	var time_seconds := float(word_count) / READING_SPEED_WORDS_PER_SECOND
	return time_seconds


static func get_unique_array(arr:Array) -> Array:
	var seen:Dictionary = {}
	var result:Array = []
	for item in arr:
		if not seen.has(item):
			seen[item] = true
			result.append(item)
	return result
