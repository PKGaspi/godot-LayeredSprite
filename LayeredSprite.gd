class_name LayeredSprite
extends Node2D


# Sets the texture of a layer.
func set_sprite_layer(name: String, texture: Texture) -> void:
	if not has_node(name):
		push_warning("The layer with name '" + name + "' was not found.")
		return
	var layer = get_node(name)
	if not layer is Sprite:
		push_warning("The layer '" + name + "' is not an AnimatedSprite")
	
	layer.texture = texture



func set_animated_sprite_layer(name: String, frames: SpriteFrames) -> void:
	if not has_node(name):
		push_warning("Layer with name '" + name + "' not found.")
		return
	var layer = get_node(name)
	if not layer is AnimatedSprite:
		push_warning("The layer '" + name + "' is not an AnimatedSprite")
	
	layer.frames = frames


# Moves the position of this layer.
func move_layer(name: String, to_position: int) -> void:
	if not has_node(name):
		push_warning("Layer with name '" + name + "' not found.")
		return 
	move_child(get_node(name), to_position)


# Returns the position of the child.
func get_layer_position(name: String) -> int:
	var position = 0
	for child in get_children():
		if child.name == name: return position
		position += 1
	push_warning("Layer with name '" + name + "' not found.")
	return 0


# Adds a layer with the given name and texture.
func add_sprite_layer(name: String, texture: Texture = null) -> void:
	# Check if there is a layer with this name already.
	if has_node(name): 
		push_warning("A layer with name '" + name + "' already exists.")
		return
	# Create new layer.
	var new_layer := Sprite.new()
	new_layer.name = name
	new_layer.texture = texture
	add_child(new_layer)


# Removes the layer with this name.
func remove_layer(name: String) -> void:
	if not has_node(name): 
		push_warning("Layer with name '" + name + "' not found.")
		return 
	get_node(name).queue_free()


# Returns a dictionary with key name of the layer
# and value the texture of that layer.
func get_layers() -> Dictionary:
	var layers := {}
	for child in get_children():
		if (child is Sprite or child is AnimatedSprite) and not child.is_queued_for_deletion():
			layers[child.name] = child
	return layers


# Returns the number of layers of this LayeredSprite.
func get_layer_count() -> int:
	var count = 0
	for child in get_children():
		if (child is Sprite or child is AnimatedSprite) and not child.is_queued_for_deletion():
			count += 1
	return count
