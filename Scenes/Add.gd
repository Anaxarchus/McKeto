extends VBoxContainer

signal ingredient_saved
var loaded_ingredient = null

func _ready():
    $ScrollContainer/GridContainer/HBoxContainer7/Type.clear()
    for each in Ingredient.types.keys():
        $ScrollContainer/GridContainer/HBoxContainer7/Type.add_item(each)

func clear():
    $Name/Title.text = ""
    $ScrollContainer/GridContainer/HBoxContainer/Calories.value = 0
    $ScrollContainer/GridContainer/HBoxContainer2/Carbs.value = 0
    $ScrollContainer/GridContainer/HBoxContainer3/Proteins.value = 0
    $ScrollContainer/GridContainer/HBoxContainer4/Fats.value = 0
    $ScrollContainer/GridContainer/HBoxContainer5/Fiber.value = 0
    $ScrollContainer/GridContainer/HBoxContainer6/Sugar.value = 0
    $ScrollContainer/GridContainer/GlutenFree.pressed = false
    $ScrollContainer/GridContainer/HBoxContainer7/Type.selected = 9

func load_ingredient(ingredient:Ingredient):
    loaded_ingredient = ingredient
    $Name/Title.text = ingredient.title
    $ScrollContainer/GridContainer/HBoxContainer/Calories.value = ingredient.macros.calories
    $ScrollContainer/GridContainer/HBoxContainer2/Carbs.value = ingredient.macros.carbs
    $ScrollContainer/GridContainer/HBoxContainer3/Proteins.value = ingredient.macros.protein
    $ScrollContainer/GridContainer/HBoxContainer4/Fats.value = ingredient.macros.fat
    $ScrollContainer/GridContainer/HBoxContainer5/Fiber.value = ingredient.macros.fiber
    $ScrollContainer/GridContainer/HBoxContainer6/Sugar.value = ingredient.macros.sugar
    $ScrollContainer/GridContainer/GlutenFree.pressed = ingredient.gluten_free
    $ScrollContainer/GridContainer/HBoxContainer7/Type.selected = ingredient.type

func _on_Save_pressed():
    var ing
    if loaded_ingredient:
        ing = loaded_ingredient
        ing.id = loaded_ingredient.id
    else:
        ing = Ingredient.new()
        ing.id = Data.get_new_ingredient_id()
    if $Name/Title.text.length() == 0:
        return
    ing.title = $Name/Title.text
    ing.gluten_free = $ScrollContainer/GridContainer/GlutenFree.pressed
    ing.type = $ScrollContainer/GridContainer/HBoxContainer7/Type.selected
    var macro = Macro.new()
    macro.calories = $ScrollContainer/GridContainer/HBoxContainer/Calories.value
    macro.carbs = $ScrollContainer/GridContainer/HBoxContainer2/Carbs.value
    macro.protein = $ScrollContainer/GridContainer/HBoxContainer3/Proteins.value
    macro.fat = $ScrollContainer/GridContainer/HBoxContainer4/Fats.value
    macro.fiber = $ScrollContainer/GridContainer/HBoxContainer5/Fiber.value
    macro.sugar = $ScrollContainer/GridContainer/HBoxContainer6/Sugar.value
    ing.macros = macro
    Data.save_ingredient(ing)
    emit_signal("ingredient_saved")
