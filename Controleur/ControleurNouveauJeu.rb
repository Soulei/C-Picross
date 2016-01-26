##
# Auteur YANN GUENVER
# Version 0.1
# Date : Mardi 26 Janvier 2016
# Description : fichier contenant la classe ControleurNouveauJeu du jeu du Picross
load "../Vues/VueNouveauJeu.rb"
load "../Jeu.rb"

require_relative 'Controleur'

class ControleurNouveauJeu < Controleur
    
    
    def initialize()
    
		Gtk.init
		
		@vue = VueNouveauJeu.creer()
		
		@vue.btGrille5.signal_connect('clicked'){
			@vue.fermerFenetre
			ControleurJeu.new(Jeu.new.grille5x5)
		}
		
		
		@vue.window.signal_connect('destroy') {Gtk.main_quit}
		Gtk.main
	end
	
	
end

essaie=VerifVue.new
essaie.testerVue
