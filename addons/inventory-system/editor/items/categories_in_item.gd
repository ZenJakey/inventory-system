@tool
extends HBoxContainer
class_name CategoriesInItem


var item : InventoryItem
var database : InventoryDatabase
var objs : Array[CheckBox]


@onready var h_flow_container = $ScrollContainer/HFlowContainer


func load_item(database : InventoryDatabase, item : InventoryItem):
	self.database = database
	self.item = item
	loading_categories()


func loading_categories():
	for p in objs:
		p.queue_free()
	objs.clear()
	for category in database.item_categories:
		print("ok ",item.name)
		var option_obj = CheckBox.new()
		option_obj.text = category.name
		print(item.categories.find(category))
		option_obj.button_pressed = item.categories.find(category) != -1
		option_obj.icon = category.icon
		option_obj.expand_icon = true
		option_obj.toggled.connect(_on_toggled_category_option.bind(category))
		objs.append(option_obj)
		h_flow_container.add_child(option_obj)
			

#func setup_option_button(checkbox : CheckBox):
#	for category in categories_option_buttons:
#		option_button.add_icon_item()


func _on_toggled_category_option(toggled : bool, category : ItemCategory):
	if toggled:
		item.categories.append(category)
		print(item.name," added category ",category.name)
	else:
		var index = item.categories.find(category)
		if index > -1:
			item.categories.remove_at(index)
