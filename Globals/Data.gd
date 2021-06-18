extends Node


var ingredients:Dictionary
var recipes:Dictionary
onready var home_directory:String = OS.get_executable_path().get_base_dir() # Use on export
#onready var home_directory:String = "user:/" # Use in editor


func get_ingredient_by_id(id:int):
    for item in ingredients.keys():
        if ingredients[item]["id"] == id:
            return ingredients[item]


func get_recipe_by_id(id:int):
    for item in recipes.keys():
        if recipes[item]["id"] == id:
            return recipes[item]


func sort_ingredients():
    var alphabetical:Dictionary
    var sorted_dict:Dictionary
    var sort:Array
    for item in ingredients.keys():
        alphabetical[ingredients[item]["title"]] = ingredients[item]
        sort.append(ingredients[item]["title"])
    sort.sort()
    #var id = 0
    for entry in sort:
        #alphabetical[entry].id = id
        sorted_dict[alphabetical[entry]["id"]] = alphabetical[entry]
        #id += 1
    ingredients = sorted_dict


func sort_recipes():
    var alphabetical:Dictionary
    var sorted_dict:Dictionary
    var sort:Array
    for item in recipes.keys():
        alphabetical[recipes[item]["title"]] = recipes[item]
        sort.append(recipes[item]["title"])
    sort.sort()
    #var id = 0
    for entry in sort:
        #alphabetical[entry].id = id
        sorted_dict[alphabetical[entry]["id"]] = alphabetical[entry]
        #id += 1
    recipes = sorted_dict
        


func load_recipes():
    var file = File.new()
    var err = file.open(home_directory + "/recipes.json", File.READ)
    if err == ERR_FILE_NOT_FOUND:
        print("no recipes found.")
        return
    else:
        var text = file.get_as_text()
        var parsed_text = JSON.parse(text)
        recipes = parsed_text.result
        sort_recipes()

func load_ingredients():
    var file = File.new()
    var err = file.open(home_directory + "/ingredients.json", File.READ)
    if err == ERR_FILE_NOT_FOUND:
        print("no ingredients found.")
        return
    else:
        var text = file.get_as_text()
        var parsed_text = JSON.parse(text)
        ingredients = parsed_text.result
        sort_ingredients()


func save_recipe(recipe:Recipe):
    var id = recipe.id
    var data:Dictionary = {
        "id":id,
        "title":recipe.title,
        "description":recipe.description,
        "time_to_cook":recipe.time_to_cook,
        "ingredients":recipe.ingredients
       }
    var found_dupe = false
    for key in recipes.keys():
        if recipes[key].id == id:
            recipes[key] = data
            found_dupe = true
    if not found_dupe:
        recipes[id] = data
    sort_recipes()
    save()
        

func save_ingredient(ingred:Ingredient):
    var id = ingred.id
    var data:Dictionary = {
        "id":id,
        "title":ingred.title,
        "serving_size":ingred.serving_size,
        "macros":ingred.macros.to_dictionary(),
        "gluten_free":ingred.gluten_free,
        "type":ingred.type
       }
    ingredients[id] = data
    sort_ingredients()
    save()


func save():
    var file = File.new()
    file.open(home_directory + "/recipes.json", File.WRITE)
    file.store_string(to_json(recipes))
    file.close()
    
    file.open(home_directory + "/ingredients.json", File.WRITE)
    file.store_string(to_json(ingredients))
    file.close()


func delete_recipe(id:int):
    for key in recipes.keys():
        if recipes[key].id == id:
            recipes.erase(key)
    save()

func delete_ingredient(id:int):
    for key in ingredients.keys():
        if ingredients[key].id == id:
            ingredients.erase(key)
    save()


func get_new_ingredient_id() -> int:
    var new_id:int = 0
    var ids:Array
    for rec in ingredients.keys():
        ids.append(int(ingredients[rec]["id"]))
    var valid_id = false
    while not valid_id:
        if ids.has(new_id):
            new_id += 1
        else:
            valid_id = true
    return new_id

func get_new_recipe_id() -> int:
    var new_id:int = 0
    var ids:Array
    for rec in recipes.keys():
        ids.append(int(recipes[rec]["id"]))
    var valid_id = false
    while not valid_id:
        if ids.has(new_id):
            new_id += 1
        else:
            valid_id = true
    return new_id
    
