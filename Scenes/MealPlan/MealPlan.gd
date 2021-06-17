extends Control


enum meals {BREAKFAST, LUNCH, DINNER, SNACKS}
enum days {SUNDAY, MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY}

var recipe_card = preload("res://Scenes/Recipe.tscn")

class Day:
    var breakfast:Array
    var lunch:Array
    var dinner:Array
    var snacks:Array
    
    func is_empty():
        if breakfast.size()==0 and lunch.size()==0 and dinner.size()==0 and snacks.size()==0:
            return true
        else:
            return false

onready var sunday:Day = Day.new()
onready var monday:Day = Day.new()
onready var tuesday:Day = Day.new()
onready var wednesday:Day = Day.new()
onready var thursday:Day = Day.new()
onready var friday:Day = Day.new()
onready var saturday:Day = Day.new()

var selected_day:int = 0 setget set_day

signal select_recipe(meal_type)
signal back
signal day_cleared(day)

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.
    

func load_from_dict(data:Dictionary):
    sunday.breakfast = data.SUNDAY.breakfast
    sunday.lunch = data.SUNDAY.lunch
    sunday.dinner = data.SUNDAY.dinner
    sunday.snacks = data.SUNDAY.snacks
    
    monday.breakfast = data.MONDAY.breakfast
    monday.lunch = data.MONDAY.lunch
    monday.dinner = data.MONDAY.dinner
    monday.snacks = data.MONDAY.snacks
    
    tuesday.breakfast = data.TUESDAY.breakfast
    tuesday.lunch = data.TUESDAY.lunch
    tuesday.dinner = data.TUESDAY.dinner
    tuesday.snacks = data.TUESDAY.snacks
    
    wednesday.breakfast = data.WEDNESDAY.breakfast
    wednesday.lunch = data.WEDNESDAY.lunch
    wednesday.dinner = data.WEDNESDAY.dinner
    wednesday.snacks = data.WEDNESDAY.snacks
    
    thursday.breakfast = data.THURSDAY.breakfast
    thursday.lunch = data.THURSDAY.lunch
    thursday.dinner = data.THURSDAY.dinner
    thursday.snacks = data.THURSDAY.snacks
    
    friday.breakfast = data.FRIDAY.breakfast
    friday.lunch = data.FRIDAY.lunch
    friday.dinner = data.FRIDAY.dinner
    friday.snacks = data.FRIDAY.snacks
    
    saturday.breakfast = data.SATURDAY.breakfast
    saturday.lunch = data.SATURDAY.lunch
    saturday.dinner = data.SATURDAY.dinner
    saturday.snacks = data.SATURDAY.snacks
    
    load_day(selected_day)


func load_day(value=selected_day):
    clear_items()
    var day:Day = get_day()
    for item in day.breakfast:
        var rec = Recipes.get_recipe_by_id(item)
        add_meal_to_breakfast(rec)
    for item in day.lunch:
        var rec = Recipes.get_recipe_by_id(item)
        add_meal_to_lunch(rec)
    for item in day.dinner:
        var rec = Recipes.get_recipe_by_id(item)
        add_meal_to_dinner(rec)
    for item in day.snacks:
        var rec = Recipes.get_recipe_by_id(item)
        add_meal_to_snacks(rec)
    update_total_nutrition()


func clear_items():
    for child in $VBoxContainer/MealScroll/MealContainer/FoodBody/Meals/Breakfast/BreakfastItems/Items.get_children():
        child.get_parent().remove_child(child)
        child.queue_free()
    for child in $VBoxContainer/MealScroll/MealContainer/FoodBody/Meals/Lunch/LunchItems/Items.get_children():
        child.get_parent().remove_child(child)
        child.queue_free()
    for child in $VBoxContainer/MealScroll/MealContainer/FoodBody/Meals/Dinner/DinnerItems/Items.get_children():
        child.get_parent().remove_child(child)
        child.queue_free()
    for child in $VBoxContainer/MealScroll/MealContainer/FoodBody/Snacks/SnackItems/Items.get_children():
        child.get_parent().remove_child(child)
        child.queue_free()


