#!/usr/bin/env ruby


###
# Date : Lundi 25 Janvier 2016
# Description : Fenêtre du Menu principal.
###


MenuPrincipal = Gtk::Window.new


# Titre de la fenêtre
MenuPrincipal.set_title("Picross")
# Taille de la fenêtre
MenuPrincipal.set_default_size(700,500)
# Réglage de la bordure
MenuPrincipal.border_width=5
# On peut redimensionner
MenuPrincipal.set_resizable(true)
# L'application est toujours centrée
MenuPrincipal.set_window_position(Gtk::Window::POS_CENTER_ALWAYS)



MenuPrincipal.signal_connect("event") {|w, e| area_event(w, e)}



MenuPrincipal.show_all


MenuPrincipal.signal_connect('destroy') {onDestroy}
