##
# Auteur WAJDI GUEDOUAR
# Version 0.1
# Date : Lundi 25 Janvier 2016
# Description : fichier contenant la classe Jeu et toutes les liées aux interactions avec l'interface graphique

load "Grille.rb"
load "Joueur.rb"

class Jeu
	#tableau des joueurs existant, utile pour les tests, potentiellement inutile si joueur stockés dans BDD
	@@joueur=Array.new

	# == Description
	# 
	# méthode créant et retournant une matrice de taille 5x5
	#
	# == Exemple
	#
	# maGrille=unJeu.grille5x5
	#
	def grille5x5
		return Grille.creer(5)
	end
	
	# == Description
	# 
	# méthode créant et retournant une matrice de taille 10x10
	#
	# == Exemple
	#
	# maGrille=unJeu.grille10x10
	#
	def grille10x10
		return Grille.creer(10)
	end
	
	# == Description
	# 
	# méthode créant et retournant une matrice de taille 15x15
	#
	# == Exemple
	#
	# maGrille=unJeu.grille15x15
	#
	def grille15x15
		return Grille.creer(15)
	end
	
	# == Description
	# 
	# méthode créant et retournant une matrice de taille 20x20
	#
	# == Exemple
	#
	# maGrille=unJeu.grille20x20
	#
	def grille20x20
		return Grille.creer(20)
	end
	
	# == Description
	# 
	# méthode créant et retournant une matrice de taille 25x25
	#
	# == Exemple
	#
	# maGrille=unJeu.grille25x25
	#
	def grille25x25
		return Grille.creer(25)
	end
end
