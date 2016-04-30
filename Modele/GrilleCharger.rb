##
# Auteur WAJDI GUEDOUAR
# Version 0.2
# Date : Vendredi 1 Avril 2016
# Description : fichier contenant la classe GrilleImage modélisant une grille de picross créée à partie d'une matrice
#encoding: UTF-8

require_relative 'Grille_v2'

#
# GrilleImage, une grille de Picross générée à partir d'une matrice
# * *Heritage*	: hérite de la classe Grille
#
class GrilleCharger < Grille
	# * *Description*:
	#
	# méthode de création d'une grille à partir d'information de la base de donnée
	#
	# * *Paramètre*:
	#
	# - +matriceBD+ -> matrice contenant toutes les informations provenant de la BDD et permettant la creation d'une grille et d'une pile
	#
	# * *Exemple*:
	#
	# uneGrille = GrilleCharger.creer(laMatrice)
	#
	def GrilleCharger.creer(matriceBD)
		new(matriceBD)
	end

	def initialize(matriceBD)
		largeur=matriceBD[0][0].length
		if(largeur%5==0 && largeur>=5)
			@largeur=largeur
			mat=matriceBD[0]
			#test
			puts mat
			#creation de la matrice contenant les cases
			@matrice=Array.new(largeur){ Array.new(largeur)}

			largeur.times{ |i|
				largeur.times{ |j|
					@matrice[i][j]=Case.creer(mat[i][j],i,j)
				}
			}

			#creation d'une matrice contenant les blocs de cases noires verticales par indice
			@vertical=Array.new(largeur){Array.new()}
			#creation d'une matrice contenant les blocs de cases noires horizontales par indice
			@horizontal=Array.new(largeur){Array.new()}


			@pile=Pile.creer()
			@pile.pileCharger(self,matriceBD[1])
			@retro=Array.new #faut creer une pile a partir d'une matrice donc creer une nouvelle classe de pile

			self.indiceH
			self.indiceV
		else
			puts "la largeur saisie doit etre un multiple de 5 superieur ou egale a 5"
		end
	end
end
