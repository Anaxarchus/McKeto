extends Control


var recipe_card = preload("res://Scenes/Recipe.tscn")
var recipes:Dictionary setget set_recipes

var filters:Dictionary = {
    "GF":false,
    "KETO":false,
    "VEG":false,
    "PESC":false
   }

signal recipe_selected(recipe)
signal back


# Called when the node enters the scene tree for the first time.
func _ready():
    pass


func update_filter():
    for recipe in $Content/ScrollBody/RecipeContainer.get_children():
        recipe.show()
    for recipe in $Content/ScrollBody/RecipeContainer.get_children():
        if filters.GF:
            if not recipe.tags[Recipe.tags.GLUTEN_FREE]:
                recipe.hide()
        if filters.KETO:
            if not recipe.tags[Recipe.tags.KETOGENIC]:
                recipe.hide()
        if filters.VEG:
            if not recipe.tags[Recipe.tags.VEGETARIAN]:
                recipe.hide()
        if filters.PESC:
            if not recipe.tags[Recipe.tags.PESCATARIAN]:
                recipe.hide()


func set_recipes(value:Dictionary):
    for child in $Content/ScrollBody/RecipeContainer.get_children():
        $Content/ScrollBody/RecipeContainer.remove_child(child)
        child.queue_free()
    recipes = value
    for id in value.keys():
        var card = recipe_card.instance()
        var recipe_data = value[id]
        var recipe = Recipe.new()
        recipe.title = recipe_data['title']
        recipe.time_to_cook = recipe_data["time_to_cook"]
        recipe.description = recipe_data["description"]
        recipe.id = recipe_data["id"]
        var ingreds:Array
        for ingred in recipe_data["ingredients"]:
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
        recipe.ingredients = ingreds
        card.recipe = recipe
        $Content/ScrollBody/RecipeContainer.add_child(card)
        card.connect("recipe_selected", self, "_on_recipe_add_to_cart")
        card.connect("recipe_edit", self, "_on_recipe_edit")
        Recipes.recipes.append(recipe)


func _on_recipe_add_to_cart(node):
    emit_signal("recipe_selected", node.recipe)


func _on_recipe_edit(recipe:Recipe):
    $New/NewRecipe.mode = $New/NewRecipe.modes.EDIT
    $New/NewRecipe.load_recipe(recipe)
    $New.popup_centered()


func _on_NewRecipe_pressed():
    $New/NewRecipe.mode = $New/NewRecipe.modes.NEW
    $New.popup_centered()


func _on_NewRecipe_creation_canceled():
    $New.hide()


func _on_NewRecipe_recipe_created():
    self.recipes = Data.recipes
    $New.hide()


func _on_Back_pressed():
    emit_signal("back")


func _on_NewRecipe_recipe_deleted():
    $New.hide()
    self.recipes = Data.recipes


func _on_GF_toggled(button_pressed):
    filters.GF = button_pressed
    update_filter()


func _on_Keto_toggled(button_pressed):
    filters.KETO = button_pressed
    update_filter()


func _on_Veg_toggled(button_pressed):
    filters.VEG = button_pressed
    update_filter()


func _on_Pesc_toggled(button_pressed):
    filters.PESC = button_pressed
    update_filter()