func add_meal_to_breakfast(recipe:Recipe):
    var rec = recipe_card.instance()
    $VBoxContainer/MealScroll/MealContainer/FoodBody/Meals/Breakfast/BreakfastItems/Items.add_child(rec)
    rec.recipe = recipe
    rec.category = meals.BREAKFAST
    rec.get_node("HBoxContainer/AddToCart").text = "x"
    rec.get_node("HBoxContainer/AddToCart").show()
    rec.get_node("HBoxContainer/Edit").hide()
    rec.connect("recipe_selected", self, "_on_remove_from_cart")
    update_total_nutrition()

func add_meal_to_lunch(recipe:Recipe):
    var rec = recipe_card.instance()
    $VBoxContainer/MealScroll/MealContainer/FoodBody/Meals/Lunch/LunchItems/Items.add_child(rec)
    rec.recipe = recipe
    rec.category = meals.LUNCH
    rec.get_node("HBoxContainer/AddToCart").text = "x"
    rec.get_node("HBoxContainer/AddToCart").show()
    rec.get_node("HBoxContainer/Edit").hide()
    rec.connect("recipe_selected", self, "_on_remove_from_cart")
    update_total_nutrition()

func add_meal_to_dinner(recipe:Recipe):
    var rec = recipe_card.instance()
    $VBoxContainer/MealScroll/MealContainer/FoodBody/Meals/Dinner/DinnerItems/Items.add_child(rec)
    rec.recipe = recipe
    rec.category = meals.DINNER
    rec.get_node("HBoxContainer/AddToCart").text = "x"
    rec.get_node("HBoxContainer/AddToCart").show()
    rec.get_node("HBoxContainer/Edit").hide()
    rec.connect("recipe_selected", self, "_on_remove_from_cart")
    update_total_nutrition()

func add_meal_to_snacks(recipe:Recipe):
    var rec = recipe_card.instance()
    $VBoxContainer/MealScroll/MealContainer/FoodBody/Snacks/SnackItems/Items.add_child(rec)
    rec.recipe = recipe
    rec.category = meals.SNACKS
    rec.get_node("HBoxContainer/AddToCart").text = "x"
    rec.get_node("HBoxContainer/AddToCart").show()
    rec.get_node("HBoxContainer/Edit").hide()
    rec.connect("recipe_selected", self, "_on_remove_from_cart")
    update_total_nutrition()

func update_total_nutrition():
    var cal:float
    var carb:float
    var protein:float
    var fat:float
    var sugar:float
    var fiber:float
    
    for node in $VBoxContainer/MealScroll/MealContainer/FoodBody/Meals/Breakfast/BreakfastItems/Items.get_children():
        cal += node.recipe.get_sum_calories()
        carb += node.recipe.get_sum_carbs()
        protein += node.recipe.get_sum_protein()
        fat += node.recipe.get_sum_fat()
        sugar += node.recipe.get_sum_sugar()
        fiber += node.recipe.get_sum_fiber()
    
    for node in $VBoxContainer/MealScroll/MealContainer/FoodBody/Meals/Lunch/LunchItems/Items.get_children():
        cal += node.recipe.get_sum_calories()
        carb += node.recipe.get_sum_carbs()
        protein += node.recipe.get_sum_protein()
        fat += node.recipe.get_sum_fat()
        sugar += node.recipe.get_sum_sugar()
        fiber += node.recipe.get_sum_fiber()
    
    for node in $VBoxContainer/MealScroll/MealContainer/FoodBody/Meals/Dinner/DinnerItems/Items.get_children():
        cal += node.recipe.get_sum_calories()
        carb += node.recipe.get_sum_carbs()
        protein += node.recipe.get_sum_protein()
        fat += node.recipe.get_sum_fat()
        sugar += node.recipe.get_sum_sugar()
        fiber += node.recipe.get_sum_fiber()
    
    for node in $VBoxContainer/MealScroll/MealContainer/FoodBody/Snacks/SnackItems/Items.get_children():
        cal += node.recipe.get_sum_calories()
        carb += node.recipe.get_sum_carbs()
        protein += node.recipe.get_sum_protein()
        fat += node.recipe.get_sum_fat()
        sugar += node.recipe.get_sum_sugar()
        fiber += node.recipe.get_sum_fiber()
    
    $VBoxContainer/MealScroll/MealContainer/FoodBody/Snacks/Nutrition/Calories.text = "Calories: " + String(cal/100)
    $VBoxContainer/MealScroll/MealContainer/FoodBody/Snacks/Nutrition/Carbs.text = "Carbs: " + String(carb/100) + "g"
    $VBoxContainer/MealScroll/MealContainer/FoodBody/Snacks/Nutrition/Sugar.text = "Sugar: " + String(sugar/100) + "g"
    $VBoxContainer/MealScroll/MealContainer/FoodBody/Snacks/Nutrition/Fats.text = "Fats: " + String(fat/100) + "g"
    $VBoxContainer/MealScroll/MealContainer/FoodBody/Snacks/Nutrition/Protein.text = "Protein: " + String(protein/100) + "g"
    $VBoxContainer/MealScroll/MealContainer/FoodBody/Snacks/Nutrition/Fiber.text = "Fiber: " + String(fiber/100) + "g"


