class_name LayeredSprite
extends Node2D


# Sets the texture of a layer.
func set_layer(name: String, texture: Texture) -> bool:
	if has_node(name):
		var layer = get_node(name)
		if layer is Sprite:
			layer.texture = texture
			return true
	return false


# Moves the position of this layer.
func move_layer(name: String, to_position: int) -> bool:
	if not has_node(name):
		return false
	move_child(get_node(name), to_position)
	return true


# Returns the position of the child.
func get_layer_position(name: String) -> int:
	var position = 0
	for child in get_children():
		if child.name == name: return position
		position += 1
	return -1


# Adds a layer with the given name and texture.
func add_layer(name: String, texture: Texture = null) -> bool:
	# Check if there is a layer with this name already.
	if has_node(name): return false
	# Create new layer.
	var new_layer := Sprite.new()
	new_layer.name = name
	new_layer.texture = texture
	add_child(new_layer)
	return true


# Removes the layer with this name.
func remove_layer(name: String) -> bool:
	if not has_node(name): return false
	get_node(name).queue_free()
	return true


# Returns a dictionary with key name of the layer
# and value the texture of that layer.
func get_layers() -> Dictionary:
	var layers := {}
	for child in get_children():
		if child is Sprite:
			layers[child.name] = child
	return layers


# Returns the number of layers of this LayeredSprite.
func get_layer_count() -> int:
	var count = 0
	for child in get_children():
		if child is Sprite:
			count += 1
	return count
