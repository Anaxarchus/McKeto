class_name Ingredient
extends Node

enum types {BEEF, PORK, CHICKEN, FISH, FRUIT, VEGETABLE, DAIRY, CONDIMENT, PREPACKAGED, OTHER}

var title:String
var id:int = -1
var thumbnail:ImageTexture
var macros:Macro
var gluten_free:bool = false
var type:int = 9

var serving_size:float
var quantity:float


func from_dict(value:Dictionary):
    title = value.title
    id = value.id
    type = value.type
    gluten_free = value.gluten_free
        
    macros = Macro.new()
    macros.from_dictionary(value.macros)
