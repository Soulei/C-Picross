#!/usr/bin/env ruby
# encoding=utf-8 

##
# Auteur YANN GUENVER
# Version 0.1
# Date : Mardi 28 Avril 2016
# Description : fichier contenant la classe VueAide du Picross


require_relative 'Vue'

require 'gtk2'
require "glib2"
include Gtk

# Classe abstraite définissant les attributs et comportements généraux de nos vues concrètes
# * *Variables*	:
#    - +btRetour+ -> Bouton permetant de retourner au menu principal
# * *Heritage*	: Vue
#
class VueAide < Vue
    
    @btRetour    

    attr_reader :btRetour
    
    def VueAide.creer(unJeu,unJoueur)
		new(unJeu,unJoueur)
	end

	def initialize(unJeu,unJoueur)
	
		super("Règles")
		
		@window.set_default_size(800,500)
		@window.set_resizable(true)
		@window.set_modal(true)
		
        box = Gtk::ScrolledWindow.new()
		vBox = Gtk::VBox.new()
		
		
		vBox.add(Gtk::Label.new().set_markup('<span size="xx-large"><b>Picross</b></span>'))
		vBox.add(Gtk::Label.new("Le but d'un picross est de noircir les cases de la grille afin de faire apparaître une image, un dessin. Les nombres à gauche et au-dessus de la \ngrille sont là pour vous aider à déduire les cases à noircir."))
		vBox.add(Gtk::Label.new().set_markup('<span size="x-large">Théorème n°1</span>'))
		vBox.add(Gtk::Image.new(File.expand_path("./Images/GIF/th1.gif", File.dirname(__FILE__))))
		vBox.add(Gtk::Label.new("Sur une grille de picross quelconque, lorsque l’indice indiqué est égale à la largeur de la grille, alors toutes les cases doivent être noircies \ncar celles-ci appartiennent à un seul bloc."))
		vBox.add(Gtk::Label.new().set_markup('<span size="x-large">Théorème n°2</span>'))
		vBox.add(Gtk::Image.new(File.expand_path("./Images/GIF/th2.gif", File.dirname(__FILE__))))
		vBox.add(Gtk::Label.new("Lorsque l’indice donné est plus grand que la moitié des cases, on noircit les cases depuis le début ensuite depuis la fin des cases \net on retient les cases confondues. Avec l’indice 7 pour une grille de 10 x 10, on noircit les 4 case du centre."))
		vBox.add(Gtk::Label.new().set_markup('<span size="x-large">Théorème n°3</span>'))
		vBox.add(Gtk::Image.new(File.expand_path("./Images/GIF/th3.gif", File.dirname(__FILE__))))
		vBox.add(Gtk::Label.new("Lorsqu’une case est noircie en bordure de votre Picross, en fonction de sa position (première case ou dernière case), vous pouvez déduire que \ncette case est la première du premier bloc ou la dernière du dernier bloc."))
		vBox.add(Gtk::Label.new().set_markup('<span size="x-large">Théorème n°4</span>'))
		vBox.add(Gtk::Image.new(File.expand_path("./Images/GIF/th4.gif", File.dirname(__FILE__))))
		vBox.add(Gtk::Label.new("Considérons que chaque bloc est séparé d’une case blanche, si la somme des indices des blocs + nombre de bloc - 1 = largeur de la grille, \nalors il existe qu’une seule manière de remplir votre ligne/colonne. Vous n’avez qu’à remplir votre ligne/colonne en ne mettant \nqu’un espace entre chaque bloc."))
		vBox.add(Gtk::Image.new(File.expand_path("./Images/GIF/th5.gif", File.dirname(__FILE__))))
		vBox.add(Gtk::Label.new("Si la valeur calculée est inférieur à la largeur de la grille, cela signifie qu’il y a plus d’une case blanche entre deux blocs"))
		vBox.add(@btRetour = Gtk::Button.new("Retour"))
		
		box.add_with_viewport(vBox)
		@window.add(box)
		@window.show_all
	end
	
	
end



  
