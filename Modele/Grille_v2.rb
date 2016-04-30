##
# Auteur WAJDI GUEDOUAR
# Version 0.2
# Date : Dimanche 24 Janvier 2016
# Description : fichier contenant la class Grille, modélisant la grille de Picross avec laquelle le joueur pourra intéragir
#encoding: UTF-8

require_relative 'Pile_v2'
require_relative 'aide_v1'
require_relative 'Astuce'

#
# Grille, une grille de Picross
# * *Variable*	:
#    - +matrice+ -> matrice modélisant une grille de picross
#    - +largeur+ -> largeur de la matrice
#    - +pile+ -> pile des coups joué dans la grille
#    - +retro+ -> tableau contenant tout les coups joués
#    - +vertical+ -> tableau contenant les indices verticaux des blocs noirs
#    - +horizontal+ -> tableau contenant les indices horizontaux des blocs noirs
#    - +revel+ -> flag pour les aides de types "révélation"
# * *Heritage*	: Aucun lien
#
class Grille
	#matrice modélisant une grille de picross
	@matrice
	#largeur de la matrice
	@largeur
	#pile des coups joué dans la grille pour gestion des annulations des coups et hypothèses
	@pile
	#tableau contenant tout les coups joués
	@retro
	#tableau contenant les indices verticaux des blocs noirs
	@vertical
	#tableau contenant les indices horizontaux des blocs noirs
	@horizontal
	#flag pour les aides de types "révélation"
	@revel

	attr_reader :matrice, :largeur, :vertical, :horizontal, :pile, :retro, :revel
	private_class_method :new

	# * *Description*:
	#
	# méthode de création d'une grille, on associe à la grille une taille, des cellules et la dimension des blocs verticaux et horizontaux
	#
	# * *Paramètre*:
	#
	# - +largeur+ -> largeur de la matrice de taille largeur*largeur, doit être un multiple de 5
	#
	# * *Exemple*:
	#
	# uneGrille = Grille.creer(10)
	#
	def Grille.creer(largeur)
		new(largeur)
	end

	def initialize(largeur)
		if(largeur%5==0 && largeur>=5)
			@largeur=largeur
			@pile=Pile.creer
			@retro=Array.new

			#creation de la matrice contenant les cases, l'etat final des cases est définit aléatoirement
			@matrice=Array.new(largeur){ Array.new(largeur){ }}

			#creation des cases dans le grille dans un second temps pour pouvoir récupérer les coordonnées
			0.upto(@largeur - 1){ |i|
				0.upto(@largeur - 1){ |j|
					@matrice[i][j]=Case.creer(rand(2),i,j)
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

	# * *Description*:
	#
	# méthode calculant la taille des blocs de case noire pour chaque colonne et stockant le résultat dans la variable @vertical
	#
	# * *Exemple*:
	#
	# uneGrille.indiceV
	#
	def indiceV
		cpt=0
		#se place dans chaque colonne
		@largeur.times{ |i|
			#se place dans chaque ligne
			@largeur.times{ |j|
				#traite en fonction de l'etatFinal
				if(@matrice[i][j].etatFinal==0)
					cpt+=1
				elsif cpt!=0
					@vertical[i].push(cpt)
					cpt=0
				end
			}
			#ajoute le dernier bloc si la case noir se trouve en bout de colonne
			if cpt!=0
				@vertical[i].push(cpt)
				cpt=0
			end
		}
	end

	# * *Description*:
	#
	# méthode calculant la taille des blocs de case noire pour chaque ligne et stockant le résultat dans la variable @horizontal
	#
	# * *Exemple*:
	#
	# uneGrille.indiceH
	#
	def indiceH
		cpt=0

		#se place dans chaque ligne
		@largeur.times{ |i|
			#se place dans chaque colonne
			@largeur.times{ |j|
				#traite en fonction de l'etatFinal
				if(@matrice[j][i].etatFinal==0)
					cpt+=1
				elsif cpt!=0
					@horizontal[i].push(cpt)
					cpt=0
				end
			}
			#ajoute le dernier bloc si la case est en bout de ligne
			if cpt!=0
				@horizontal[i].push(cpt)
				cpt=0
			end
		}

	end

	# * *Description*:
	#
	# méthode calculant la taille de la matrice
	#
	# * *Retourne* :
	#
	# un entier, le nombre de case dans la matrice
	#
	# * *Exemple*:
	#
	# unEntier=uneGrille.dimension
	#
	def dimension()
		return @taille*@taille
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
		else
			puts "les parametres ne sont pas des indices de la matrice de type entier"
		end
		return self
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
	def modifierXYDroit(abscisse,ordonnee)
		if(abscisse.class==Fixnum && ordonnee.class==Fixnum)
			@retro.push(CoupCroix.nouveau(@matrice[abscisse][ordonnee],@matrice[abscisse][ordonnee].etatCourant,@pile,self))
		else
			puts "les parametres ne sont pas des indices de la matrice de type entier"
		end
		return self
	end

	# * *Description*:
	#
	# méthode verifiant si l'état courant des cases de la matrice correspond à l'état final. Renvoie true si oui, false si non
	#
	# * *Retourne* :
	#
	# un booléen valant vrai si la grille est conforme
	#
	# * *Exemple*:
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

	# * *Description*:
	#
	# méthode verifiant si la disposition des cases noires correspond aux valeurs des tableaux @vertical et @horizontal, cette méthode permet d'avoir plusieurs solutions pour une grille
	#
	# * *Retourne* :
	#
	# un booléen valant vrai si la grille est conforme
	#
	# * *Exemple*:
	#
	# uneGrille.estTerminerMultiSoluce?
	#
	def estTerminerMultiSoluce?
		testV=Array.new
		testH=Array.new
		#creation d'une matrice contenant les blocs de cases noires verticales par indice
		testV=Array.new(largeur){ |i|
			Array.new()
		}
		#creation d'une matrice contenant les blocs de cases noires horizontales par indice
		testH=Array.new(largeur){ |i|
			Array.new()
		}

		cpt=0
		#se place dans chaque colonne
		@largeur.times{ |i|
			#se place dans chaque ligne
			@largeur.times{ |j|
				#traite en fonction de l'etatCourant
				if(@matrice[i][j].etatCourant==0)
					cpt+=1
				elsif cpt!=0
					testV[i].push(cpt)
					cpt=0
				end
			}
			#ajoute le dernier bloc si la case noir se trouve en bout de colonne
			if cpt!=0
				testV[i].push(cpt)
				cpt=0
			end
		}


		cpt=0
		#se place dans chaque ligne
		@largeur.times{ |i|
			#se place dans chaque colonne
			@largeur.times{ |j|
				#traite en fonction de l'etatCourant
				if(@matrice[j][i].etatCourant==0)
					cpt+=1
				elsif cpt!=0
					testH[i].push(cpt)
					cpt=0
				end
			}
			#ajoute le dernier bloc si la case est en bout de ligne
			if cpt!=0
				testH[i].push(cpt)
				cpt=0
			end
		}

		@largeur.times{ |i|
			if testV[i].count != @vertical[i].count
				return false
			else
				testV.count.times{ |j|
					if testV[i][j] != @vertical[i][j]
						return false
					end
				}
			end

			if testH[i].count != @horizontal[i].count
				return false
			else
				testH.count.times{ |j|
					if testH[i][j] != @horizontal[i][j]
						return false
					end
				}
			end
		}
		return true
	end

	# * *Description*:
	#
	# méthode permettant au joueur de voir tous les coups joués au cours de la partie
	#
	# * *Exemple*:
	#
	# uneGrille.retrospective
	#
	def retrospective
		if self.estTerminerMultiSoluce?
			#mise de la grille à zéro
			@matrice.each{ |i|
				i.each{ |j|
					j.etatCourant=1
				}
			}
		end
	end

	# * *Description*:
	#
	# méthode permettant de faire passer le falg des révélation à vrai. "Permet d'activer le mode révélation"
	#
	# * *Exemple*:
	#
	# uneGrille.activerRevelation
	#
	def activerRevelation
		@revel=true
	end

	# * *Description*:
	#
	# méthode permettant de révéler l'etatFinal de la case aux coordonnées (abscisse;ordonnee)
	#
	# * *Paramètres*:
	#
	# - +abscisse+ -> abscisse de la case à reveler
	# - +ordonnee+ -> ordonnée de la case à reveler
	#
	# * *Exemple*:
	#
	# uneGrille.revelerXY(5,5)
	#
	def revelerXY(abscisse, ordonnee)
		if(abscisse.class==Fixnum && ordonnee.class==Fixnum)
			if(@matrice[abscisse][ordonnee].etatFinal==0)
				if(@matrice[abscisse][ordonnee].etatCourant!=@matrice[abscisse][ordonnee].etatFinal)
					@retro.push(Coup.nouveau(@matrice[abscisse][ordonnee],@matrice[abscisse][ordonnee].etatCourant,@pile,self))
				end
			else
				@retro.push(CoupCroix.nouveau(@matrice[abscisse][ordonnee],@matrice[abscisse][ordonnee].etatCourant,@pile,self))
			end
		end
		@revel=false
	end

	# * *Description*:
	#
	# méthode déterminant si des aides sont disponibles dans le jeu
	#
	# * *Retourne* :
	#
	#  un tableau contenant : indice 0 (0 pour colonne, 1 pour ligne), indice 1 (l'indice de la ligne ou la colonne), indice 2 (l'aide sous forme de String). Elle renvoie un tableau contenant que des -1 si aucune aide est disponible.
	#
	# * *Exemple*:
	#
	# unTab=uneGrille.suggestion
	#
	def suggestion
		astuce=Astuce.creer
		aide=Aide.generer(self)


		a=[0,aide.astuceBlocPleinVertical,astuce.astuceBlocPlein]
		return a if(a[1]!=-1)
		a=[1,aide.astuceBlocPleinHorizontal,astuce.astuceBlocPlein]
		return a if(a[1]!=-1)

		a=[0,aide.astuceColonnePleine,astuce.astuceSuiteBloc]
		return a if(a[1]!=-1)
		a=[1,aide.astuceLignePleine,astuce.astuceSuiteBloc]
		return a if(a[1]!=-1)

		a=[0,aide.astuceBordVertical,astuce.astuceBord]
		return a if(a[1]!=-1)
		a=[1,aide.astuceBordHorizontal,astuce.astuceBord]
		return a if(a[1]!=-1)

		a=[0,aide.astuceGrosBlocVertical,astuce.astuceGrosBloc]
		return a if(a[1]!=-1)
		a=[1,aide.astuceGrosBlocHorizontal,astuce.astuceGrosBloc]
		return a if(a[1]!=-1)

		return [-1,-1,-1]

	end

	# * *Description*:
	#
	# méthode d'affichage d'une grille
	#
	# * *Exemple*:
	#
	# uneGrille.to_s
	# puts uneGrille
	#
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
