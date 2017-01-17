# @auteur : Yann GUENVER 
# @version : 0.1
##
# Description : Fichier contenant le controleur login.
#

##### CONTROLEURLOGIN.RB #####

load "./Modele/Jeu.rb"
load "./Vues/VueLogin.rb"
load "./Vues/VueErreurLogin.rb"


require_relative 'Controleur'
require_relative 'ControleurMenu'
require_relative 'ControleurErreurLogin'


class ControleurLogin < Controleur

	# Constructeur
	def ControleurLogin.creer(unJeu)
		new(unJeu)
	end

	def initialize(unJeu)

		super(unJeu,"")

		@vue = VueLogin.creer()


		@vue.btAccepter.signal_connect('clicked'){
			tmp = @vue.etLogin.text
			if tmp != "" then
				if(@jeu.bd.pseudo_present(tmp)) 
					@jeu.bd.save_pseudo(tmp)
					changerControleur(ControleurMenu.creer(@jeu,tmp))
				elsif
					changerControleur(ControleurErreurLogin.creer(@jeu,tmp))
				end
			else
				ControleurErreurLogin.creer()
			end
		}

		# Si on clique sur le bouton retour, on dépile le dernier coup
		@vue.btQuitter.signal_connect('clicked'){
		    quitterJeu
		}

		@vue.window.signal_connect('delete_event') {
			quitterJeu
		}
	end
end
