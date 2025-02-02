class_name eventScene extends Control

func _on_retry_button_down():
    get_tree().reload_current_scene()

func _on_quit_button_down():
    get_tree().quit()
    