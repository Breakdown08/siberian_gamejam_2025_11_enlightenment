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
