extends Control

var ingredient_placard = preload("res://Scenes/IngredientPlacard.tscn")

enum modes {NEW, EDIT}
var mode:int = 0 setget set_mode

var title:String setget set_title
var time_to_cook:int setget set_time_to_cook
var ingredients:Array setget set_ingredients
var instructions:String setget set_instructions
var id:int = -1

signal recipe_created
signal creation_canceled
signal recipe_deleted


func set_mode(value:int):
    mode = value
    
    if value == modes.EDIT:
        $VBoxContainer/HBoxContainer/Delete.show()
    
    elif value == modes.NEW:
        $VBoxContainer/HBoxContainer/Delete.hide()
        id = -1
        self.title = ""
        self.time_to_cook = 0
        self.ingredients = []
        self.instructions = ""
        

func load_recipe(recipe:Recipe):
    self.title = recipe.title
    self.time_to_cook = recipe.time_to_cook
    self.ingredients = recipe.ingredients
    self.instructions = recipe.description
    self.id = recipe.id


func set_title(value:String):
    $VBoxContainer/RecipeName/RecipeName.text = value


func set_time_to_cook(value:int):
    $VBoxContainer/TimeToCook/TimeToCook.value = value


func set_ingredients(value:Array):
    for child in $VBoxContainer/ScrollContainer/Ingredients.get_children():
        $VBoxContainer/ScrollContainer/Ingredients.remove_child(child)
        child.queue_free()
    var ings:Array
    for ingredient in value:
        print(ingredient)
        var plac = ingredient_placard.instance()
        plac.id = ingredient.id
        plac.title = ingredient.title
        plac.quantity = ingredient.quantity
        ings.append([ingredient.id, ingredient.quantity])
        $VBoxContainer/ScrollContainer/Ingredients.add_child(plac)
    ingredients = ings


func set_instructions(value:String):
    $VBoxContainer/TextEdit.text = value


func append_ingredients(value:Array):
    var ing = Data.get_ingredient_by_id(value[0])
    var plac = ingredient_placard.instance()
    plac.id = ing["id"]
    plac.title = ing["title"]
    plac.quantity = value[1]
    $VBoxContainer/ScrollContainer/Ingredients.add_child(plac)


func _on_IngredientFinder_ingredient_selected(id):
    append_ingredients([id, 0])


func _on_AddIngredient_pressed():
    $IngredientFinder.popup_centered()
    $IngredientFinder.show_ingredients()


func _on_Save_pressed():
    var rec = Recipe.new()
    rec.title = $VBoxContainer/RecipeName/RecipeName.text
    rec.time_to_cook = $VBoxContainer/TimeToCook/TimeToCook.value
    if id == -1:
        rec.id = Data.get_new_recipe_id()
    else:
        rec.id = id
    rec.description = $VBoxContainer/TextEdit.text
    var ings:Array
    for ing in $VBoxContainer/ScrollContainer/Ingredients.get_children():
        ings.append([ing.id, ing.quantity])
    rec.ingredients = ings
    Data.save_recipe(rec)
    emit_signal("recipe_created")


func _on_Cancel_pressed():
    emit_signal("creation_canceled")


func _on_Delete_pressed():
    Data.delete_recipe(id)
    emit_signal("recipe_deleted")
