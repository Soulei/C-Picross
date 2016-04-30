##
# Auteur WAJDI GUEDOUAR
# Version 0.3
# Date : vendredi 4 Mars 2016
# Description : fichier contenant la classe CoupCroix du jeu Picross, un CoupCroix est une action réalisé par le joueur qui cible une case pour changer son état en Croix

require_relative 'Coup_v3'

# CoupCroix, objet modélisant un coup joué par le joueur pour posé une croix dans une partie de Picross
# * *Heritage*	: hérite de la classe Coup
#
class CoupCroix < Coup
	
	# * *Description*:
	# 
	# méthode de création d'un CoupCroix, empile le coup créé dans la pile passée en paramètre et réalise l'action sur la case en modifiant son état courant
	#
	# * *Paramètre*:
	#
	# - +uneCase+ -> case modifiée par le coup
	# - +old+ -> ancien état courant de la case
	# - +unePileDeCoup+ -> pile où le coup sera enregistré
	# - +uneGrille+ -> grille où le coup sera joué
	#
	# * *Retourne* :
	#
	# retourne l'objet Coup nouvellement créé
	#
	# * *Exemple*:
	#
	# unCoupCroix = CoupCroix.nouveau(uneCase,uneCase.etatCourant,unePileDeCoup,maGrille)
	#
	def CoupCroix.nouveau(uneCase,old,unePileDeCoup,uneGrille)
		new(uneCase,old,unePileDeCoup,uneGrille)
	end
	
	def initialize(uneCase,old,unePileDeCoup,uneGrille)
		#test des class des objets passés en paramètre afin qu'ils soient conformes
		if(uneCase.class!=Case || unePileDeCoup.class!=Pile)
			puts "l'un des objets n'a pas la class attendue"
		else
			@grille=uneGrille
			@case = uneCase
			@oldEtat = old
			#empile le coup
			unePileDeCoup.empiler(self)
			#joue le coup en modifiant la case et mettant à croix
			uneCase.setCroix
			@newEtat=uneCase.etatCourant
		end
 	end
end

