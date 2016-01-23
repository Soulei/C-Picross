##
# Auteur WAJDI GUEDOUAR
# Version 0.1
# Date : Lundi 11 Janvier 2016
# Description : fichier contenant la classe Case du jeu du Picross

class Case 

	#variable d'instance representant l'etat de la case : vide=0 (blanche) ou pleine=1 (noire)
	@etatCourant
	#variable d'instance représentant l'état final attendu de la case : vide=0 ou pleine=1
	@etatFinal
	
	attr_accessor :etat,
	attr_reader :reponse
	
	private_class_method :new
	
	# == Description
	# 
	# méthode de création d'une case
	#
	# == Paramètres
	#
	# * +unEtat+ : état final de la case lorsque le Picross sera résolu
	#
	# == Exemple
	#
	# uneCaseNoire = Case.creer(1)
	# uneCaseBlanche = Case.creer(0)
	#
	def Case.creer(unEtat)
		new(unEtat)
	end
	def initialize(unEtat)
		@etatCourant=0
		@etatFinal=unEtat
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
		(@etatCourant==@etatFinal)? true : false
	end
	
	def to_s()
		"#{@etatCourant}"
	end
end
