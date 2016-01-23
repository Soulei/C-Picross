##
# Auteur WAJDI GUEDOUAR
# Version 0.1
# Date : Lundi 23 Janvier 2016
# Description : fichier contenant les classes Pile, PileCoup et PileCase du jeu Picross

load "Coup.rb"
load "Case.rb"

class Pile

	#tableau modélisant la pile
	@pile 
	
	private_class_method :new
	
	# == Description
	# 
	# méthode de création d'une pile
	#
	# == Exemple
	#
	# unePile=Pile.creer()
	#
	def Pile.creer()
		new()
	end

	def initialize()
		@pile=Array.new()
	end
	
	# == Description
	# 
	# méthode retournant le sommet de la pile sans le retirer
	#
	# == Exemple
	#
	# unObjet=unePile.sommet()
	#
	def sommet()
		return @pile.last
	end
	
	# == Description
	# 
	# méthode retournant et retirant le sommet de la pile
	#
	# == Exemple
	#
	# unObjet=unePile.depiler()
	#
	def depiler()
		return @pile.pop
	end
	
	# == Description
	# 
	# méthode retournant la taille de la pile
	#
	# == Exemple
	#
	# uneTaille=unePile.taille()
	#
	def taille()
		return @pile.length
	end
	
	# == Description
	# 
	# méthode testant si la pile est vide
	#
	# == Exemple
	#
	# unBooleen=unePile.estVide?()
	#
	def estVide?()
		return @pile.empty
	end
	
	# == Description
	# 
	# méthode remettant la pile a vide
	#
	# == Exemple
	#
	# unePile.viderPile()
	#
	def viderPile!()
		@pile.clear
	end
end

class PileCoup < Pile

	# == Description
	# 
	# méthode de création d'une pile de Coup
	#
	# == Exemple
	#
	# unePileDeCoup=PileCoup.creer()
	#
	def PileCoup.creer()
		new()
	end
	
	def initialize()
		super()
	end
	
	# == Description
	# 
	# méthode permettant d'ajouter un coup dans la pile
	#
	# == Paramètre
	#
	# * +unCoup+ : coup joué par la joueur que l'on souhaite empiler
	#
	# == Exemple
	#
	# unePileDeCoup.empiler(unCoup)
	# 
	#
	def empiler(unCoup)
		if(unCoup.class==Coup)
			@pile.push(unCoup)
		else
			puts "l'objet à empiler n'est pas de class Coup"
		end
		return self
	end
end

class PileCase < Pile

	# == Description
	# 
	# méthode de création d'une pile de Case
	#
	# == Exemple
	#
	# unePileDeCase=PileCase.creer()
	#
	def PileCase.creer()
		new()
	end
	
	def initialize()
		super()
	end
	
	# == Description
	# 
	# méthode permettant d'ajouter une Case dans la pile
	#
	# == Paramètre
	#
	# * +uneCase+ : case que l'on souhaite empiler
	#
	# == Exemple
	#
	# unePileDeCase.empiler(uneCase)
	# 
	#
	def empiler(uneCase)
		if(uneCase.class==Case)
			@pile.push(uneCase)
		else
			puts "l'objet à empiler n'est pas de class Case"
		end
		return self
	end
end
