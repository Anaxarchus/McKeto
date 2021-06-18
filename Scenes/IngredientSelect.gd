extends HBoxContainer


signal selected(id)
signal edit(id)

var title:String setget set_title
var id:int

func set_title(value:String):
    $IngredientSelect.text = value
    title = value


func _on_IngredientSelect_pressed():
    emit_signal("selected", id)


func _on_Edit_pressed():
    emit_signal("edit", id)
