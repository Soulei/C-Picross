##
# Auteur WAJDI GUEDOUAR
# Version 0.1
# Date : mardi 26 Janvier 2016
# Description : fichier contenant la class Joueur d'une partie de Picross

class Joueur
	#pseudo du joueur
	@pseudo
	#tableau des highScores
	@score
	
	attr_reader :pseudo, :score
	private_class_method :new
	
	# == Description
	#
	# méthode de création d'un joueur
	#
	# == Paramètre
	#
	# * +unPseudo+ : pseudo du joueur 
	#
	# == Exemple
	#
	# unJoueur=Joueur.creer("Wajdi")
	#
	def Joueur.creer(unPseudo)
		new(unPseudo)
	end
	def initialize(unPseudo)
		@pseudo=unPseudo
		@score=Array.new(5){ |i|
			i=0
		}
	end
	
	# == Description
	#
	# méthode permettant d'ajouter un score dans les stats du joueur, ajout seulement si le score est passé en paramètre est meilleur que celui contenu dans le tableau, renvoie true si le score a bien été ajouté dans le tableau
	#
	# == Paramètre
	#
	# * +unScore+ : score à ajouter
	# * +uneTaille+ : taille de la matrice où a été réalisé le score
	#
	# == Exemple
	#
	# unJoueur.ajoutScrore(score,10)
	#
	def ajoutScore(unScore,uneTaille)
		indice=(uneTaille/5)-1
		if(@score[indice] < unScore)
			@score[indice]=unScore
		end
	end
	
	# == Description
	#
	# méthode d'affiche d'un objet Joueur affichant seulement son pseudo
	#
	# == Exemple
	#
	# print unJoueur
	# unJoueur.to_s
	#
	def to_s
		"Joueur : #{@pseudo} "
	end
	
	# == Description
	#
	# méthode de comparaison de l'objet Joueur
	#
	# == Paramètre
	#
	# * +unJoueur+ : joueur auquel on souhaite être comparer
	#
	# == Exemple
	#
	# unJoueur==unAutreJoueur
	#
	def <=>(unJoueur)
		return self.pseudo==unJoueur.pseudo
	end
end
