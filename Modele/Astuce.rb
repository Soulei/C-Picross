#!/bin/env ruby
# encoding: utf-8

##
# Auteur WAJDI GUEDOUAR
# Version 0.1
# Date : Jeudi 17 Mars 2016
# Description : fichier contenant la classe d'Astuce du Picross


#
# Grille, une grille de Picross
# * *Variable*	:
#    - none
# * *Heritage*	: Aucun lien
#
class Astuce

	private_class_method :new
	
	# * *Description*:
	# 
	# méthode créant un objet Asctuce donnant accès aux astuces
	#
	# * *Exemple*:
	#
	# monAstuce=Astuce.creer()
	#
	def Astuce.creer()
		new()
	end
	def initialize
	end
	
	# * *Description*:
	# 
	# méthode renvoyant l'astuce pour le cas ou la taille du bloc est celle de la grille
	#
	# * *Exemple*:
	#
	# uneAstuce=monAstuce.astuceBlocPlein
	#
	def astuceBlocPlein
		return "BlocPlein"
	end
	
	# * *Description*:
	# 
	# méthode renvoyant l'astuce pour le cas ou une case noircie en bordure et de la grille appartient à un bloc
	#
	# * *Exemple*:
	#
	# uneAstuce=monAstuce.astuceBord
	#
	def astuceBord
		return "Bord"
	end
	
	# * *Description*:
	# 
	# méthode renvoyant l'astuce pour le cas ou la taille du bloc est supérieur à la moitié de la grille
	#
	# * *Exemple*:
	#
	# uneAstuce=monAstuce.astuceGrosBloc
	#
	def astuceGrosBloc
		return "GrosBloc"
	end
	
	# * *Description*:
	# 
	# méthode renvoyant l'astuce pour le cas ou les blocs consécutifs remplissent totalement la grille
	#
	# * *Exemple*:
	#
	# uneAstuce=monAstuce.astuceSuiteBloc
	#
	def astuceSuiteBloc
		return "SuiteBloc"
	end
	
	
	# * *Description*:
	# 
	# méthode probablement inutile (je le saurais si c'était le cas)
	#
	# * *Paramètre*:
	#
	# - +unEntier+ -> entier permettant d'acceder à l'une des aides
	#
	# * *Exemple*:
	#
	# uneAstuce=monAstuce.getAstuce(unEntier)
	#
	def getAstuce(unEntier)
		case unEntier
		when 0
			return self.astuceBord
		when 1
			return self.astuceSuiteBloc
		when 2
			return self.astuceBlocPlein
		when 3
			return self.astuceGrosBloc
		end
	end
end
