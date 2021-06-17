extends HBoxContainer


var id:int
var title:String setget set_title
var quantity:float setget set_quantity,get_quantity


func set_quantity(value:float):
    quantity = value
    $Quantity.value = value


func get_quantity():
    return $Quantity.value

func set_title(value:String):
    $Label.text = value


func _on_Button_pressed():
    self.queue_free()
