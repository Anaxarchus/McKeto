extends Popup


var ingredient_placard = preload("res://Scenes/IngredientSelect.tscn")
var ingredients:Dictionary
signal ingredient_selected(id)


func show_ingredients():
    clear_list()
    for ing in Data.ingredients.keys():
        var ing_plac = ingredient_placard.instance()
        ing_plac.connect("selected", self, "_on_ingredient_selected")
        ing_plac.id = Data.ingredients[ing]["id"]
        ing_plac.title = Data.ingredients[ing]["title"]
        $Search/ScrollContainer/ings.add_child(ing_plac)


func clear_list():
    for child in $Search/ScrollContainer/ings.get_children():
        $Search/ScrollContainer/ings.remove_child(child)
        child.queue_free()


func _on_SearchBar_search(value:String):
    if value.length() == 0:
        show_ingredients()
        return
    else:
        clear_list()
        for ing in Data.ingredients.keys():
            if Data.ingredients[ing]["title"].to_lower().begins_with(value.to_lower()):
                var ing_plac = ingredient_placard.instance()
                ing_plac.connect("selected", self, "_on_ingredient_selected")
                ing_plac.id = Data.ingredients[ing]["id"]
                ing_plac.title = Data.ingredients[ing]["title"]
                $Search/ScrollContainer/ings.add_child(ing_plac)


func _on_ingredient_selected(id:int):
    emit_signal("ingredient_selected", id)
    self.hide()
    $Search/SearchBar.clear()
    clear_list()


func _on_Button_pressed():
    self.hide()
    $Search/SearchBar.clear()
    clear_list()
    


func _on_AddIng_pressed():
    $Add.show()
    $Search.hide()


func _on_Add_Cancel_pressed():
    $Add.hide()
    $Search.show()


func _on_Add_ingredient_saved():
    $Add.hide()
    $Search.show()
