##
# Auteur YANN GUENVER
# Version 0.1
# Date : Mardi 28 Avril 2016
# Description : fichier contenant la classe ControleurAide du Picross
# encoding: utf-8

require 'gtk2'

load "./Vues/VueAide.rb"

require_relative 'Controleur'



class ControleurAide < Controleur
    
	def ControleurAide.creer(unJeu,unJoueur)
		new(unJeu,unJoueur)
    end
	
    def initialize(unJeu,unJoueur)
		
		super(unJeu,unJoueur)
		
		@vue = VueAide.creer(unJeu,unJoueur)
		
		
		@vue.btRetour.signal_connect('clicked') {
			changerControleur(ControleurMenu.creer(@jeu,@joueur))
		}
		
		@vue.window.signal_connect('delete_event') {
			quitterJeu
		}
	end
end



  


