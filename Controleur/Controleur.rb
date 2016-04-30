##
# Auteur YANN GUENVER
# Version 0.1
# Date : Mardi 26 Janvier 2016
# Description : fichier contenant la classe Controleur du jeu du Picross

load "./Modele/BaseDonnee.rb"

# Classe Controleur
# * *Variables*	:
#    - +vue+ -> Vue que le controleur lance
#    - +jeu+ -> Jeu du Picross
#    - +joueur+ -> Pseudonyme du joueur
# * *Heritage*	: 
#
class Controleur
	
	@vue
	@jeu
	@joueur
	
	attr :vue
	
	private_class_method :new
	
	# Méthode de création d'un Controleur
	#
	# * *Paramètres*:
	# - +unJeu+ -> Le jeu du Picross
	# - +unJoueur+ -> Le pseudonyme du joueur
	# * *Exemple* :
	#
	def Controleur.creer(unJeu,unJoueur)
		new(unJeu,unJoueur)
	end
	
	def initialize(unJeu,unJoueur)
		@jeu=unJeu
		@joueur=unJoueur
		
		# Méthode de changement d'un Controleur
		#
		# * *Paramètres*:
		# - +unControleur+ -> Le jeu du Picross
		# * *Exemple* :
		#
		def changerControleur(unControleur)
			@vue.fermerFenetre
			@jeu.controleur=unControleur
		end
	end
	
	# Quitte le jeu
	#
	# * *Paramètres*:
	#
	# * *Retourne* :
	#  
	#* *Exemple* :
	#
	def quitterJeu
		Gtk.main_quit
	end
end
