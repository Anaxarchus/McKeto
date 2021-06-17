class_name MacroArray
extends Node


var macros:Array
var total_calories:float setget ,get_total_calories
var total_carbs:float setget ,get_total_carbs
var total_protein:float setget ,get_total_protein
var total_fat:float setget ,get_total_fat
var total_fiber:float setget ,get_total_fiber
var total_sugar:float setget ,get_total_sugar


func append(macro:Macro):
    macros.append(macro)

func get_total_calories():
    pass

func get_total_carbs():
    pass

func get_total_protein():
    pass

func get_total_fat():
    pass

func get_total_fiber():
    pass

func get_total_sugar():
    pass
