extends Control


var recipe:Recipe setget set_recipe
var category:int
var tags:Array
signal recipe_selected(recipe)
signal recipe_edit(recipe)


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
    
    tags = recipe.get_tags()
    if tags[recipe.tags.GLUTEN_FREE]:
        $VBoxContainer/HBoxContainer2/VBoxContainer/ScrollContainer/Tags/GF.show()
    else:
        $VBoxContainer/HBoxContainer2/VBoxContainer/ScrollContainer/Tags/GF.hide()
    if tags[recipe.tags.KETOGENIC]:
        $VBoxContainer/HBoxContainer2/VBoxContainer/ScrollContainer/Tags/KETO.show()
    else:
        $VBoxContainer/HBoxContainer2/VBoxContainer/ScrollContainer/Tags/KETO.hide()
    if tags[recipe.tags.VEGETARIAN]:
        $VBoxContainer/HBoxContainer2/VBoxContainer/ScrollContainer/Tags/VEG.show()
    else:
        $VBoxContainer/HBoxContainer2/VBoxContainer/ScrollContainer/Tags/VEG.hide()
    if tags[recipe.tags.PESCATARIAN]:
        $VBoxContainer/HBoxContainer2/VBoxContainer/ScrollContainer/Tags/PESC.show()
    else:
        $VBoxContainer/HBoxContainer2/VBoxContainer/ScrollContainer/Tags/PESC.hide()
        
    
    #$VBoxContainer/HBoxContainer2/VBoxContainer/Description.wrap_enabled = false
    #$VBoxContainer/HBoxContainer2/VBoxContainer/Description.wrap_enabled = true


func _on_AddToCart_pressed():
    emit_signal("recipe_selected", self)


func _on_Edit_pressed():
    emit_signal("recipe_edit", recipe)
