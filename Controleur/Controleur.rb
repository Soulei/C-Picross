##
# Auteur YANN GUENVER
# Version 0.1
# Date : Mardi 26 Janvier 2016
# Description : fichier contenant la classe Controleur du jeu du Picross


class Controleur
	
	@vue
	
	attr :vue
	
	private_class_method :new
	
	def initialize()
		
		
	end
	
	def quitterJeu
		Gtk.main_quit
	end
end
