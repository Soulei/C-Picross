##
# Auteur WAJDI GUEDOUAR
# Version 0.2
# Date : Dimanche 24 Janvier 2016
# Description : fichier contenant la classe GrilleImage modélisant une grille de picross créée à partie d'une matrice
#encoding: UTF-8

require_relative 'Grille_v2'

#
# GrilleImage, une grille de Picross générée à partir d'une matrice
# * *Heritage*	: hérite de la classe Grille
#
class GrilleImage < Grille
	# * *Description*:
	#
	# méthode de création d'une grille à partir d'une image, on associe à la grille une taille, des cellules et la dimension des blocs verticaux et horizontaux
	#
	# * *Paramètre*:
	#
	# - +largeur+ -> largeur de la matrice de taille largeur*largeur, doit être un multiple de 5
	# - +matriceImage+ -> matrice générée à partir d'une image pixélisée, contient uniquement des 0 et des 1
	#
	# * *Exemple*:
	#
	# uneGrille = GrilleImage.creer(10)
	#
	def GrilleImage.creer(largeur,matriceImage)
		new(largeur,matriceImage)
	end

	def initialize(largeur,matriceImage)
		if(largeur%5==0 && largeur>=5)


			@largeur=largeur
			@pile=Pile.creer
			@retro=Array.new
			#creation de la matrice contenant les cases
			@matrice=Array.new(largeur){ Array.new(largeur)}

			largeur.times{ |i|
				largeur.times{ |j|
					@matrice[i][j]=Case.creer(matriceImage[i][j],i,j)
				}
			}

			#creation d'une matrice contenant les blocs de cases noires verticales par indice
			@vertical=Array.new(largeur){ |i|
				Array.new()
			}
			#creation d'une matrice contenant les blocs de cases noires horizontales par indice
			@horizontal=Array.new(largeur){ |i|
				Array.new()
			}

			self.indiceH
			self.indiceV
		else
			puts "la largeur saisie doit etre un multiple de 5 superieur ou egale a 5"
		end
	end
end
