
# Definition de la classe permettant de demander à l'utilisateur s'il confirme la création du profil.

	
#################################
# IMPORTS			#
#################################
require "gtk2"
require "glib2"

include Gtk


#################################
# CONFIRMERNOUVEAUPROFIL        #
#################################

class ConfirmerNouveauProfil

  #Impossible de créer une instance de classe.
	private_class_method :new


	## 
	# Prend une instance de classe Picross en paramètre.
	# Retourne vrai si l'utilisateur souhaite créer le profil.
	def ConfirmerNouveauProfil.show(parent, nom_profil)
		operation_choisie = Dialog::RESPONSE_OK

		#Vérification de création de profil.
		dialog = Dialog.new(
			"Création de profil", 
			parent,
			Dialog::DESTROY_WITH_PARENT | Dialog::MODAL,
			[Stock::OK, Dialog::RESPONSE_OK], 
			[Stock::CANCEL, Dialog::RESPONSE_CANCEL]
		)
		dialog.vbox.add(Label.new("Créer le profil " + nom_profil + " ?"))
		dialog.signal_connect("response") { |fenetre, id_rep| operation_choisie = id_rep }
		dialog.show_all
		dialog.run
		dialog.destroy

		return (operation_choisie == Dialog::RESPONSE_OK)
	end
end





