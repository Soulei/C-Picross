##
# Auteur WAJDI GUEDOUAR
# Version 0.1
# Date : Lundi 11 Janvier 2016
# Description : fihcier contenant la classe Case du le jeu du Picross

class Case 

	#variable d'instance representant l'etat de la case : vide=0 ou pleine=1
	@etat
	#variable d'instance représentant l'état final attendu de la case : vide=0 ou pleine=1
	@reponse
	
	attr_accessor :etat,
	attr_reader :reponse
	
	private_class_method :new
	
	# == Description
	# 
	# méthode de création d'une case
	#
	# == Paramètres
	#
	# * +unEtat+ : état de la case lorsque le Picross sera résolu
	#
	# == Exemple
	#
	# uneCase = Case.creer(1)
	# uneAutreCase = Case.creer(0)
	#
	def Case.creer(unEtat)
		new(unEtat)
	end
	def initialize(unEtat)
		@etat=0
		@reponse=unEtat
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
		self.etat=(@reponse)
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
		(@etat==@reponse)? true : false
	end

end
