class_name ObjectPlacer
extends NodeInventorySystemBase

signal dropped
signal placed

@export var property_from_item_for_object_scene : String = "placeable"
@export var drop_node_path : NodePath = "../../../.."
@onready var drop_node_parent : Node = get_node(drop_node_path)
@export_node_path("InventoryHandler") var inventory_handler_path := NodePath("../../InventoryHandler")
@onready var inventory_handler : InventoryHandler = get_node(inventory_handler_path)


# TODO Add code to interactor child node (InteractorResponse)
func place_item(item : InventoryItem, position : Vector3, rotation : Vector3):
	# TODO Add 3D Preview
	if !item.properties.has(property_from_item_for_object_scene):
		return
	var path = item.properties[property_from_item_for_object_scene]
	var res = load(path)
	if res is PackedScene:
		var scene = res as PackedScene
		inventory_handler.inventory.remove(item)
		_instantiate_object(scene, position, rotation)


func _instantiate_object(dropped_item : PackedScene, position : Vector3, rotation : Vector3):
	var obj = dropped_item.instantiate()
	drop_node_parent.add_child(obj)
	obj.position = position
	obj.rotation = rotation
	dropped.emit(obj)
