extends Button


signal selected(id)

var title:String setget set_title
var id:int

func set_title(value:String):
    self.text = value
    title = value


func _on_IngredientSelect_pressed():
    emit_signal("selected", id)
