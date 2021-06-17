extends Node


var recipes:Array


func get_recipe_by_id(id):
    for recipe in recipes:
        if recipe.id == id:
            return recipe
