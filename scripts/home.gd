extends Node

func setsubject(subject):
	Data.subject = subject
	get_tree().change_scene_to_file("res://scenes/quiz.tscn")
	
func _on_bp_1h_pressed() -> void:
	setsubject("BP1H")
