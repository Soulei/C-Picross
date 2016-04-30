#!/usr/bin/env ruby


###
# Auteur Youssef LAMNIY
# Date : Lundi 25 Janvier 2016
# Description : Fenêtre de reglages.
###



Reglages=Gtk::Window.new



# Titre de la fenêtre
Reglages.set_title("Picross")
# Taille de la fenêtre
Reglages.set_default_size(700,500)
# Réglage de la bordure
Reglages.border_width=5
# On peut redimensionner
Reglages.set_resizable(true)
# L'application est toujours centrée
Reglages.set_window_position(Gtk::Window::POS_CENTER_ALWAYS)


texte = "<span font_desc=\"Times New Roman italic 35\" foreground=\"#000000\">Reglages</span>\n"

maBox1=Gtk::VBox.new()
Reglages.add(maBox1)

monLabel=Gtk::Label.new()
monLabel.set_markup(texte)
monLabel.set_justify(Gtk::JUSTIFY_CENTER)

maBox1.add(monLabel)

monBout7=Gtk::Button.new("Quitter")

maBox1.add(monBout7)


monBout7.signal_connect( "clicked" ) do 
	Gtk.main_quit
    
end

Reglages.signal_connect('destroy') {onDestroy}

