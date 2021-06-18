class_name Recipe
extends Node

enum tags {GLUTEN_FREE, KETOGENIC, VEGETARIAN, PESCATARIAN}

var title:String
var id:int
var description:String
var thumbnail:ImageTexture
var time_to_cook:int
var ingredients:Array

var sum_calories:float setget ,get_sum_calories
var sum_carbs:float setget ,get_sum_carbs
var sum_protein:float setget ,get_sum_protein
var sum_fat:float setget ,get_sum_fat
var sum_fiber:float setget ,get_sum_fiber
var sum_sugar:float setget ,get_sum_sugar


func get_tags() -> Array:
    var gf = true
    var veg = true
    var pesc = true
    var keto = true
    for ing in ingredients:
        if ing.type == Ingredient.types.BEEF or ing.type == Ingredient.types.CHICKEN or ing.type == Ingredient.types.PORK:
            veg = false
            pesc = false
        elif ing.type == Ingredient.types.FISH:
            veg = false
        if ing.gluten_free == false:
            print(ing.title, " is not gluten free")
            gf = false
    if get_net_carbs()/100 > 15.0:
        keto = false
    return [gf,keto,veg,pesc]


func get_net_carbs():
    var sum:float
    for ing in ingredients:
        sum += (ing.macros.carbs - ing.macros.fiber)*ing.quantity
    return sum

func get_sum_calories():
    var sum:float
    for ing in ingredients:
        sum += ing.macros.calories*ing.quantity
    return sum

func get_sum_carbs():
    var sum:float
    for ing in ingredients:
        sum += ing.macros.carbs*ing.quantity
    return sum

func get_sum_protein():
    var sum:float
    for ing in ingredients:
        sum += ing.macros.protein*ing.quantity
    return sum

func get_sum_fat():
    var sum:float
    for ing in ingredients:
        sum += ing.macros.fat*ing.quantity
    return sum

func get_sum_fiber():
    var sum:float
    for ing in ingredients:
        sum += ing.macros.fiber*ing.quantity
    return sum

func get_sum_sugar():
    var sum:float
    for ing in ingredients:
        sum += ing.macros.sugar*ing.quantity
    return sum

func compile(recipe:Dictionary):
    print("compiling")
    title = recipe['title']
    time_to_cook = recipe["time_to_cook"]
    description = recipe["description"]
    var ingreds:Array
    for ingred in recipe["ingredients"]:
        var ing = Ingredient.new()
        var ing_data = Data.get_ingredient_by_id(ingred[0])
        ing.title = ing_data["title"]
        ing.id = ing_data["id"]
        ing.quantity = ingred[1]
        ing.gluten_free = ing_data["gluten_free"]
        ing.type = ing_data["type"]
        var mac = Macro.new()
        mac.from_dictionary(ing_data["macros"])
        ing.macros = mac
        ingreds.append(ing)
    ingredients = ingreds
