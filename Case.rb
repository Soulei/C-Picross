##
# Auteur WAJDI GUEDOUAR
# Version 0.1
# Date : Lundi 11 Janvier 2016
# Description : fichier contenant la classe Case du jeu du Picross

class Case 

	#variable d'instance representant l'etat de la case : vide=0 (blanche) ou pleine=1 (noire)
	@etatCourant
	#variable d'instance représentant l'état final attendu de la case : vide=0 (blanche) ou pleine=1 (noire)
	@etatFinal
	
	attr_accessor :etatCourant
	attr_reader :etatFinal
	
	private_class_method :new
	
	# == Description
	# 
	# méthode de création d'une case
	#
	# == Paramètres
	#
	# * +unEtatFinal+ : état final de la case lorsque le Picross sera résolu
	#
	# == Exemple
	#
	# uneCaseNoire = Case.creer(1)
	# uneCaseBlanche = Case.creer(0)
	#
	def Case.creer(unEtatFinal)
		new(unEtatFinal)
	end
	def initialize(unEtatFinal)
		@etatCourant=0
		@etatFinal=unEtatFinal
	end

	# == Description
	# 
	# méthode permettant de reveler la solution de la case
	#
	# == Exemple
	#
	# uneCase.reveleToi
	#
	def reveleToi
		self.etatCourant=(@etatFinal)
		return self
	end
	
	# == Description
	# 
	# méthode permettant de changer l'état courant de la case, la faisant passer à Noire si Blanc et inversement
	#
	# == Exemple
	#
	# uneCase.changeEtat
	#
	def changeEtat
		(@etatCourant==0)? self.etatCourant=(1) : self.etatCourant=(0)
		return self
	end
	
	# == Description
	# 
	# méthode permettant de savoir si l'état de la case est valide ou non (égale à l'état finale attendu)
	#
	# == Exemple
	#
	# uneCase.estValide?
	#
	def estValide?
		return (@etatCourant==@etatFinal)
	end
	
	# == Description
	# 
	# méthode de comparaison d'une case
	#
	# == Paramètres
	#
	# * +uneCase+ : case à comparer
	#
	# == Exemple
	#
	# uneCase > uneAutreCase
	# uneCase == uneAutreCase
	# uneCase <= uneAutreCase
	#
	def <=>(uneCase)
		return self.etatCourant==uneCase.etatCourant
	end
	
	def to_s()
		"#{@etatFinal} "
	end
end