func get_total_nutrition(meals:Array):
    var mac = Macro.new()
    
    for rec in meals:
        var recipe:Recipe = Recipes.get_recipe_by_id(rec)
        mac.calories += recipe.get_sum_calories()/100
        mac.carbs += recipe.get_sum_carbs()/100
        mac.fat += recipe.get_sum_fat()/100
        mac.fiber += recipe.get_sum_fiber()/100
        mac.protein += recipe.get_sum_protein()/100
        mac.sugar += recipe.get_sum_sugar()/100
    
    return mac


func get_day():
    if selected_day == days.SUNDAY:
        return sunday
    elif selected_day == days.MONDAY:
        return monday
    elif selected_day == days.TUESDAY:
        return tuesday
    elif selected_day == days.WEDNESDAY:
        return wednesday
    elif selected_day == days.THURSDAY:
        return thursday
    elif selected_day == days.FRIDAY:
        return friday
    elif selected_day == days.SATURDAY:
        return saturday
    else:
        print("error in getting day")
    

func set_day(value:int):
    selected_day = value
    if value == days.SUNDAY:
        $VBoxContainer/MealScroll/MealContainer/StatBar/Day.text = "Viewing: Sunday"
    elif value == days.MONDAY:
        $VBoxContainer/MealScroll/MealContainer/StatBar/Day.text = "Viewing: Monday"
    elif value == days.TUESDAY:
        $VBoxContainer/MealScroll/MealContainer/StatBar/Day.text = "Viewing: Tuesday"
    elif value == days.WEDNESDAY:
        $VBoxContainer/MealScroll/MealContainer/StatBar/Day.text = "Viewing: Wednesday"
    elif value == days.THURSDAY:
        $VBoxContainer/MealScroll/MealContainer/StatBar/Day.text = "Viewing: Thursday"
    elif value == days.FRIDAY:
        $VBoxContainer/MealScroll/MealContainer/StatBar/Day.text = "Viewing: Friday"
    elif value == days.SATURDAY:
        $VBoxContainer/MealScroll/MealContainer/StatBar/Day.text = "Viewing: Saturday"
    load_day(value)


func generate_shopping_list():
    var ing:Dictionary
    for day in [sunday, monday, tuesday, wednesday, thursday, friday, saturday]:
        for meal in [day.breakfast, day.lunch, day.dinner, day.snacks]:
            for recipe in meal:
                for ingredient in Recipes.get_recipe_by_id(recipe).ingredients:
                    if ing.keys().has(ingredient.id):
                        ing[ingredient.id] += ingredient.quantity
                    else:
                        ing[ingredient.id] = ingredient.quantity
    print(ing)
    
    $Shopping/Panel/TextEdit.text = "Shopping List:\n\n"
    for item in ing.keys():
        var ingred = Data.get_ingredient_by_id(item)
        var string = ingred["title"] + ": " + String(ing[item]) + "g"
        $Shopping/Panel/TextEdit.text += string + "\n"


