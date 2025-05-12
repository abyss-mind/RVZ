extends Node

var positions = [Vector2(-450, -476), Vector2(-450, -266), Vector2(-450, -56), Vector2(-450, 154)]
var question = null
var fake_answers = null
var can_answer = false
var file = null

@onready var session_attempts = 0
@onready var session_correct = 0
@onready var session_incorrect = 0


func _ready():
	checksubject()
	getquestion()
	settext()
	shuffleanswers()
	
func checksubject():
	if Data.subject == "BP1H":
		file = FileAccess.open("res://questions/biologyp1h.json", FileAccess.READ)
	
func _set_question_font_size(length):
	if length > 86:
		return 35
	elif length > 90:
		return 33
	elif length > 92:
		return 31
	else:
		return 40

func _set_button_font_size(length):
	if length > 26:
		return 45
	elif length > 33:
		return 40
	elif length > 37:
		return 35
	else:
		return 56

func scaletext():
	var correct_btn = $"../Buttons/Correct/Label"
	var fake1_btn = $"../Buttons/Fake1/Label"
	var fake2_btn = $"../Buttons/Fake2/Label"
	var fake3_btn = $"../Buttons/Fake3/Label"
	var question_label = $"../Text/Question"

	var correct_text = correct_btn.text
	var fake1_text = fake1_btn.text
	var fake2_text = fake2_btn.text
	var fake3_text = fake3_btn.text

	# Scale question font size based on correct answer length
	question_label.add_theme_font_size_override("normal_font_size", _set_question_font_size(correct_text.length()))

	# Scale button font sizes
	correct_btn.add_theme_font_size_override("font_size", _set_button_font_size(correct_text.length()))
	fake1_btn.add_theme_font_size_override("font_size", _set_button_font_size(fake1_text.length()))
	fake2_btn.add_theme_font_size_override("font_size", _set_button_font_size(fake2_text.length()))
	fake3_btn.add_theme_font_size_override("font_size", _set_button_font_size(fake3_text.length()))
		
func getquestion():
	var questions = JSON.parse_string(file.get_as_text())
	question = questions[randi() % questions.size()]
	fake_answers = question["fake_answers"].duplicate()
	fake_answers.shuffle()
	
func shuffleanswers():
	positions.shuffle()
	$"../Buttons/Correct".position = positions[0]
	$"../Buttons/Fake1".position = positions[1]
	$"../Buttons/Fake2".position = positions[2]
	$"../Buttons/Fake3".position = positions[3]
	
func settext():
	$"../Text/Question".text = question["question"]
	$"../Text/Topic".text = question["topic"]
	$"../Buttons/Correct/Label".text = question["correct_answer"]
	$"../Buttons/Fake1/Label".text = fake_answers[0]
	$"../Buttons/Fake2/Label".text = fake_answers[1]
	$"../Buttons/Fake3/Label".text = fake_answers[2]
	scaletext()
	
func answered(status):
	if can_answer == true:
		if status == "correct":
			session_attempts += 1
			session_correct += 1
		if status == "incorrect":
			session_attempts += 1
			session_incorrect += 1
	can_answer = false
	$"../Text/Attempts".text = str(session_attempts)
	$"../Text/Correct".text = str(session_correct)
	$"../Text/Incorrect".text = str(session_incorrect)
	$"../Buttons/Next".visible = true
	$"../Explanation/Explanation".text = question["explanation"]
	$"../Explanation".visible = true
	revealanswers()
	
func revealanswers():
	$"../Buttons/Correct".texture_normal = preload("res://images/Quiz_CUS.png")
	$"../Buttons/Correct".texture_hover = preload("res://images/Quiz_CS.png")
	
	$"../Buttons/Fake1".texture_hover = preload("res://images/Quiz_US.png")
	$"../Buttons/Fake2".texture_hover = preload("res://images/Quiz_US.png")
	$"../Buttons/Fake3".texture_hover = preload("res://images/Quiz_US.png")
	
	$"../Buttons/Correct/Label".add_theme_color_override("default_color", "#" + "000000")
	$"../Buttons/Fake1/Label".add_theme_color_override("default_color", "#" + "5a0000")
	$"../Buttons/Fake2/Label".add_theme_color_override("default_color", "#" + "5a0000")
	$"../Buttons/Fake3/Label".add_theme_color_override("default_color", "#" + "5a0000")
	
	
		
func _on_correct_pressed() -> void:
	answered("correct")
func _on_fake_1_pressed() -> void:
	answered("incorrect")
func _on_fake_2_pressed() -> void:
	answered("incorrect")
func _on_fake_3_pressed() -> void:
	answered("incorrect")
func _on_next_pressed() -> void:
	checksubject()
	getquestion()
	settext()
	shuffleanswers()
	can_answer = true
	$"../Buttons/Next".visible = false
	$"../Explanation".visible = false
	$"../Buttons/Correct".texture_normal = preload("res://images/Quiz_US.png")
	$"../Buttons/Correct".texture_hover = preload("res://images/Quiz_S.png")
	
	$"../Buttons/Fake1".texture_hover = preload("res://images/Quiz_S.png")
	$"../Buttons/Fake2".texture_hover = preload("res://images/Quiz_S.png")
	$"../Buttons/Fake3".texture_hover = preload("res://images/Quiz_S.png")
	
	$"../Buttons/Correct/Label".add_theme_color_override("default_color", "#" + "ffffff")
	$"../Buttons/Fake1/Label".add_theme_color_override("default_color", "#" + "ffffff")
	$"../Buttons/Fake2/Label".add_theme_color_override("default_color", "#" + "ffffff")
	$"../Buttons/Fake3/Label".add_theme_color_override("default_color", "#" + "ffffff")

	


func _on_bp_1h_pressed() -> void:
	pass # Replace with function body.
