##
# Auteur YANN GUENVER
# Version 0.1
# Date : Mardi 26 Janvier 2016
# Description : fichier contenant la classe ControleurNouveauJeu du jeu du Picross
load "Vues/VueNouveauJeu.rb"
load "Jeu.rb"

require_relative 'Controleur'
require_relative 'ControleurJeu'

class ControleurNouveauJeu < Controleur
    
    def ControleurNouveauJeu.creer()
		new()
	end
    
    def initialize()
    
		Gtk.init
		
		@vue = VueNouveauJeu.creer()
		
		@vue.btGrille5.signal_connect('clicked'){
			@vue.fermerFenetre
			ControleurJeu.creer(Jeu.new.grille5x5)
		}
		
		
		Gtk.main
		
	end
	
	
end

