##
# Auteur WAJDI GUEDOUAR
# Version 0.2
# Date : Dimanche 24 Janvier 2016
# Description : fichier contenant la classe GrilleEdit modélisant une grille de picross créée à partie d'une matrice
#encoding: UTF-8

require_relative 'Grille_v2'

#
# GrilleImage, une grille de Picross générée à partir d'une matrice
# * *Heritage*	: hérite de la classe Grille
#
class GrilleEdit < Grille

	# * *Description*:
	#
	# méthode de création d'une grille, on associe à la grille une taille et des cellules qui ont toutes été initialisé à vide
	#
	# * *Paramètre*:
	#
	# - +largeur+ -> largeur de la matrice de taille largeur*largeur, doit être un multiple de 5
	# - +base+ -> etat de base des cellules
	#
	# * *Exemple*:
	#
	# uneGrilleEdit = GrilleEdit.creer(10)
	#
	def GrilleEdit.creer(largeur, base)
		new(largeur, base)
	end
	def initialize(largeur, base)
		if(largeur%5==0 && largeur>=5)
			@largeur=largeur
			@pile=Pile.creer
			@retro=Array.new
			#creation de la matrice contenant les cases, l'etat final des cases est définit aléatoirement
			@matrice=Array.new(largeur){ Array.new(largeur){ }}

			#creation des cases dans le grille dans un second temps pour pouvoir récupérer les coordonnées
			0.upto(@largeur - 1){ |i|
				0.upto(@largeur - 1){ |j|
					@matrice[i][j]=Case.creer(1,i,j)
					if (base==0)
						@matrice[i][j].changeEtat
					end
				}
			}
		end
	end

	# * *Description*:
	#
	# méthode calculant les indices verticaux et horizontaux d'une grille de picross
	#
	# * *Exemple*:
	#
	# uneGrille.setIndice
	#
	def setIndice
		self.indiceH
		self.indiceV
		return self
	end

	# * *Description*:
	#
	# méthode sauvegardant la grille créée par le joueur
	#
	# * *Exemple*:
	#
	# uneGrille.setIndice
	#
	def svgGrille
		@matrice.each{ |i|
			i.each{ |j|
				j.etatFinal=j.etatCourant
				j.etatCourant=1
			}
		}
		#code de la BDD pour sauvegarder la grille éditée
	end

	# * *Description*:
	#
	# méthode permettant de modifier l'état courant de la case aux coordonnées (abscisse;ordonnee)
	#
	# * *Paramètres*:
	#
	# - +abscisse+ -> abscisse de la case à modifier
	# - +ordonnee+ -> ordonnée de la case à modifier
	#
	# * *Exemple*:
	#
	# uneGrille.modifierXY(5,5)
	#
	def modifierXY(abscisse,ordonnee)
		if(abscisse.class==Fixnum && ordonnee.class==Fixnum)
			@retro.push(Coup.nouveau(@matrice[abscisse][ordonnee],@matrice[abscisse][ordonnee].etatCourant,@pile,self))
			@matrice[abscisse][ordonnee].etatFinal = @matrice[abscisse][ordonnee].etatCourant
		else
			puts "les parametres ne sont pas des indices de la matrice de type entier"
		end
		return self

	end

end
