##
# Auteur WAJDI GUEDOUAR
# Version 0.1
# Date : Lundi 25 Janvier 2016
# Description : fichier contenant la classe Jeu et toutes les liées aux interactions avec l'interface graphique

require_relative 'GrilleEdit'
require_relative 'GrilleImage'
require_relative 'GrilleCharger'

require_relative 'Joueur'
require_relative 'picture'


class Jeu
	#objet jeu singletonner
	@@jeu=nil

	#private_class_method :new
	
	# * *Description*:
	#
	# méthode créant une unique instance de Jeu (singleton)
	#
	# * *Exemple*:
	#
	# maGrille=Jeu.getInstance
	#
	def Jeu.getInstance
		if(@@jeu==nil)
			@@jeu=Jeu.new
		end
		return @@jeu
	end

	# * *Description*:
	#
	# méthode créant et retournant une matrice de taille 5x5
	#
	# * *Exemple*:
	#
	# maGrille=unJeu.grille5x5
	#
	def grille5x5
		return Grille.creer(5)
	end

	# * *Description*:
	#
	# méthode créant et retournant une matrice de taille 10x10
	#
	# * *Exemple*:
	#
	# maGrille=unJeu.grille10x10
	#
	def grille10x10
		return Grille.creer(10)
	end

	# * *Description*:
	#
	# méthode créant et retournant une matrice de taille 15x15
	#
	# * *Exemple*:
	#
	# maGrille=unJeu.grille15x15
	#
	def grille15x15
		return Grille.creer(15)
	end

	# * *Description*:
	#
	# méthode créant et retournant une matrice de taille 20x20
	#
	# * *Exemple*:
	#
	# maGrille=unJeu.grille20x20
	#
	def grille20x20
		return Grille.creer(20)
	end

	# * *Description*:
	#
	# méthode créant et retournant une matrice de taille 25x25
	#
	# * *Exemple*:
	#
	# maGrille=unJeu.grille25x25
	#
	def grille25x25
		return Grille.creer(25)
	end

	# * *Description*:
	#
	# méthode de création d'une grille générer à partir d'une image
	#
	# * *Paramètre*:
	#
	# - +largeur+ -> largeur de la grille à créer
	# - +image+ -> chemin permettant d'acceder à l'image sous forme de String
	#
	# * *Exemple*:
	#
	# uneGrilleImage = jeu.grilleImage(15,"Mon chemin")
	#
	def grilleImage(largeur,image)
		imageCreation= PicrossImage.lire(image)
		matrice=imageCreation.toPicross(largeur)
		return GrilleImage.creer(largeur,matrice)
	end

	# * *Description*:
	# 
	# méthode de création d'une grille qui sera éditée par le joueur
	#
	# * *Paramètre*:
	#
	# - +largeur+ -> largeur de la grille à éditée
	# - +base+ -> etat de base des cellules de la grille
	#
	# * *Exemple*:
	#
	# uneGrilleEdite = jeu.grilleEditer(15)
	#
	def grilleEditer(largeur, base)
		return  GrilleEdit.creer(largeur, base)
	end

	# * *Description*:
	#
	# méthode permettant de créer une grille à partir d'une matrice
	#
	# * *Paramètre*:
	#
	# - +largeur+ -> largeur de la grille
	# - +uneMatrice+ -> matrice contenant uniquement les état finaux des cases pour création de la grille
	#
	# * *Exemple*:
	#
	# uneGrilleEdite = jeu.chargerGrille(15)
	#
	def chargerGrille(uneMatrice,largeur)
		return GrilleImage.creer(largeur,uneMatrice)
	end

	# * *Description*:
	#
	# méthode permettant de créer une pile à partir d'un tableau de coup
	#
	# * *Paramètre*:
	#
	# - +unTab+ -> tableau contenant les coups
	#
	# * *Exemple*:
	#
	# unePile = jeu.chargerPile(15)
	#
	def chargerPile(unTab)
		unePile = Pile.creer()
		unTab.each{ |i|
			unePile.empiler(i)
		}
		return unePile
	end

	# * *Description*:
	#
	# méthode permettant de charger une partie à partir d'information provenant de la base de donnée
	#
	# * *Paramètre*:
	#
	# - +tab+ -> tableau contenant les informations chargées depuis la base de donnée
	#
	# * *Exemple*:
	#
	# maGrille=unJeu.chargerCharger(leTableau)
	#
	def chargerCharger(tab)
		return GrilleCharger.creer(tab)
	end
end