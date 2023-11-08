extends Node2D

@export var story_beat_label: Label
@export var choices_container: Container
@export var initial_beat: StoryBeat

var _choice_buttons: Array[Button] = []

func _ready():
	_update_beat_ui(initial_beat)
	

func _update_beat_ui(story_beat: StoryBeat):
	_update_story_text(story_beat)
	_remove_current_choices()
	if (story_beat.choices.is_empty()):
		_add_reset_choice()
	else:
		_add_new_choices(story_beat)
	

func _update_story_text(story_beat: StoryBeat):
	story_beat_label.text = story_beat.story_text
	

func _remove_current_choices():
	for button in _choice_buttons:
		button.queue_free()
	_choice_buttons = []
	

func _add_new_choices(story_beat: StoryBeat):
	for choice in story_beat.choices:
		var new_button = Button.new()
		new_button.text = choice.choice_text
		new_button.pressed.connect(
			func(): _on_choice_selected(choice)
		)
		choices_container.add_child(new_button)
		_choice_buttons.append(new_button)
		

func _add_reset_choice():
	var new_button = Button.new()
	new_button.text = "Reset"
	new_button.pressed.connect(
		func(): _update_beat_ui(initial_beat)
	)
	choices_container.add_child(new_button)
	_choice_buttons.append(new_button)
	

func _on_choice_selected(new_beat: StoryBeat):
	_update_beat_ui(new_beat)
