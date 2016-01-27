##
# Auteur WAJDI GUEDOUAR
# Version 0.1
# Date : samedi 23 Janvier 2016
# Description : fichier contenant la class Coup du jeu Picross, un Coup est une action réalisé par le joueur qui cible une case pour changer son état

load "Case.rb"

class Coup
	#case modifiée par le coup
	@case
	
	attr_reader :case
	
	private_class_method :new


	# == Description
	# 
	# méthode de création d'un coup, empile le coup créé dans la pile passée en paramètre et réalise l'action sur la case en modifiant son état courant
	#
	# == Paramètres
	#
	# * +uneCase+ : case modifiée par le coup
	# * +uneAction+ : nouvel état de la case une fois le coup joué
	# * +unePileDeCoup+ : pile où le coup sera enregistré
	#
	# == Exemple
	#
	# unCoup = Coup.nouveau(uneCase,0,unePileDeCoup)
	# unCoup = Coup.nouveau(uneCase,1,unePileDeCoup)
	#
	def Coup.nouveau(uneCase,unePileDeCoup)
		new(uneCase,unePileDeCoup)
	end
	
	def initialize(uneCase,unePileDeCoup)
		#test des class des objets passés en paramètre afin qu'ils soient conformes
		if(uneCase.class!=Case || unePileDeCoup.class!=PileCoup)
			puts "l'un des objets n'a pas la class attendue"
		else
			@case = uneCase
			#empile le coup
			unePileDeCoup.empiler(self)
			#joue le coup
			uneCase.changeEtat
		end
	end
	
	# == Description
	# 
	# méthode annulant l'action réalisée par le coup
	#
	# == Exemple
	#
	# unCoup.annuler()
	#
	def annuler()
		@case.changeEtat
		return self
	end
end
