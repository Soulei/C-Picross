##
# Auteur WAJDI GUEDOUAR
# Version 0.2
# Date : Lundi 11 Janvier 2016
# Description : fichier contenant la classe Case du jeu du Picross


#
# Case, objet modélisant une case de Picross
# * *Variables*	:
#    - +etatCourant+ -> variable d'instance representant l'etat de la case : noire=0 , vide=1, croix=2
#    - +etatFinal+ -> variable d'instance représentant l'état final attendu de la case : vide=1 (blanche) ou pleine=0 (noire)
#    - +abscisse+ -> variable d'instance representant l'abscisse de la case dans la grille
#    - +ordonne+ -> variable d'instance représentant l'ordonne de la case dans la grille
# * *Heritage*	: Aucun lien
#
class Case 

	#variable d'instance representant l'etat de la case : noire=0 , vide=1, croix=2
	@etatCourant
	#variable d'instance représentant l'état final attendu de la case : vide=1 (blanche) ou pleine=0 (noire)
	@etatFinal
	#variable d'instance representant l'abscisse de la case dans la grille
	@abscisse
	#variable d'instance représentant l'ordonne de la case dans la grille
	@ordonne
	
	
	attr_accessor :etatCourant, :etatFinal
	attr_reader :abscisse, :ordonne
	
	private_class_method :new
	
	# * *Description*:
	# 
	# méthode de création d'une case
	#
	# * *Paramètre*:
	#
	# - +unEtatFinal+ -> état final de la case lorsque le Picross sera résolu
	# - +unAbsc+ -> abscisse de la case dans la matrice
	# - +uneOrdo+ -> ordonne de la case dans la matrice
	#
	# * *Retourne* :
	#
	# la case nouvellement créée
	#
	# * *Exemple*:
	#
	# uneCaseNoire = Case.creer(1,10,maGrille)
	# uneCaseBlanche = Case.creer(0,11,maGrille)
	#
	def Case.creer(unEtatFinal,unAbsc,uneOrdo)
		new(unEtatFinal,unAbsc,uneOrdo)
	end
	def initialize(unEtatFinal,unAbsc,uneOrdo)
		#initialisation à blanche
		@etatCourant=1
		#recuperation de l'etat final
		@etatFinal=unEtatFinal
		@abscisse=unAbsc
		@ordonne=uneOrdo
	end

	# * *Description*:
	# 
	# méthode permettant de reveler la solution de la case
	#
	# * *Retourne* :
	#
	# renvoie l'objet Case
	#
	# * *Exemple*:
	#
	# uneCase.reveleToi
	#
	def reveleToi
		self.etatCourant=(@etatFinal)
		return self
	end
	
	# * *Description*:
	# 
	# méthode permettant de changer l'état courant de la case, la faisant passer à Noire si Blanc et inversement
	#
	# * *Retourne* :
	#
	# renvoie l'objet Case
	#
	# * *Exemple*:
	#
	# uneCase.changeEtat
	#
	def changeEtat
		(@etatCourant==0)? self.etatCourant=(1) : self.etatCourant=(0)
		return self
	end
	
	# * *Description*:
	# 
	# méthode permettant de savoir si l'état de la case est valide ou non (égale à l'état finale attendu)
	#
	# * *Retourne* :
	#
	# renvoie un booléen, true si la case à l'état attendu, false si non
	#
	# * *Exemple*:
	#
	# uneCase.estValide?
	#
	def estValide?
		if @etatFinal==0
			return(@etatCourant==@etatFinal)
		else
			return(@etatCourant==1 || @etatCourant==2)
		end
	end
	
	# * *Description*:
	# 
	# méthode mettant l'état courant à 2, c'est-à-dire à croix.
	#
	# * *Exemple*:
	#
	# uneCase.estCroix
	#
	def setCroix
		self.etatCourant=2
	end
	
	# * *Description*:
	# 
	# méthode de comparaison d'une case
	#
	# * *Paramètre*:
	#
	# - +uneCase+ -> case à comparer
	#
	# * *Exemple*:
	#
	# uneCase > uneAutreCase
	# uneCase == uneAutreCase
	# uneCase <= uneAutreCase
	#
	def <=>(uneCase)
		return self.etatCourant==uneCase.etatCourant
	end
	
	# * *Description*:
	# 
	# méthode d'affichage d'une case
	#
	# * *Exemple*:
	#
	# uneCase.to_s
	# puts uneCase
	#
	def to_s()
		"#{@etatFinal} "
	end
end

