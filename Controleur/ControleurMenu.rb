#!/usr/bin/env ruby
# encoding=utf-8 

# Auteur YANN GUENVER / YOUSSEF LAMNIY / HAJIR Mohammed Amine
# Version 0.1
# Date : Mardi 26 Janvier 2016
# Description : fichier contenant la classe ControleurNouveauJeu du jeu du Picross
load "./Vues/VueMenu.rb"
load "./Modele/Jeu.rb"

require_relative 'Controleur'
require_relative 'ControleurJouer'
require_relative 'ControleurEditeur'
require_relative 'ControleurAide'
require_relative 'ControleurAPropos'
require_relative 'ControleurScore'

# Classe ControleurJeu
# * *Variables*	:
#    
# * *Heritage*	: Controleur
#
class ControleurMenu < Controleur

	# Méthode de création d'un ControleurJeu
	#
	# * *Paramètres*:
	# - +unJeu+ -> Le jeu du Picross
	# - +unJoueur+ -> Le pseudonyme du joueur
	# * *Exemple* :
	#
    def ControleurMenu.creer(unJeu,unJoueur)
		new(unJeu,unJoueur)
	end

    def initialize(unJeu,unJoueur)

		super(unJeu,unJoueur)

		@vue = VueMenu.creer()
		@vue.lbLogin.set_text(@joueur.to_s)
		# On relache le clique
		Gdk::Display.default.pointer_ungrab(Gdk::Event::CURRENT_TIME)

		# Si on clique sur le bouton Jouer, on ouvre la fenêtre Jouer
		@vue.btJouer.signal_connect('clicked'){
			@vue.fermerFenetre
			changerControleur(ControleurJouer.creer(@jeu,@joueur))
		}

		# Si on clique sur le bouton Score, on ouvre la fenêtre des scores
		@vue.btScore.signal_connect('clicked'){
			@vue.fermerFenetre
			changerControleur(ControleurScore.new(@jeu, @joueur))
	    }
		
		# Si on clique sur le bouton Aide, on ouvre la fenêtre des règles du jeu
		@vue.btAide.signal_connect('clicked'){
			@vue.fermerFenetre
			changerControleur(ControleurAide.creer(@jeu,@joueur))
		}

		# Si on clique sur le bouton Editeur, on ouvre la fenêtre Editeur
		@vue.btEditeur.signal_connect('clicked'){
			@vue.fermerFenetre
			changerControleur(ControleurEditeur.creer(@jeu,@joueur))
		}

		# Si on clique sur le bouton APropos, on ouvre la fenêtre APropos
		@vue.btAPropos.signal_connect('clicked'){
			ControleurAPropos.creer(@jeu,@joueur)
		}

		# Si on clique sur le bouton Quit, on quitte le jeu
		@vue.btQuit.signal_connect('clicked'){
			quitterJeu
		}

		# Si on détruit la fenêtre, on quitte le jeu
		@vue.window.signal_connect('delete_event') {
			quitterJeu
		}
	end
end