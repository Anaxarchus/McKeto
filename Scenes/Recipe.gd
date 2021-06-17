extends Control


var recipe:Recipe setget set_recipe
var category:int
signal recipe_selected(recipe)


func set_recipe(value:Recipe):
    recipe = value
    $VBoxContainer/HBoxContainer2/Info/ScrollContainer/VBoxContainer/Calories.text = "Calories: " + String(value.sum_calories/100)
    $VBoxContainer/HBoxContainer2/Info/ScrollContainer/VBoxContainer/Carbs.text = "Carbs: " + String(value.sum_carbs/100) + "g"
    $VBoxContainer/HBoxContainer2/Info/ScrollContainer/VBoxContainer/Proteins.text = "Proteins: " + String(value.sum_protein/100) + "g"
    $VBoxContainer/HBoxContainer2/Info/ScrollContainer/VBoxContainer/Fats.text = "Fats: " + String(value.sum_fat/100) + "g"
    $VBoxContainer/HBoxContainer2/Info/ScrollContainer/VBoxContainer/Fiber.text = "Fiber: " + String(value.sum_fiber/100) + "g"
    $VBoxContainer/HBoxContainer2/Info/ScrollContainer/VBoxContainer/Sugar.text = "Sugar: " + String(value.sum_sugar/100) + "g"
    
    $VBoxContainer/HBoxContainer2/Info/Title.text = value.title
    $VBoxContainer/HBoxContainer2/VBoxContainer/ScrollContainer2/Description.text = "Ingredients:" + "\n"
    for ingred in value.ingredients:
        $VBoxContainer/HBoxContainer2/VBoxContainer/ScrollContainer2/Description.text += ingred.title + ": " + String(ingred.quantity) + "g\n"
    $VBoxContainer/HBoxContainer2/VBoxContainer/ScrollContainer2/Description.text += "\n" + "Description:"
    $VBoxContainer/HBoxContainer2/VBoxContainer/ScrollContainer2/Description.text += "\n" + value.description
    
    #$VBoxContainer/HBoxContainer2/VBoxContainer/Description.wrap_enabled = false
    #$VBoxContainer/HBoxContainer2/VBoxContainer/Description.wrap_enabled = true


func _on_AddToCart_pressed():
    emit_signal("recipe_selected", self)
