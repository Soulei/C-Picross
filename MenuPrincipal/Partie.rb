#!/usr/bin/env ruby


###
# Auteur Youssef LAMNIY
# Date : Lundi 25 Janvier 2016
# Description : Fenetre du jeu.
###


Gtk.init

Jeu=Gtk::Window.new


# Titre de la fenêtre
Jeu.set_title("Picross")
# Taille de la fenêtre
Jeu.set_default_size(700,500)
# Réglage de la bordure
Jeu.border_width=5
# On peut redimensionner
Jeu.set_resizable(true)
# L'application est toujours centrée
Jeu.set_window_position(Gtk::Window::POS_CENTER_ALWAYS)


texte2 = "<span font_desc=\"Times New Roman italic 35\" foreground=\"#000000\">Jeu</span>\n"

maBox1=Gtk::VBox.new()
Jeu.add(maBox1)

monLabel2=Gtk::Label.new()
monLabel2.set_markup(texte2)
monLabel2.set_justify(Gtk::JUSTIFY_CENTER)

maBox1.add(monLabel2)

monBout7=Gtk::Button.new("Quitter")

maBox1.add(monBout7)



monBout7.signal_connect( "clicked" ) do 
	Gtk.main_quit
    
end

Jeu.signal_connect('destroy') {onDestroy}
