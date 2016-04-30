#!/usr/bin/env ruby
# encoding=utf-8 

##
# Auteur YANN GUENVER
# Version 0.1
# Date : Samedi 23 Janvier 2016
# Description : fichier contenant la classe Vue du jeu du Picross

require 'gtk2'


# Classe abstraite définissant les attributs et comportements généraux de nos vues concrètes
# * *Variables*	:
#    - +window+ -> Fenètre de l'interface
# * *Heritage*	: 
#
class Vue

	@window
	
	attr_reader :window
	
	private_class_method :new
	
	
	def initialize(leTitre)
		@window = Gtk::Window.new(leTitre)
		@window.set_window_position(Gtk::Window::POS_CENTER)
		@window.set_default_size(100,100)
		@window.set_resizable(false)
	end

	#Actualiser sera redéfinit par les classes filles (on code ici pour débuguer)
	def actualiser
	
	end
	
	def widget()
	      return @window
	end
	
	#Affiche la fenètre
	def afficher()
	     @window.show_all()
	end
	
	#Ferme la fenêtre de la vue actuelle
	def fermerFenetre
		@window.hide_all
	end
end
