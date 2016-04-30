##
# Auteur WAJDI GUEDOUAR
# Version 0.3
# Date : samedi 23 Janvier 2016
# Description : fichier contenant la class Coup du jeu Picross, un Coup est une action réalisé par le joueur qui cible une case pour changer son état

require_relative 'Case_v2'

# Coup, objet modélisant un coup joué par le joueur dans une partie de Picross
# * *Variable*	:
#    - +grille+ -> variable d'instance representant la grille où sont joués les coups
#    - +case+ -> variable d'instance representant la case modifiée par le coup joué
#    - +oldEtat+ -> variable d'instance representant l'état de la case avant que le coup ne soit joué
#    - +newEtat+ -> variable d'instance representant l'état de la case après que le coup ait été joué
# * *Heritage*	: Aucun lien
#
class Coup
	#grille contenant la case
	@grille
	#case modifiée par le coup
	@case
	#ancien etat de la case
	@oldEtat
	#nouvel etat de la case (pour retrospective)
	@newEtat
	
	attr_reader :case, :oldEtat, :newEtat, :grille
	
	private_class_method :new


	# * *Description*:
	# 
	# méthode de création d'un coup, empile le coup créé dans la pile passée en paramètre et réalise l'action sur la case en modifiant son état courant
	#
	# * *Paramètre*:
	#
	# - +uneCase+ -> case modifiée par le coup
	# - +old+ -> ancien etatCourant de la case
	# - +unePileDeCoup+ -> pile où le coup sera enregistré
	# - +uneGrille+ -> grille où le coup sera joué
	#
	# * *Retourne* :
	#
	# retourne l'objet Coup nouvellement créé
	#
	# * *Exemple*:
	#
	# unCoup = Coup.nouveau(uneCase,uneCase.etatCourant,unePileDeCoup)
	#
	def Coup.nouveau(uneCase,old,unePileDeCoup,uneGrille)
		new(uneCase,old,unePileDeCoup,uneGrille)
	end
	
	def initialize(uneCase,old,unePileDeCoup,uneGrille)
		#test des class des objets passés en paramètre afin qu'ils soient conformes
		if(uneCase.class!=Case || unePileDeCoup.class!=Pile)
			puts "l'un des objets n'a pas la class attendue"
		else
			@grille=uneGrille
			@case = uneCase
			@oldEtat=old
			#empile le coup
			unePileDeCoup.empiler(self)
			#joue le coup en modifiant la case
			uneCase.changeEtat
			@newEtat=uneCase.etatCourant
		end
	end
	
	# * *Description*:
	# 
	# méthode annulant l'action réalisée par le coup
	#
	# * *Exemple*:
	#
	# unCoup.annuler()
	#
	def annuler()
		#ayant trois états, la case devra changer d'état deux fois pour revenir à son état avant d'avoir joué le coup
		@grille.matrice[@case.abscisse][@case.ordonne].etatCourant=@oldEtat
		return self
	end
end
