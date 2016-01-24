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
	#pile des coups joué dans la grille
	@pileCoup
	#tableau contenant les indices verticaux des blocs noirs
	@vertical
	#tableau contenant les indices horizontaux des blocs noirs
	@horizontal
	
	attr_reader :matrice, :largeur, :vertical, :horizontal, :pileCoup
	private_class_method :new
	
	# == Description
	# 
	# méthode de création d'une grille, on associe à la grille une taille, des cellules et la dimension des blocs verticaux et horizontaux
	#
	# == Paramètres
	#
	# * +largeur+ : largeur de la matrice de taille largeur*largeur, doit être un multiple de 5
	#
	# == Exemple
	#
	# uneGrille = Grille.creer(10)
	#
	#IL AUDRAIT AJOUTER UNE REFERENCE VERS UN TABLEAU DE VALEUR PERMETTANT DE CONNAITRE LETAT FINAL DE LA GRILLE POUR METTRE DES VALEURS DANS LES CASES CREEES
	def Grille.creer(largeur)
		new(largeur)
	end
	
	def initialize(largeur)
		if(largeur%5==0 && largeur>=5)
			@largeur=largeur
			@pileCoup=PileCoup.creer
			#creation de la matrice contenant les cases
			@matrice=Array.new(largeur){ |i|
				Array.new(largeur){ |j|
					Case.creer(rand(2))
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
			puts "la largeur saisie doit être un multiple de 5 supérieur ou égale à 5"
		end
	end
	
	# == Description
	# 
	# méthode calculant la taille des blocs de case noire pour chaque colonne 
	#
	# == Exemple
	#
	# uneGrille.indiceV
	#
	def indiceV
		cpt=0
		largeur.times{ |i|
			largeur.times{ |j|
				if(@matrice[i][j].etatFinal==1)
					cpt+=1
				elsif cpt!=0
					@vertical[i].push(cpt)
					cpt=0
				end
			}
			if cpt!=0
				@vertical[i].push(cpt)
				cpt=0
			end
		}
	end
	
	# == Description
	# 
	# méthode calculant la taille des blocs de case noire pour chaque ligne 
	#
	# == Exemple
	#
	# uneGrille.indiceH
	#
	def indiceH
		cpt=0
		largeur.times{ |i|
			largeur.times{ |j|
				if(@matrice[j][i].etatFinal==1)
					cpt+=1
				elsif cpt!=0
					@horizontal[i].push(cpt)
					cpt=0
				end
			}
			if cpt!=0
				@horizontal[i].push(cpt)
				cpt=0
			end
		}
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
	
	# == Description
	# 
	# méthode permettant de modifier l'état courant de la case au coordonnée (abscisse;ordonnee)
	#
	# == Paramètres
	#
	# * +abscisse+ : abscisse de la case à modifier
	# * +ordonnee+ : ordonnée de la case à modifier
	#
	# == Exemple
	#
	# uneGrille.modifierXY(5,5)
	#
	def modifierXY(abscisse,ordonnee)
		if(abscisse.class==Fixnum && ordonnee.class==Fixnum)
			Coup.nouveau(@matrice[abscisse][ordonnee],@pileCoup)
		else
			puts "les paramètres ne sont pas des indices de la matrice de type entier"
		end
		return self
	end
	
	# == Description
	# 
	# méthode verifiant si l'état courant des cases de la matrice correspond à l'état final. Renvoie true si oui, false si non
	#
	# == Exemple
	#
	# uneGrille.estTerminer?
	#
	def estTerminer?
		@matrice.each{ |i|
			i.each{ |j|
				unless j.estValide?
					return false
				end
			}
		}
		return true
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
