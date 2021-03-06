#!/usr/bin/env ruby


###
# Date : Lundi 25 Janvier 2016
# Description : Fenêtre du Highscore.
###

Highscore=Gtk::Window.new


# Titre de la fenêtre
Highscore.set_title("Picross")
# Taille de la fenêtre
Highscore.set_default_size(700,500)
# Réglage de la bordure
Highscore.border_width=5
# On peut redimensionner
Highscore.set_resizable(true)
# L'application est toujours centrée
Highscore.set_window_position(Gtk::Window::POS_CENTER_ALWAYS)



texte = "<span font_desc=\"Times New Roman italic 35\" foreground=\"#000000\">Highscore</span>\n"

maBox1=Gtk::VBox.new()
Highscore.add(maBox1)

monLabel=Gtk::Label.new()
monLabel.set_markup(texte)
monLabel.set_justify(Gtk::JUSTIFY_CENTER)

maBox1.add(monLabel)

monBout7=Gtk::Button.new("Quitter")

maBox1.add(monBout7)


monBout7.signal_connect( "clicked" ) do 
	Gtk.main_quit
    
end


# Quand la fenêtre est dêtruite il faut quitter
Highscore.signal_connect('destroy') {onDestroy}
