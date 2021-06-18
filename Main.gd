extends Control


enum meals {BREAKFAST, LUNCH, DINNER, SNACKS}

var selecting_meal:bool = false
var selecting:int = meals.BREAKFAST
var profile:Profile
var profile_loaded:bool = false

var creating_profile:bool = false
var selected_profile_id:int


# Called when the node enters the scene tree for the first time.
func _ready():
    Data.load_ingredients()
    Data.load_recipes()
    $Recipes.recipes = Data.recipes


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass

func list_profiles():
    print("listing profiles")
    var prof = Profile.new()
    var profiles:Dictionary = prof.get_all_profiles()
    if profiles.keys().size()>0:
        $LogIn/Panel/VBoxContainer/ItemList.clear()
        for p in profiles.keys():
            $LogIn/Panel/VBoxContainer/ItemList.add_item(profiles[p].name)


func _on_Recipes_pressed():
    $Menu.hide()
    $Recipes.show()


func _on_Recipes_recipe_selected(recipe):
    if selecting_meal:
        if selecting == meals.BREAKFAST:
            $MealPlan.add_meal_to_breakfast(recipe)
            $MealPlan.get_day().breakfast.append(recipe.id)
            if profile_loaded:
                profile.data[$MealPlan.days.keys()[$MealPlan.selected_day]].breakfast = $MealPlan.get_day().breakfast
        elif selecting == meals.LUNCH:
            $MealPlan.add_meal_to_lunch(recipe)
            $MealPlan.get_day().lunch.append(recipe.id)
            if profile_loaded:
                profile.data[$MealPlan.days.keys()[$MealPlan.selected_day]].lunch = $MealPlan.get_day().lunch
        elif selecting == meals.DINNER:
            $MealPlan.add_meal_to_dinner(recipe)
            $MealPlan.get_day().dinner.append(recipe.id)
            if profile_loaded:
                profile.data[$MealPlan.days.keys()[$MealPlan.selected_day]].dinner = $MealPlan.get_day().dinner
        elif selecting == meals.SNACKS:
            $MealPlan.add_meal_to_snacks(recipe)
            $MealPlan.get_day().snacks.append(recipe.id)
            if profile_loaded:
                profile.data[$MealPlan.days.keys()[$MealPlan.selected_day]].snacks = $MealPlan.get_day().snacks
        $MealPlan.show()
        $Recipes.hide()
        if profile_loaded:
            profile.save_profile()
        selecting_meal = false
        


func _on_MealPlan_select_recipe(meal_type):
    selecting_meal = true
    selecting = meal_type
    $MealPlan.hide()
    $Recipes.show()


func _on_MyMenu_pressed():
    $Menu.hide()
    $MealPlan.show()
    if profile_loaded:
        pass


func _on_Recipes_back():
    if selecting_meal:
        selecting_meal = false
        $MealPlan.show()
        $Recipes.hide()
    else:
        $Recipes.hide()
        $Menu.show()
        
func _on_MealPlan_back():
    $MealPlan.hide()
    $Menu.show()


func _on_Exit_pressed():
    get_tree().quit()


func _on_Create_pressed():
    if not creating_profile:
        $LogIn/Panel/HBoxContainer/Create.text = "Create"
        $LogIn/Panel/HBoxContainer/ProfileEntry.show()
        creating_profile = true
    else:
        $LogIn/Panel/HBoxContainer/Create.text = "New"
        creating_profile = false
        profile = Profile.new()
        profile.new_profile($LogIn/Panel/HBoxContainer/ProfileEntry/LineEdit.text)
        $LogIn/Panel/HBoxContainer/ProfileEntry.hide()
        profile_loaded = true
        $Menu/Line3.hide()
        $LogIn.hide()


func _on_Load_pressed():
    profile = Profile.new()
    profile.load_profile(selected_profile_id)
    profile_loaded = true
    $MealPlan.load_from_dict(profile.data)
    $Menu/Line3.hide()
    $LogIn.hide()


func _on_Guest_pressed():
    $LogIn.hide()


func _on_LogIn_pressed():
    $LogIn.show()
    list_profiles()


func _on_ItemList_item_selected(index):
    selected_profile_id = index
    $LogIn/Panel/HBoxContainer/Load.disabled = false


func _on_ItemList_nothing_selected():
    $LogIn/Panel/HBoxContainer/Load.disabled = true


func _on_MealPlan_day_cleared(day):
    profile.data[day] = {
        "breakfast":[],
        "lunch":[],
        "dinner":[],
        "snacks":[],
       }
    profile.save_profile()
    $MealPlan.load_from_dict(profile.data)
