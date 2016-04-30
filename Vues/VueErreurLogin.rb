##
# Auteur Youssef LAMNIY
# Version 0.1
# Description : fichier contenant la classe VueErreurLogin Picross

#####   VUEERREURLOGIN.RB   ######


#####   IMPORTS   ######

require_relative 'Vue'

require 'gtk2'
require "glib2"
include Gtk

	# * *Description*:
	# 
 	# VueErreurLogin qui a pour tâche d'afficher une fenêtre erreur lorsque l'utilisateur n'a pas écrit le login.
 	#	
	# * *Retourne*:
	#
	# renvoie la fenêtre dans laquelle il est indiqué à l'utilisateur d'entrer un login valide.
	#
class VueErreurLogin < Vue
    
    
    @btretour    

    attr_reader :btretour
    
    
    def VueErreurLogin.creer()
		new()
	end

	def initialize()
	
		super("Erreur")

        
  		d = Gtk::MessageDialog.new(window, Gtk::Dialog::DESTROY_WITH_PARENT,
                             Gtk::MessageDialog::INFO,
                             Gtk::MessageDialog::BUTTONS_CLOSE,
                             "Veuillez entrer un login valide.")
                             		
		d.run
		d.destroy



	end
	
	
end



