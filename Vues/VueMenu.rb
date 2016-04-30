#!/bin/env ruby
# encoding: utf-8

##
# Auteur YANN GUENVER / YOUSSEF LAMNIY
# Version 0.1
# Date : Jeudi 10 Mars 2016
# Description : fichier contenant la classe VueNouveauJeu du jeu du Picross

require_relative 'Vue'

require 'gtk2'

	# * *Description*:
	# 
 	# VueMenu qui a pour tâche de présenter une interface de choix de grille
 	#
 	## * *Exemple ici*:
	#	
	#	@window.add(creerMenu)	
	#		
	# * *Retourne*:
	#
	# renvoie la fenêtre dans laquelle est attaché la méthode creerMenu contenant la fenetre permettant l'affichage du menu
class VueMenu < Vue

  @lbLogin

    @btJouer
    @btScore
    @btAide
    @btEditeur
    @btAPropos

    attr_reader :btJouer, :btScore, :btAide, :btEditeur, :btAPropos, :btQuit
    attr_accessor :lbLogin
    @btQuit

    def VueMenu.creer()
              new()
    end

    # Vue chargée de présenter une interface de choix de grille
    def initialize()
            super("Picross")
            @window.add(creerMenu)
            @window.show_all
    end

	# * *Description*:
	# 
 	# Methode creerMenu qui a pour tâche de présenter une interface de choix de grille
 	#
 	## * *Exemple*:
	#	
	#	@window.add(creerMenu)	
	#		
	# * *Retourne*:
	#
	# renvoie la table contenant tous les composants du menu, notamment les boutons qui permettent donc la redirection grâce au controleurMenu
	#
    # Crée le menu de la page
    def creerMenu()
              table = Gtk::Table.new(3,1,true)

              labelVide1 = Gtk::Label.new()
              labelVide2 = Gtk::Label.new()
              @lbLogin = Gtk::Label.new()

              table.attach(@lbLogin, 0, 1, 0, 1)
              table.attach(Gtk::Label.new("Bienvenue sur Picross"), 1, 2, 0, 1)
              table.attach(labelVide1, 1, 2, 1, 2)

              @btJouer = Gtk::Button.new("Jouer   ")
              @btJouer.set_image(Gtk::Image.new(File.expand_path("./Icons/star.png", File.dirname(__FILE__))))
              @btJouer.set_alignment(0.3,0)
              table.attach(@btJouer, 1, 2, 2, 3)
              @btScore = Gtk::Button.new("Scores  ")
              @btScore.set_image(Gtk::Image.new(File.expand_path("./Icons/score.png", File.dirname(__FILE__))))
              @btScore.set_alignment(0.3,0)
              table.attach(@btScore, 1, 2, 3, 4)
              @btAide = Gtk::Button.new("Règles  ")
              @btAide.set_image(Gtk::Image.new(File.expand_path("./Icons/book.png", File.dirname(__FILE__))))
              @btAide.set_alignment(0.3,0)
              table.attach(@btAide, 1, 2, 4, 5)
              @btEditeur = Gtk::Button.new("Editeur ")
              @btEditeur.set_image(Gtk::Image.new(File.expand_path("./Icons/edit.png", File.dirname(__FILE__))))
              @btEditeur.set_alignment(0.3,0)
              table.attach(@btEditeur, 1, 2, 5, 6)
              @btAPropos = Gtk::Button.new("À Propos")
              @btAPropos.set_image(Gtk::Image.new(File.expand_path("./Icons/apropos.png", File.dirname(__FILE__))))
              @btAPropos.set_alignment(0.3,0)
              table.attach(@btAPropos, 1, 2, 6, 7)
              @btQuit = Gtk::Button.new("Quitter ")
              @btQuit.set_image(Gtk::Image.new(File.expand_path("./Icons/quit.png", File.dirname(__FILE__))))
              @btQuit.set_alignment(0.3,0)
              table.attach(@btQuit, 1, 2, 7, 8)
              table.attach(labelVide2, 2, 3, 0, 1)

        return table
    end
end
