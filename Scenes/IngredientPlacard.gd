extends HBoxContainer


var id:int
var title:String setget set_title
var quantity:float setget ,get_quantity


func get_quantity():
    return $Quantity.value

func set_title(value:String):
    $Label.text = value


func _on_Button_pressed():
    self.queue_free()
