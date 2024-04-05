extends Object
class_name NodeUtils


static func get_child_of_type(node: Node, child_type, recursive := false):
	for i in range(node.get_child_count()):
		var child = node.get_child(i)
		if is_instance_of(child, child_type):
			return child
		if recursive:
			var child_node = get_child_of_type(child, child_type, recursive)
			if child_node:
				return child_node


static func get_children_of_type(node: Node, child_type, recursive := false):
	var list = []
	for i in range(node.get_child_count()):
		var child = node.get_child(i)
		if is_instance_of(child, child_type):
			list.append(child)
		if recursive:
			list += get_children_of_type(child, child_type, recursive)
	return list
