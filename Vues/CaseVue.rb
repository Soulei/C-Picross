##
# Auteur YANN GUENVER
# Version 0.1
# Date : Dimanche 24 Janvier 2016
# Description : fichier contenant la classe CaseVue du jeu du Picross
require 'gtk2'

#Une case vue est un boite d'évènement qui contient une image
#À l'initialisation, on définit la taille de l'image contenue puis ensuite on change seulement l'image (mais pas sa taille)
# * *Variables*	:
#    - +x+ -> Abscisse de la case
#    - +y+ -> Ordonnée de la case
#    - +tailleGrille+ -> Taille de la grille
#    - +grille+ -> La grille courante
#    - +image+ -> L'image de la caseVue
#    - +etat+ -> Etat courant de la caseVue
# * *Heritage*	: EventBox
#
class CaseVue < Gtk::EventBox

	@x
	@y
	
	#Permet d'effectuer la sélection de l'image à partir de son nom
	@tailleGrille
	
	@grille
	@image
	@etat
	
	attr_reader :grille, :x, :y, :etat, :tailleGrille
	
	def initialize(unEtat, uneTaille, uneGrille, x, y)
	
		super()
		
		@grille = uneGrille
		@tailleGrille = uneTaille
		@etat = unEtat
		@x = x
		@y = y
		
		changerEtat(unEtat)	
		show_all	
	end
	
	#Change la variable interne "etat" de l'instance et change l'image pour celle de l'état nouveau (avec la taille de base)
	#
	# * *Paramètres*:
	# - +unEtat+ -> Le nouvel état de la caseVue
	# * *Retourne* :
	#
	# * *Exemple* :
	#
	def changerEtat(unEtat)
	
	    @etat = unEtat
	    remove(@image) if not @image.nil?
	    setImage()
	    add(@image)
		
	    show_all	
	end
	
	#Met à la variable @image une GtkImage corespondante à l'état et la taille courante
	#
	# * *Paramètres*:
	#
	# * *Retourne* :
	#
	# * *Exemple* :
	#
	def setImage()
	
		case @etat
		
			when "blanc"
			
				@image = Gtk::Image.new(File.expand_path("./Images/carreB"+@tailleGrille.to_s+".png", File.dirname(__FILE__)))
				
			when "noir"
			
				@image = Gtk::Image.new(File.expand_path("./Images/carreN"+@tailleGrille.to_s+".png", File.dirname(__FILE__)))
			
			when "gris"
			
				@image = Gtk::Image.new(File.expand_path("./Images/carreG"+@tailleGrille.to_s+".png", File.dirname(__FILE__)))
				
			when "croixGrise"
			
				@image = Gtk::Image.new(File.expand_path("./Images/croixG"+@tailleGrille.to_s+".png", File.dirname(__FILE__)))
			
			when "croix"
			
				@image = Gtk::Image.new(File.expand_path("./Images/croixPlateau"+@tailleGrille.to_s+".png", File.dirname(__FILE__)))
				
		end
	end
end
