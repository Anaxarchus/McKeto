extends Control

var ingredient_placard = preload("res://Scenes/IngredientPlacard.tscn")

var title:String
var time_to_cook:int
var ingredients:Array setget set_ingredients
var instructions:String

signal recipe_created
signal creation_canceled


func set_ingredients(value:Array):
    for child in $VBoxContainer/ScrollContainer/Ingredients.get_children():
        $VBoxContainer/ScrollContainer/Ingredients.remove_child(child)
        child.queue_free()
    ingredients = value
    for ingredient in ingredients:
        var ing = Data.get_ingredient_by_id(ingredient)
        var plac = ingredient_placard.instance()
        plac.id = ing["id"]
        plac.title = ing["title"]
        $VBoxContainer/ScrollContainer/Ingredients.add_child(plac)
        


func _on_IngredientFinder_ingredient_selected(id):
    var ing = ingredients
    ing.append(id)
    set_ingredients(ing)


func _on_AddIngredient_pressed():
    $IngredientFinder.popup_centered()
    $IngredientFinder.show_ingredients()


func _on_Save_pressed():
    emit_signal("recipe_created")
    var rec = Recipe.new()
    rec.title = $VBoxContainer/RecipeName/RecipeName.text
    rec.time_to_cook = $VBoxContainer/TimeToCook/TimeToCook.value
    rec.id = Data.get_new_recipe_id()
    rec.description = $VBoxContainer/TextEdit.text
    var ings:Array
    for ing in $VBoxContainer/ScrollContainer/Ingredients.get_children():
        ings.append([ing.id, ing.quantity])
    rec.ingredients = ings
    Data.save_recipe(rec)


func _on_Cancel_pressed():
    emit_signal("creation_canceled")
