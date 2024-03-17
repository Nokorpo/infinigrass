extends Control

const SUPPORTED_LANGUAGES = ["en", "es", "fr", "cat"]

func _ready():
	var current_language = TranslationServer.get_locale()
	if current_language not in SUPPORTED_LANGUAGES:
		TranslationServer.set_locale("es")

func _on_toggle_language_pressed():
	match TranslationServer.get_locale():
		"cat":
			TranslationServer.set_locale("en")
		"en":
			TranslationServer.set_locale("fr")
		"fr":
			TranslationServer.set_locale("es")
		"es":
			TranslationServer.set_locale("cat")
		_:
			TranslationServer.set_locale("es")
