class_name Macro
extends Node

var calories:float
var carbs:float
var protein:float
var fat:float
var fiber:float
var sugar:float

# Vitamins
var biotin:float
var choline:float
var golate:float
var niacin:float
var pantothenic_acid:float
var riboflavin:float
var thiamin:float
var vitamin_a:float
var vitamin_b6:float
var vitamin_b12:float
var vitamin_c:float
var vitamin_d:float
var vitamin_e:float
var vitamin_k:float

# Minerals
var calcium:float
var chloride:float
var chromium:float
var copper:float
var iodine:float
var iron:float
var magnesium:float
var manganese:float
var molybdenum:float
var phosphorus:float
var potassium:float
var selenium:float
var sodium:float
var zinc:float




func get_net_carbs() -> float:
    return carbs-fiber


func to_dictionary() -> Dictionary:
    var data:Dictionary = {
        "calories":calories,
        "carbs":carbs,
        "protein":protein,
        "fat":fat,
        "fiber":fiber,
        "sugar":sugar,
        
        "biotin":biotin,
        "choline":choline,
        "golate":golate,
        "niacin":niacin,
        "pantothenic_acid":pantothenic_acid,
        "riboflavin":riboflavin,
        "thiamin":thiamin,
        "vitamin_a":vitamin_a,
        "vitamin_b6":vitamin_b6,
        "vitamin_b12":vitamin_b12,
        "vitamin_c":vitamin_c,
        "vitamin_d":vitamin_d,
        "vitamin_e":vitamin_e,
        "vitamin_k":vitamin_k,
        
        "calcium":calcium,
        "chloride":chloride,
        "chromium":chromium,
        "copper":copper,
        "iodine":iodine,
        "iron":iron,
        "magnesium":magnesium,
        "manganese":manganese,
        "molybdenum":molybdenum,
        "phosphorus":phosphorus,
        "potassium":potassium,
        "selenium":selenium,
        "sodium":sodium,
        "zinc":zinc,
       }
    return data


func from_dictionary(data:Dictionary):
        calories = data["calories"]
        carbs = data["carbs"]
        protein = data["protein"]
        fat = data["fat"]
        fiber = data["fiber"]
        sugar = data["sugar"]
        
        biotin = data["biotin"]
        choline = data["choline"]
        golate = data["golate"]
        niacin = data["niacin"]
        pantothenic_acid = data["pantothenic_acid"]
        riboflavin = data["riboflavin"]
        thiamin = data["thiamin"]
        vitamin_a = data["vitamin_a"]
        vitamin_b6 = data["vitamin_b6"]
        vitamin_b12 = data["vitamin_b12"]
        vitamin_c = data["vitamin_c"]
        vitamin_d = data["vitamin_d"]
        vitamin_e = data["vitamin_e"]
        vitamin_k = data["vitamin_k"]
        
        calcium = data["calcium"]
        chloride = data["chloride"]
        chromium = data["chromium"]
        copper = data["copper"]
        iodine = data["iodine"]
        iron = data["iron"]
        magnesium = data["magnesium"]
        manganese = data["manganese"]
        molybdenum = data["molybdenum"]
        phosphorus = data["phosphorus"]
        potassium = data["potassium"]
        selenium = data["selenium"]
        sodium = data["sodium"]
        zinc = data["zinc"]
