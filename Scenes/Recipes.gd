extends Control


var recipe_card = preload("res://Scenes/Recipe.tscn")
var recipes:Dictionary setget set_recipes

signal recipe_selected(recipe)
signal back


# Called when the node enters the scene tree for the first time.
func _ready():
    pass


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
            var mac = Macro.new()
            mac.from_dictionary(ing_data["macros"])
            ing.macros = mac
            ingreds.append(ing)
        recipe.ingredients = ingreds
        card.recipe = recipe
        $Content/ScrollBody/RecipeContainer.add_child(card)
        card.connect("recipe_selected", self, "_on_recipe_add_to_cart")
        Recipes.recipes.append(recipe)


func _on_recipe_add_to_cart(node):
    emit_signal("recipe_selected", node.recipe)


func _on_NewRecipe_pressed():
    $New.popup_centered()


func _on_NewRecipe_creation_canceled():
    $New.hide()


func _on_NewRecipe_recipe_created():
    self.recipes = Data.recipes
    $New.hide()


func _on_Back_pressed():
    emit_signal("back")
