# encoding: utf-8
#! /usr/bin/env ruby
#
#

######### CONTROLEURSCORE.RB #########

######### IMPORTS ###########

require 'gtk2'

load "./Vues/VueHighScore.rb"

require './Vues/VueHighScore'
require_relative 'Controleur'
require_relative 'ControleurMenu'


	# * *Description*:
	# 
 	# Classe ControleurScore qui a pour tâche de présenter une interface contenant les meilleurs scores de chaque utilisateur 
 	# en fonction de chaque partie sauvegardée pour chaque mode joué.
 	#		
	# * *Retourne*:
	#
	# Creer la vue HighScore
	#

class ControleurScore < Controleur
  
	public_class_method :new

	def ControleurScore.creer(unJeu, unJoueur)
		new(unJeu,unJoueur)
	end

	# Crée la fenêtre des scores
	def initialize(jeu, joueur)

		super(jeu, joueur)

		@vue = VueHighScore.creer()

		@vue.MiseAJourMode

		@vue.btretour.signal_connect('clicked') {
			changerControleur(ControleurMenu.creer(@jeu,@joueur))
		}

		# Si on détruit la fenêtre, on retourne au menu principal
		@vue.window.signal_connect('delete_event') {
			changerControleur(ControleurMenu.creer(@jeu,@joueur))
		}
	end
  
end
