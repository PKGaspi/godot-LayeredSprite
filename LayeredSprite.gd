class_name LayeredSprite
extends Node2D

# LayeredSprite, a node to manage separated Sprite and/or AnimatedSprite
# nodes to make the illusion of them working as one, while being able
# to modify layers individualy.


# Adds an animated layer with the given name and frames.
func add_animated_sprite_layer(layer_name: String, frames: SpriteFrames = null) -> void:
	# Check if there is a layer with this name already.
	if has_node(layer_name): 
		push_warning("A layer with name '" + layer_name + "' already exists.")
		return
	# Create new layer.
	var new_layer := AnimatedSprite.new()
	new_layer.name = layer_name
	new_layer.frames = frames
	add_child(new_layer)


# Adds a static layer with the given name and texture.
func add_sprite_layer(layer_name: String, texture: Texture = null) -> void:
	# Check if there is a layer with this name already.
	if has_node(layer_name): 
		push_warning("A layer with name '" + layer_name + "' already exists.")
		return
	# Create new layer.
	var new_layer := Sprite.new()
	new_layer.name = layer_name
	new_layer.texture = texture
	add_child(new_layer)


# Returns the number of layers of this LayeredSprite.
func get_layer_count() -> int:
	var count = 0
	for child in get_children():
		if (child is Sprite or child is AnimatedSprite) and not child.is_queued_for_deletion():
			count += 1
	return count


# Returns the position of the child.
func get_layer_position(layer_name: String) -> int:
	var position = 0
	for child in get_children():
		if child.name == layer_name: return position
		position += 1
	push_warning("Layer with name '" + layer_name + "' was not found.")
	return 0


# Returns a dictionary with key name of the layer
# and value the texture of that layer.
func get_layers() -> Dictionary:
	var layers := {}
	for child in get_children():
		if (child is Sprite or child is AnimatedSprite) and not child.is_queued_for_deletion():
			layers[child.name] = child
	return layers


# Moves the position of this layer.
func move_layer(layer_name: String, to_position: int) -> void:
	if not has_node(layer_name):
		push_warning("Layer with name '" + layer_name + "' was not found.")
		return 
	move_child(get_node(layer_name), to_position)


# Removes the layer with this name.
func remove_layer(layer_name: String) -> void:
	if not has_node(layer_name): 
		push_warning("Layer with name '" + layer_name + "' was not found.")
		return 
	get_node(layer_name).queue_free()


# Sets an animation to all animated layers.
func set_animation(animation: String):
	for layer in get_layers():
		if layer is AnimatedSprite and layer.frames.has_animation(animation):
			layer.animation = animation


# Sets the frames of an animated layer.
func set_animated_sprite_layer(layer_name: String, frames: SpriteFrames) -> void:
	if not has_node(layer_name):
		push_warning("Layer with name '" + layer_name + "' was not found.")
		return
	var layer = get_node(layer_name)
	if not layer is AnimatedSprite:
		push_warning("The layer '" + layer_name + "' is not an AnimatedSprite")
		return
	
	layer.frames = frames


# Sets an animation to a particular layer.
func set_layer_animation(layer_name: String, animation: String) -> void:
	if not has_node(layer_name):
		push_warning("The layer with name '" + layer_name + "' was not found.")
		return
	var layer = get_node(layer_name)
	if not layer is AnimatedSprite:
		push_warning("The layer '" + layer_name + "' is not an AnimatedSprite")
		return
	
	layer.animation = animation


# Sets the texture of a static layer.
func set_sprite_layer(layer_name: String, texture: Texture) -> void:
	if not has_node(layer_name):
		push_warning("The layer with name '" + layer_name + "' was not found.")
		return
	var layer = get_node(layer_name)
	if not layer is Sprite:
		push_warning("The layer '" + layer_name + "' is not a Sprite")
		return
	
	layer.texture = texture


