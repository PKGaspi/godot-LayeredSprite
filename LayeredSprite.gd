class_name LayeredSprite
extends Node2D

# LayeredSprite, a node to manage separated Sprite and/or AnimatedSprite
# nodes to make the illusion of them working as one, while being able
# to modify layers individualy.
var _layers_visibility = {}

# Adds an animated layer with the given name and sprite_frames.
func add_animated_sprite_layer(layer_name: String, sprite_frames: SpriteFrames = null) -> void:
	# Check if there is a layer with this name already.
	if has_layer(layer_name): 
		push_warning("A layer with name '" + layer_name + "' already exists.")
		return
	# Create new layer.
	var new_layer := AnimatedSprite2D.new()
	new_layer.name = layer_name
	new_layer.sprite_frames = sprite_frames
	add_child(new_layer)


# Adds a static layer with the given name and texture.
func add_sprite_layer(layer_name: String, texture: Texture2D = null) -> void:
	# Check if there is a layer with this name already.
	if has_layer(layer_name): 
		push_warning("A layer with name '" + layer_name + "' already exists.")
		return
	# Create new layer.
	var new_layer := Sprite2D.new()
	new_layer.name = layer_name
	new_layer.texture = texture
	add_child(new_layer)


# Returns the number of layers of this LayeredSprite.
func get_layer_count() -> int:
	var count = 0
	for child in get_children():
		if (child is Sprite2D or child is AnimatedSprite2D) and not child.is_queued_for_deletion():
			count += 1
	return count


# Returns the position of the child.
func get_layer_position(layer_name: String) -> int:
	var position = 0
	for child in get_children():
		if child.name == layer_name: return position
		position += 1
	push_warning("Layer with name '" + layer_name + "' was not found.")
	return -1


# Returns a dictionary with key name of the layer
# and value the texture of that layer.
func get_layers() -> Dictionary:
	var layers := {}
	for child in get_children():
		if (child is Sprite2D or child is AnimatedSprite2D) and not child.is_queued_for_deletion():
			layers[child.name] = child
	return layers


# Returns true if layer_name exists.
func has_layer(layer_name: String) -> bool:
	return has_node(layer_name)


# Returns true if layer_name is an AnimatedSprite layer. 
func is_animated_sprite_layer(layer_name: String) -> bool:
	return get_node(layer_name) is AnimatedSprite2D


# Returns true if layer_name is a Sprite layer.
func is_sprite_layer(layer_name: String) -> bool:
	return get_node(layer_name) is Sprite2D


# Moves the position of this layer.
func move_layer(layer_name: String, to_position: int) -> void:
	if not has_layer(layer_name):
		push_warning("Layer with name '" + layer_name + "' was not found.")
		return 
	move_child(get_node(layer_name), to_position)


# Removes the layer with this name.
func remove_layer(layer_name: String) -> void:
	if not has_layer(layer_name): 
		push_warning("Layer with name '" + layer_name + "' was not found.")
		return 
	get_node(layer_name).queue_free()


# Sets an animation to all animated layers.
func set_animation(animation: String) -> void:
	var layers = get_layers()
	for layer in layers:
		if layers[layer] is AnimatedSprite2D and layers[layer].sprite_frames.has_animation(animation):
			layers[layer].animation = animation

func play() -> void:
	var layers = get_layers()
	for layer in layers:
		if layers[layer] is AnimatedSprite2D:
			layers[layer].play()


# Sets an animation to a particular layer.
func set_layer_animation(layer_name: String, animation: String) -> void:
	if not has_layer(layer_name):
		push_warning("The layer with name '" + layer_name + "' was not found.")
		return
	var layer = get_node(layer_name)
	if not layer is AnimatedSprite2D:
		push_warning("The layer '" + layer_name + "' is not an AnimatedSprite2D")
		return
	
	layer.animation = animation


# Sets the texture or SpriteFrames to a particular layer.
func set_layer_asset(layer_name: String, asset) -> void:
	if not has_layer(layer_name):
		push_warning("The layer with name '" + layer_name + "' was not found.")
		return
	var layer = get_node(layer_name)
	if layer is AnimatedSprite2D:
		_set_animated_sprite_layer_asset(layer_name, asset)
	elif layer is Sprite2D:
		_set_sprite_layer_asset(layer_name, asset)


func set_layer_visible(layer_name: String, value: bool) -> void:
	if not has_layer(layer_name):
		push_warning("The layer with name '" + layer_name + "' was not found.")
		return
	var layer = get_node(layer_name)
	_layers_visibility[layer_name] = value
	layer.visible = value


# Sets the sprite_frames of an animated layer.
func _set_animated_sprite_layer_asset(layer_name: String, sprite_frames: SpriteFrames) -> void:
	if not has_layer(layer_name):
		push_warning("Layer with name '" + layer_name + "' was not found.")
		return
	var layer = get_node(layer_name)
	if not layer is AnimatedSprite2D:
		push_warning("The layer '" + layer_name + "' is not an AnimatedSprite2D")
		return
	
	if layer.is_playing():
		await layer.frame_changed
		
	
	if sprite_frames == null:
		layer.visible = false
	else:
		layer.visible = _layers_visibility[layer_name] if layer_name in _layers_visibility else true
		layer.sprite_frames = sprite_frames
	
	

# Sets the texture of a static layer.
func _set_sprite_layer_asset(layer_name: String, texture: Texture2D) -> void:
	if not has_layer(layer_name):
		push_warning("The layer with name '" + layer_name + "' was not found.")
		return
	var layer = get_node(layer_name)
	if not layer is Sprite2D:
		push_warning("The layer '" + layer_name + "' is not a Sprite2D")
		return
	
	layer.texture = texture
	


