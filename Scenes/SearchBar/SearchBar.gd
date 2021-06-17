extends Control


signal search(value)


func clear():
    $LineEdit.clear()


func _on_LineEdit_text_changed(new_text):
    emit_signal("search", new_text)
