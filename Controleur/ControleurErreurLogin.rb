##
# Auteur YOUSSEF LAMNIY
# Description : fichier contenant la classe ControleurErreurLogin du Picross

######   CONTROLEURERREURLOGIN.RB   ######


load "./Vues/VueErreurLogin.rb"

require_relative 'Controleur'
require_relative 'ControleurJeu'

class ControleurErreurLogin < Controleur
    
	def ControleurErreurLogin.creer()
		new()
	end

    def initialize()
		
		super(nil,"")
		
		@vue = VueErreurLogin.creer()
		
		
		#@vue.btretour.signal_connect('clicked') {
		#	changerControleur(ControleurMenu.creer(@jeu,@joueur))
		#}
		
		@vue.window.signal_connect('delete_event') {
			@vue.fermerFenetre
		}
		
	end
	
end