func generate_meal_report():
    $Shopping/Panel/TextEdit.text = "Weekly Meal Report\nDate:\n\n"
    
    if not sunday.is_empty():
        $Shopping/Panel/TextEdit.text += "\n\nSunday\n"
        var meals = []
        for meal in ["breakfast", "lunch", "dinner", "snacks"]:
            if sunday[meal].size()>0:
                $Shopping/Panel/TextEdit.text += "\n    " + meal + ":\n"
                for each in sunday[meal]:
                    meals.append(each)
                    var rec = Data.get_recipe_by_id(each)
                    $Shopping/Panel/TextEdit.text += "        " + rec["title"] + "\n"
                    for ing in rec.ingredients:
                        var ingredient = Data.get_ingredient_by_id(ing[0])
                        $Shopping/Panel/TextEdit.text += "            " + ingredient["title"] + ": " + String(ing[1]) + "g\n"
        var mac = get_total_nutrition(meals)    
        $Shopping/Panel/TextEdit.text += "\n    Nutrition:\n"
        $Shopping/Panel/TextEdit.text += "        Calories: " + String(mac.calories) + "\n"
        $Shopping/Panel/TextEdit.text += "        Carbs: " + String(mac.carbs) + "\n"
        $Shopping/Panel/TextEdit.text += "        Fiber: " + String(mac.fiber) + "\n"
        $Shopping/Panel/TextEdit.text += "        Fat: " + String(mac.fat) + "\n"
        $Shopping/Panel/TextEdit.text += "        Protein: " + String(mac.protein) + "\n"
        $Shopping/Panel/TextEdit.text += "        Sugar: " + String(mac.sugar) + "\n"
    
    if not monday.is_empty():
        $Shopping/Panel/TextEdit.text += "\n\nMonday\n"
        var meals = []
        for meal in ["breakfast", "lunch", "dinner", "snacks"]:
            $Shopping/Panel/TextEdit.text += "\n    " + meal + ":\n"
            for each in monday[meal]:
                meals.append(each)
                var rec = Data.get_recipe_by_id(each)
                $Shopping/Panel/TextEdit.text += "        " + rec["title"] + "\n"
                for ing in rec.ingredients:
                    var ingredient = Data.get_ingredient_by_id(ing[0])
                    $Shopping/Panel/TextEdit.text += "            " + ingredient["title"] + ": " + String(ing[1]) + "g\n"
        var mac = get_total_nutrition(meals)    
        $Shopping/Panel/TextEdit.text += "\n    Nutrition:\n"
        $Shopping/Panel/TextEdit.text += "        Calories: " + String(mac.calories) + "\n"
        $Shopping/Panel/TextEdit.text += "        Carbs: " + String(mac.carbs) + "\n"
        $Shopping/Panel/TextEdit.text += "        Fiber: " + String(mac.fiber) + "\n"
        $Shopping/Panel/TextEdit.text += "        Fat: " + String(mac.fat) + "\n"
        $Shopping/Panel/TextEdit.text += "        Protein: " + String(mac.protein) + "\n"
        $Shopping/Panel/TextEdit.text += "        Sugar: " + String(mac.sugar) + "\n"
    
    if not tuesday.is_empty():
        $Shopping/Panel/TextEdit.text += "\n\nTuesday\n"
        var meals = []
        for meal in ["breakfast", "lunch", "dinner", "snacks"]:
            $Shopping/Panel/TextEdit.text += "\n    " + meal + ":\n"
            for each in tuesday[meal]:
                meals.append(each)
                var rec = Data.get_recipe_by_id(each)
                $Shopping/Panel/TextEdit.text += "        " + rec["title"] + "\n"
                for ing in rec.ingredients:
                    var ingredient = Data.get_ingredient_by_id(ing[0])
                    $Shopping/Panel/TextEdit.text += "            " + ingredient["title"] + ": " + String(ing[1]) + "g\n"
        var mac = get_total_nutrition(meals)    
        $Shopping/Panel/TextEdit.text += "\n    Nutrition:\n"
        $Shopping/Panel/TextEdit.text += "        Calories: " + String(mac.calories) + "\n"
        $Shopping/Panel/TextEdit.text += "        Carbs: " + String(mac.carbs) + "\n"
        $Shopping/Panel/TextEdit.text += "        Fiber: " + String(mac.fiber) + "\n"
        $Shopping/Panel/TextEdit.text += "        Fat: " + String(mac.fat) + "\n"
        $Shopping/Panel/TextEdit.text += "        Protein: " + String(mac.protein) + "\n"
        $Shopping/Panel/TextEdit.text += "        Sugar: " + String(mac.sugar) + "\n"
 
    if not wednesday.is_empty():   
        $Shopping/Panel/TextEdit.text += "\n\nWednesday\n"
        var meals = []
        for meal in ["breakfast", "lunch", "dinner", "snacks"]:
            $Shopping/Panel/TextEdit.text += "\n    " + meal + ":\n"
            for each in wednesday[meal]:
                meals.append(each)
                var rec = Data.get_recipe_by_id(each)
                $Shopping/Panel/TextEdit.text += "        " + rec["title"] + "\n"
                for ing in rec.ingredients:
                    var ingredient = Data.get_ingredient_by_id(ing[0])
                    $Shopping/Panel/TextEdit.text += "            " + ingredient["title"] + ": " + String(ing[1]) + "g\n"
        var mac = get_total_nutrition(meals)    
        $Shopping/Panel/TextEdit.text += "\n    Nutrition:\n"
        $Shopping/Panel/TextEdit.text += "        Calories: " + String(mac.calories) + "\n"
        $Shopping/Panel/TextEdit.text += "        Carbs: " + String(mac.carbs) + "\n"
        $Shopping/Panel/TextEdit.text += "        Fiber: " + String(mac.fiber) + "\n"
        $Shopping/Panel/TextEdit.text += "        Fat: " + String(mac.fat) + "\n"
        $Shopping/Panel/TextEdit.text += "        Protein: " + String(mac.protein) + "\n"
        $Shopping/Panel/TextEdit.text += "        Sugar: " + String(mac.sugar) + "\n"
    
    if not thursday.is_empty():
        $Shopping/Panel/TextEdit.text += "\n\nThursday\n"
        var meals = []
        for meal in ["breakfast", "lunch", "dinner", "snacks"]:
            $Shopping/Panel/TextEdit.text += "\n    " + meal + ":\n"
            for each in thursday[meal]:
                meals.append(each)
                var rec = Data.get_recipe_by_id(each)
                $Shopping/Panel/TextEdit.text += "        " + rec["title"] + "\n"
                for ing in rec.ingredients:
                    var ingredient = Data.get_ingredient_by_id(ing[0])
                    $Shopping/Panel/TextEdit.text += "            " + ingredient["title"] + ": " + String(ing[1]) + "g\n\n"
        var mac = get_total_nutrition(meals)    
        $Shopping/Panel/TextEdit.text += "\n    Nutrition:\n"
        $Shopping/Panel/TextEdit.text += "        Calories: " + String(mac.calories) + "\n"
        $Shopping/Panel/TextEdit.text += "        Carbs: " + String(mac.carbs) + "\n"
        $Shopping/Panel/TextEdit.text += "        Fiber: " + String(mac.fiber) + "\n"
        $Shopping/Panel/TextEdit.text += "        Fat: " + String(mac.fat) + "\n"
        $Shopping/Panel/TextEdit.text += "        Protein: " + String(mac.protein) + "\n"
        $Shopping/Panel/TextEdit.text += "        Sugar: " + String(mac.sugar) + "\n"
    
    if not friday.is_empty():
        $Shopping/Panel/TextEdit.text += "\n\nFriday\n"
        var meals = []
        for meal in ["breakfast", "lunch", "dinner", "snacks"]:
            $Shopping/Panel/TextEdit.text += "\n    " + meal + ":\n"
            for each in friday[meal]:
                meals.append(each)
                var rec = Data.get_recipe_by_id(each)
                $Shopping/Panel/TextEdit.text += "        " + rec["title"] + "\n"
                for ing in rec.ingredients:
                    var ingredient = Data.get_ingredient_by_id(ing[0])
                    $Shopping/Panel/TextEdit.text += "            " + ingredient["title"] + ": " + String(ing[1]) + "g\n\n"
        var mac = get_total_nutrition(meals)    
        $Shopping/Panel/TextEdit.text += "\n    Nutrition:\n"
        $Shopping/Panel/TextEdit.text += "        Calories: " + String(mac.calories) + "\n"
        $Shopping/Panel/TextEdit.text += "        Carbs: " + String(mac.carbs) + "\n"
        $Shopping/Panel/TextEdit.text += "        Fiber: " + String(mac.fiber) + "\n"
        $Shopping/Panel/TextEdit.text += "        Fat: " + String(mac.fat) + "\n"
        $Shopping/Panel/TextEdit.text += "        Protein: " + String(mac.protein) + "\n"
        $Shopping/Panel/TextEdit.text += "        Sugar: " + String(mac.sugar) + "\n"
    
    if not saturday.is_empty():
        $Shopping/Panel/TextEdit.text += "\n\nSaturday\n"
        var meals = []
        for meal in ["breakfast", "lunch", "dinner", "snacks"]:
            $Shopping/Panel/TextEdit.text += "\n    " + meal + ":\n"
            for each in saturday[meal]:
                meals.append(each)
                var rec = Data.get_recipe_by_id(each)
                $Shopping/Panel/TextEdit.text += "        " + rec["title"] + "\n"
                for ing in rec.ingredients:
                    var ingredient = Data.get_ingredient_by_id(ing[0])
                    $Shopping/Panel/TextEdit.text += "            " + ingredient["title"] + ": " + String(ing[1]) + "g\n\n"
        var mac = get_total_nutrition(meals)    
        $Shopping/Panel/TextEdit.text += "\n    Nutrition:\n"
        $Shopping/Panel/TextEdit.text += "        Calories: " + String(mac.calories) + "\n"
        $Shopping/Panel/TextEdit.text += "        Carbs: " + String(mac.carbs) + "\n"
        $Shopping/Panel/TextEdit.text += "        Fiber: " + String(mac.fiber) + "\n"
        $Shopping/Panel/TextEdit.text += "        Fat: " + String(mac.fat) + "\n"
        $Shopping/Panel/TextEdit.text += "        Protein: " + String(mac.protein) + "\n"
        $Shopping/Panel/TextEdit.text += "        Sugar: " + String(mac.sugar) + "\n"


