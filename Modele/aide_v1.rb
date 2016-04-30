##
# Auteur WAJDI GUEDOUAR
# Version 0.1
# Date : Jeudi 17 Mars 2016
# Description : fichier contenant la classe d'aide du Picross

#NE PAS UTILISER ESTVALIDE CAR NE CONSIDERE PAS LES SOLUTIONS MULTIPLES A CORRIGER !!!!!!

#
# Grille, une grille de Picross
# * *Variable*	:
#    - +grille+ -> objet Grille où les aides interviendront
# * *Heritage*	: Aucun lien
#
class Aide
	#objet grille concernée par les aides
	@grille
	
	private_class_method :new
	def Aide.generer(uneGrille)
		new(uneGrille)
	end
	def initialize(uneGrille)
		@grille=uneGrille
	end
	
	# * *Description*:
	# 
	# méthode renvoyant la colonne où est applicable l'astuce X, c'est-à-dire les cas où la premiere case de la colonne est noir et correct, et où la taille du premier bloc est supérieur à 1
	#
	# * *Exemple*:
	#
	# rangColonne=uneAide.astuceBordVertical
	#
	# * *Retourne*:
	#
	# renvoie la premiere colonne où l'astuce est possible, -1 aucune colonne n'est compatible
	#
	def astuceBordVertical
		#tableau contenant les indices verticaux
		verti=@grille.vertical
		#matrice de la grille
		mat=@grille.matrice
		#compteur de colonne
		colonne=-1
		
		while(true)
			colonne+=1
			#si colonne est toujours dans le tableau
			if(colonne>=@grille.largeur)
				return -1
			#si la colonne contient des blocs de cases noires et que le premier bloc est de taille supérieur à 1
			elsif(verti[colonne].empty? == false && (verti[colonne][0]>1 || verti[colonne][-1]>1))
				#si la première case est déjà noire et correct
				if(mat[colonne][0].etatCourant==0 )#&& mat[colonne][0].etatFinal==0
					#test si le bloc n'est pas déjà correctement placé
					#la valeur sont à 1 car le test de l'indice 0 à déjà été fait au dessus
					cpt=1
					i=1
					while(i<@grille.largeur && mat[colonne][i].etatCourant==0)
						i+=1
						cpt+=1
					end
					if(cpt<verti[colonne][0])
						return colonne
					else
						return -1
					end
				#meme principe dans le cas ou il s'agirant du dernier bloc de la colonne
				elsif(mat[colonne][-1].etatCourant==0 )#&& mat[colonne][-1].etatFinal==0
					#test si le bloc n'est pas déjà correctement placé
					#la valeur sont à 1 car le test de l'indice -1 à déjà été fait au dessus
					cpt=1
					i=-2
					while(i>-1 && mat[colonne][i].etatCourant==0)
						i-=1
						cpt+=1
					end
					if(cpt<verti[colonne][-1])
						return colonne
					else
						return -1
					end
				end 
			end
		end
	end
	
	# * *Description*:
	# 
	# méthode renvoyant la ligne où est applicable l'astuce X, c'est-à-dire les cas où la premiere case de la lign est noir et correct, et où la taille du premier bloc est supérieur à 1
	#
	# * *Exemple*:
	#
	# rangLigne=uneAide.astuceBordHorizontal
	#
	# * *Retourne*:
	#
	# renvoie la premiere ligne où l'astuce est possible, -1 aucune ligne n'est compatible
	#
	def astuceBordHorizontal
		#tableau contenant les indices verticaux
		horiz=@grille.horizontal
		#matrice de la grille
		mat=@grille.matrice
		#compteur de ligne
		ligne=-1
		
		while(true)
			ligne+=1
			#si ligne est toujours dans le tableau
			if(ligne>=@grille.largeur)
				return -1
			#si la ligne contient des blocs de cases noires et que le premier bloc est de taille supérieur à 1
			elsif(horiz[ligne].empty? == false && (horiz[ligne][0]>1 || horiz[ligne][-1]>1))
				#si la première case est déjà noire et correct
				if(mat[0][ligne].etatCourant==0)# && mat[0][ligne].etatFinal==0
					cpt=1
					i=1
					while(i<@grille.largeur && mat[i][ligne].etatCourant==0)
						i+=1
						cpt+=1
					end
					if(cpt<horiz[ligne][0])
						return ligne
					else
						return -1
					end
				#cas ou il s'agirait de la dernière case de la ligne
				elsif(mat[-1][ligne].etatCourant==0 )#&& mat[-1][ligne].etatFinal==0
					cpt=1
					i=-2
					while(i>=(- @grille.largeur) && mat[i][ligne].etatCourant==0)
						i-=1
						cpt+=1
					end
					if(cpt<horiz[ligne][-1])
						return ligne
					else
						return -1
					end
				end 
			end
		end
	end
	
	# * *Description*:
	# 
	# méthode testant si la possibilité de disposition des blocs est unique 
	#
	# * *Exemple*:
	#
	# rangColonne=uneAide.astuceColonnePleine
	#
	# * *Retourne*:
	#
	# renvoie la premiere colonne où l'astuce est possible, -1 aucune colonne n'est compatible
	#
	def astuceColonnePleine
		#nombre de blanc entre les blocs
		nbVide=-1
		#nombre de case noire totale 
		nbNoire=0
		#tableau contenant les indices verticaux
		verti=@grille.vertical
		#matrice de la grille
		mat=@grille.matrice
		#compteur de colonne
		colonne=-1
		
		while(true)
			colonne+=1
			nbVide=-1
			nbNoire=0
			if(colonne>=@grille.largeur)
				return -1
			elsif(verti[colonne].empty? == false)
				verti[colonne].each{ |i|
					nbNoire+=i
					nbVide+=1
				}
				if(nbNoire+nbVide == @grille.largeur)
					mat[colonne].each{|i|
						if(!i.estValide?)
							return colonne
						end
					}
					return -1
				end
			end
		end
	end
	
	# * *Description*:
	# 
	# méthode testant si la possibilité de disposition des blocs est unique 
	#
	# * *Exemple*:
	#
	# rangLigne=uneAide.astuceLignePleine
	#
	# * *Retourne*:
	#
	# renvoie la premiere ligne où l'astuce est possible, -1 aucune ligne n'est compatible
	#
		def astuceLignePleine
		#nombre de blanc entre les blocs
		nbVide=-1
		#nombre de case noire totale 
		nbNoire=0
		#tableau contenant les indices horizontaux
		horiz=@grille.horizontal
		#matrice de la grille
		mat=@grille.matrice
		#compteur de ligne
		ligne=-1
		
		while(true)
			ligne+=1
			nbVide=-1
			nbNoire=0
			if(ligne>=@grille.largeur)
				return -1
			elsif(horiz[ligne].empty? == false)
				horiz[ligne].each{ |i|
					nbNoire+=i
					nbVide+=1
				}
				if(nbNoire+nbVide == @grille.largeur)
					0.upto((@grille.largeur)-1){ |j|
						if(!mat[j][ligne].estValide?)
							return ligne
						end
					}
					return -1
				end
			end
		end
	end
	
	# * *Description*:
	# 
	# méthode testant si une colonne contient un unique bloc de taille égale à la largeur de la matrice
	#
	# * *Exemple*:
	#
	# rangColonne=uneAide.astuceBlocPleinVertical
	#
	# * *Retourne*:
	#
	# renvoie la premiere colonne où l'astuce est possible, -1 aucune colonne n'est compatible
	#
	def astuceBlocPleinVertical
		#tableau contenant les indices verticaux
		verti=@grille.vertical
		#matrice de la grille
		mat=@grille.matrice
		#compteur de colonne
		colonne=-1
		
		while(true)
			colonne+=1
			if(colonne>=@grille.largeur)
				return -1
			elsif(verti[colonne].empty? == false && verti[colonne].length == 1 && verti[colonne][0]==@grille.largeur)
				#test si le bloc n'a pas déjà été placé
				mat[colonne].each{ |i|
					if(!i.estValide?)
						return colonne
					end
				}
				return -1
			end
		end
	end
	
	# * *Description*:
	# 
	# méthode testant si une ligne contient un unique bloc de taille égale à la largeur de la matrice
	#
	# * *Exemple*:
	#
	# rangLigne=uneAide.astuceBlocPleinHorizontal
	#
	# * *Retourne*:
	#
	# renvoie la premiere ligne où l'astuce est possible, -1 aucune ligne n'est compatible
	#
	def astuceBlocPleinHorizontal
		#tableau contenant les indices horizontaux
		horiz=@grille.horizontal
		#matrice de la grille
		mat=@grille.matrice
		#compteur de ligne
		ligne=-1
		
		while(true)
			ligne+=1
			if(ligne>=@grille.largeur)
				return -1
			elsif(horiz[ligne].empty? == false && horiz[ligne].length == 1 && horiz[ligne][0]==@grille.largeur)
				xyz=(@grille.largeur)-1
				0.upto(xyz){ |i|
					if(!(mat[i][ligne].estValide?))
						return ligne
					end
				}
				return -1
			end
		end
	end
	
	# * *Description*:
	# 
	# méthode testant si un bloc est de taille supérieur à la moitié de la grille
	#
	# * *Exemple*:
	#
	# rangColonne=uneAide.astuceGrosBlocVertical
	#
	# * *Retourne*:
	#
	# renvoie la premiere colonne où l'astuce est possible, -1 aucune colonne n'est compatible
	#
	def astuceGrosBlocVertical
		#tableau contenant les indices verticaux
		verti=@grille.vertical
		#matrice de la grille
		mat=@grille.matrice
		#compteur de colonne
		colonne=-1
		
		while(true)
			colonne+=1
			tailleBloc=0
			if(colonne>=@grille.largeur)
				return -1
			elsif(verti[colonne].empty? == false && verti[colonne].length == 1)
				if(verti[colonne][0]>(@grille.largeur)/2)
					#test si les cases n'ont pas encore été noircie
					nbCaseNoire=verti[colonne][0]-(@grille.largeur-verti[colonne][0])   
					deb=@grille.largeur - verti[colonne][0]
					cpt=0 
					if((@grille.largeur)%2==0)
						deb.upto(deb+nbCaseNoire -1){ |i|
							if(mat[colonne][i].etatCourant==0)
								cpt+=1
							end
						}
					else
						deb.upto(deb+nbCaseNoire-1){ |i|
							if(i > 0 && mat[colonne][i].etatCourant==0)
								cpt+=1
							end
						}
						
					end
					if cpt == nbCaseNoire 
						return -1 
					end
					return colonne
				end	
			end
		end
	end
	
	# * *Description*:
	# 
	# méthode testant si un bloc est de taille supérieur à la moitié de la grille
	#
	# * *Exemple*:
	#
	# rangLigne=uneAide.astuceGrosBlocHorizontal
	#
	# * *Retourne*:
	#
	# renvoie la premiere ligne où l'astuce est possible, -1 aucune ligne n'est compatible
	#
	def astuceGrosBlocHorizontal
		#tableau contenant les indices verticaux
		horiz=@grille.horizontal
		#matrice de la grille
		mat=@grille.matrice
		#compteur de ligne
		ligne=-1
		
		while(true)
			ligne+=1
			tailleBloc=0
			if(ligne>=@grille.largeur)
				return -1
			elsif(horiz[ligne].empty? == false && horiz[ligne].length == 1)	
				if(horiz[ligne][0]>(@grille.largeur)/2)
					#test si les cases n'ont pas encore été noircie
					nbCaseNoire=horiz[ligne][0]-(@grille.largeur-horiz[ligne][0])   
					deb=@grille.largeur - horiz[ligne][0]
					cpt=0 
					if((@grille.largeur)%2==0)
						deb.upto(deb+nbCaseNoire -1){ |i|
							if(mat[i][ligne].etatCourant==0)
								cpt+=1
							end
						}
					else
						deb.upto(deb+nbCaseNoire-1){ |i|
							if(i > 0 && mat[i][ligne].etatCourant==0)
								cpt+=1
							end
						}
						
					end
					if cpt == nbCaseNoire 
						return -1 
					end
					return ligne
				end	
			end
		end
	end
	
	# * *Description*:
	# 
	# méthode testant si un bloc est de taille supérieur à la moitié de la grille
	#
	# * *Exemple*:
	#
	# rangColonne=uneAide.astuceSuiteBlocVerticaux
	#
	# * *Retourne*:
	#
	# renvoie la premiere colonne où l'astuce est possible, -1 aucune colonne n'est compatible
	#
	def astuceSuiteBlocVerticaux
		#nombre de blanc entre les blocs
		nbVide=-1
		#nombre de case noire totale 
		nbNoire=0
		#tableau contenant les indices verticaux
		verti=@grille.vertical
		#matrice de la grille
		mat=@grille.matrice
		#compteur de colonne
		colonne=-1
		#plus gros bloc de case 
		blocMax=0
		
		while(true)
			colonne+=1
			nbVide=0
			nbNoire=0
			blocMax=0
			if(colonne>=@grille.largeur)
				return -1
			elsif(verti[colonne].empty? == false)
				verti[colonne].each{ |i|
					nbNoire+=i
					nbVide+=1
					blocMax=i if i > blocMax
				}
				if(@grille.largeur - nbNoire+nbVide < blocMax )
					return colonne
				end
			end
		end
	end
	
	# * *Description*:
	# 
	# méthode testant si un bloc est de taille supérieur à la moitié de la grille
	#
	# * *Exemple*:
	#
	# rangLigne=uneAide.astuceSuiteBlocHorizontaux
	#
	# * *Retourne*:
	#
	# renvoie la premiere ligne où l'astuce est possible, -1 aucune ligne n'est compatible
	#
	def astuceSuiteBlocHorizontaux
		#nombre de blanc entre les blocs
		nbVide=-1
		#nombre de case noire totale 
		nbNoire=0
		#tableau contenant les indices horizontaux
		horiz=@grille.horizontal
		#matrice de la grille
		mat=@grille.matrice
		#compteur de ligne
		ligne=-1
		#plus gros bloc de case 
		blocMax=0
		
		while(true)
			ligne+=1
			nbVide=0
			nbNoire=0
			blocMax=0
			if(ligne>=@grille.largeur)
				return -1
			elsif(horiz[ligne].empty? == false)
				horiz[ligne].each{ |i|
					nbNoire+=i
					nbVide+=1
					blocMax=i if i > blocMax
				}
				if(@grille.largeur - nbNoire+nbVide < blocMax )
					return ligne
				end
			end
		end
	end
end
