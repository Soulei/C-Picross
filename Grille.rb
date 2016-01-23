##
# Auteur WAJDI GUEDOUAR
# Version 0.1
# Date : Lundi 23 Janvier 2016
# Description : fichier contenant la class Grille, modélisant la grille de Picross avec laquelle le joueur pourra intéragir

load "Pile.rb"

class Grille
	#matrice modélisant une grille de picross 
	@matrice
	#largeur de la matrice
	@largeur
	
	attr_reader :matrice
	private_class_method :new
	
	# == Description
	# 
	# méthode de création d'une grille
	#
	# == Paramètres
	#
	# * +largeur+ : largeur de la matrice de taille largeur*largeur, doit être un multiple de 5
	#
	# == Exemple
	#
	# uneGrille = Grille.creer(10)
	#
	def Grille.creer(largeur)
		new(largeur)
	end
	
	def initialize(largeur)
		if(largeur%5==0 && largeur>=5)
			@largeur=largeur
			@matrice=Array.new(largeur){ |i|
				Array.new(largeur){ |j|
					Case.creer(1)
				}
			}
		else
			puts "la largeur saisie doit être un multiple de 5 supérieur ou égale à 5"
		end
	end
	
	# == Description
	# 
	# méthode calculant la taille de la matrice
	#
	# == Exemple
	#
	# unEntier=uneGrille.dimension
	#
	def dimension()
		taille=0 
		@matrice.each{ |i|
			taille+=i.length
		}
		return taille
	end
	
	#méthode à améliorer dès que possible !!
	def to_s
		m=0
		n=0
		while  m < @largeur
			while n < @largeur
				print @matrice[m][n].to_s
				n+=1
			end
			puts ""
			n=0
			m+=1
		end
	end
end
