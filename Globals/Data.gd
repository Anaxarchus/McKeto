extends Node


var ingredients:Dictionary
var recipes:Dictionary


func get_ingredient_by_id(id:int):
    for item in ingredients.keys():
        if ingredients[item]["id"] == id:
            return ingredients[item]


func get_recipe_by_id(id:int):
    for item in recipes.keys():
        if recipes[item]["id"] == id:
            return recipes[item]


func reid_ingredients():
    var alphabetical:Dictionary
    var sorted_dict:Dictionary
    var sort:Array
    for item in ingredients.keys():
        alphabetical[ingredients[item]["title"]] = ingredients[item]
        sort.append(ingredients[item]["title"])
    sort.sort()
    var id = 0
    for entry in sort:
        alphabetical[entry].id = id
        sorted_dict[id] = alphabetical[entry]
        id += 1
    ingredients = sorted_dict
        
    #var file = File.new()
    #file.open("user://ingredients.txt", File.WRITE)
    #file.store_var(ingredients)
    #file.close()


func reid_recipes():
    var alphabetical:Dictionary
    var sorted_dict:Dictionary
    var sort:Array
    for item in recipes.keys():
        alphabetical[recipes[item]["title"]] = recipes[item]
        sort.append(recipes[item]["title"])
    sort.sort()
    var id = 0
    for entry in sort:
        alphabetical[entry].id = id
        sorted_dict[id] = alphabetical[entry]
        id += 1
    recipes = sorted_dict
        


func load_recipes():
    var file = File.new()
    var err = file.open("user://recipes.txt", File.READ)
    if err == ERR_FILE_NOT_FOUND:
        print("no recipes found.")
        return
    else:
        recipes = file.get_var()

func load_ingredients():
    var file = File.new()
    var err = file.open("user://ingredients.txt", File.READ)
    if err == ERR_FILE_NOT_FOUND:
        print("no ingredients found.")
        return
    else:
        ingredients = file.get_var()


func save_recipe(recipe:Recipe):
    var id = recipe.id
    var data:Dictionary = {
        "id":id,
        "title":recipe.title,
        "description":recipe.description,
        "time_to_cook":recipe.time_to_cook,
        "ingredients":recipe.ingredients
       }
    recipes[id] = data
    reid_recipes()
    
    var file = File.new()
    file.open("user://recipes.txt", File.WRITE)
    file.store_var(recipes)
    file.close()
        

func save_ingredient(ingred:Ingredient):
    var id = ingred.id
    var data:Dictionary = {
        "id":id,
        "title":ingred.title,
        "serving_size":ingred.serving_size,
        "macros":ingred.macros.to_dictionary()
       }
    ingredients[id] = data
    reid_ingredients()
    
    var file = File.new()
    file.open("user://ingredients.txt", File.WRITE)
    file.store_var(ingredients)
    file.close()


func delete_recipe(id:int):
    pass

func delete_ingredient(id:int):
    pass


func get_new_ingredient_id() -> int:
    var new_id:int = 0
    for ing in ingredients.keys():
        if not ingredients[ing]["id"] == new_id:
            return new_id
        else:
            new_id += 1
    return new_id

func get_new_recipe_id() -> int:
    var new_id:int = 0
    for rec in recipes.keys():
        if not recipes[rec]["id"] == new_id:
            return new_id
        else:
            new_id += 1
    return new_id
    
