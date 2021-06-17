extends VBoxContainer

signal ingredient_saved


func _on_Save_pressed():
    var ing = Ingredient.new()
    if $Name/Title.text.length() == 0:
        return
    ing.title = $Name/Title.text
    ing.id = Data.get_new_ingredient_id()
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
