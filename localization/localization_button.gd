extends Control

func _ready():
	var current_language = TranslationServer.get_locale()
	if current_language != "en"\
		and current_language != "es"\
		and current_language != "fr":
		TranslationServer.set_locale("es")

func _on_toggle_language_pressed():
	match TranslationServer.get_locale():
		"es":
			TranslationServer.set_locale("en")
		"en":
			TranslationServer.set_locale("fr")
		"fr":
			TranslationServer.set_locale("es")
		_:
			TranslationServer.set_locale("es")
