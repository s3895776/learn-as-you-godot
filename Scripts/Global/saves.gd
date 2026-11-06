extends Node

var generic_save_state_file = "user://genericsavefile.save"
var save_state_level_one_file = "user://savestatelevelonefile.save"

var saves = [generic_save_state_file, save_state_level_one_file]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().auto_accept_quit = false
	pass

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		for file_string in saves:
			delete_save_files(file_string)
			get_tree().quit()
		
func delete_save_files(save_file : String):
	# needs testing 
	print("on delete")
	if FileAccess.file_exists(save_file):
		DirAccess.remove_absolute(save_file)
		print("Save file deleted.")
	else:
		print("Save file not found.")
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# save states and load states: read godot engine docs on saving games.
 
## while running, save the persistent objects from root. 
func save_state(level_type: StateManager.Level, root : Node):
	print("I'm B.A, go to C")
	var save_state_file : String
#	currently empty :(
	if level_type == StateManager.Level.LEVEL_ONE:
		pass
		
	var save_file = FileAccess.open(save_state_file, FileAccess.WRITE)
	
	var save_nodes = root.get_tree().get_nodes_in_group("Persist")
	for node in save_nodes:
#		check the node is an instance scene to instance during load. 
		if node.scene_file_path.is_empty():
			print("node '%s' is not instanced, skipped" % node.name)
			continue
		
		if !node.has_method("save"):
			print("persistent node '%s' is missing a save() function, skipped" % node.name)
			continue
		
#		call save function
		var node_data = node.call("save")
		
		var json_string = JSON.stringify(node_data)
		
		save_file.store_line(json_string)
		
func load_state(save_state_file : String):
	print("I'm C.A, go to D")
	
	if not FileAccess.file_exists(save_state_file):
#		load a new scene. 
		
		return # Error! We don't have a save to load.

	# We need to revert the game state so we're not cloning objects
	# during loading. This will vary wildly depending on the needs of a
	# project, so take care with this step.
	# For our example, we will accomplish this by deleting saveable objects.
	var save_file = FileAccess.open(save_state_file, FileAccess.READ)
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()

		# Creates the helper class to interact with JSON.
		var json = JSON.new()

		# Check if there is any error while parsing the JSON string, skip in case of failure.
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue

		# Get the data from the JSON object.
		var node_data = json.data

		# create the object, add it to the tree and set its position.
		var new_object = load(node_data["filename"]).instantiate()
		get_node(node_data["parent"]).add_child(new_object)
		new_object.position = Vector2(node_data["pos_x"], node_data["pos_y"])

		# Set the remaining variables if needed for save state. 
		#for i in node_data.keys():
			#if i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y":
				#continue
			#new_object.set(i, node_data[i])