func _on_remove_from_cart(node):
    if node.category == meals.BREAKFAST:
        get_day().breakfast.erase(node.recipe.id)
    elif node.category == meals.LUNCH:
        get_day().lunch.erase(node.recipe.id)
    elif node.category == meals.DINNER:
        get_day().dinner.erase(node.recipe.id)
    elif node.category == meals.SNACKS:
        get_day().snacks.erase(node.recipe.id)
    node.get_parent().remove_child(node)
    node.queue_free()
    update_total_nutrition()


func _on_AddBreakfast_pressed():
    emit_signal("select_recipe", meals.BREAKFAST)


func _on_AddLunch_pressed():
    emit_signal("select_recipe", meals.LUNCH)


func _on_AddDinner_pressed():
    emit_signal("select_recipe", meals.DINNER)


func _on_AddSnack_pressed():
    emit_signal("select_recipe", meals.SNACKS)


func _on_Back_pressed():
    emit_signal("back")


func _on_Sunday_pressed():
    set_day(days.SUNDAY)


func _on_Monday_pressed():
    set_day(days.MONDAY)


func _on_Tuesday_pressed():
    set_day(days.TUESDAY)


func _on_Wednesday_pressed():
    set_day(days.WEDNESDAY)


func _on_Thrusday_pressed():
    set_day(days.THURSDAY)


func _on_Friday_pressed():
    set_day(days.FRIDAY)


func _on_Saturday_pressed():
    set_day(days.SATURDAY)


func _on_ShoppingCose_pressed():
    $Shopping.hide()
    $Shopping/Panel/TextEdit.text = ""


func _on_ShoppingList_pressed():
    $Shopping.show()
    generate_shopping_list()


func _on_MealReport_pressed():
    $Shopping.show()
    generate_meal_report()


func _on_PlanClear_pressed():
    if selected_day == days.SUNDAY:
        sunday = Day.new()
    elif selected_day == days.MONDAY:
        monday = Day.new()
    elif selected_day == days.TUESDAY:
        tuesday = Day.new()
    elif selected_day == days.WEDNESDAY:
        wednesday = Day.new()
    elif selected_day == days.THURSDAY:
        thursday = Day.new()
    elif selected_day == days.FRIDAY:
        friday = Day.new()
    elif selected_day == days.SATURDAY:
        saturday = Day.new()
    emit_signal("day_cleared", days.keys()[selected_day])
