#Auteur : LAMNIY Youssef
#
#Définition de la classe permettant à l'utilisateur de pouvoir choisir
#s'il souhaite ou non sauvegarder sa partie lorsqu'il s'apprête à quitter le jeu.

			
#################################
# IMPORTS			#
#################################

load "FenetreSauvegarde.rb"
require "gtk2"
require "glib2"
include Gtk


class FenetreSauvegarderAvantQuitter

	#Impossible de créer une instance de classe.
	private_class_method :new

  def FenetreSauvegarderAvantQuitter.show(picross, timer, parent, appelsAide)
    operation_choisie = Dialog::RESPONSE_OK

	texteInformatif = "<i>Attention vos modifications sur la grille
	courante seront perdues si vous ne la sauvegardez pas.</i>"
	
    #Vérification de création de profil.
    dialog = Dialog.new(
		"Voulez-vous sauvegarder?", 
		parent, 
		Dialog::DESTROY_WITH_PARENT | Dialog::MODAL
	)
	
	dialog.vbox.pack_start(labelInfo = Label.new.set_markup(texteInformatif))
	labelInfo.set_justify(JUSTIFY_CENTER)
	dialog.vbox.pack_start(hbox = HBox.new)

	hbox.pack_start(btnQuit = Button.new("Quitter sans sauvegarder"))
	hbox.pack_start(btnAnnuler = Button.new("Annuler"))
	hbox.pack_start(btnSauvegarder = Button.new("Sauvegarder"))

	btnQuit.signal_connect("clicked"){ parent.destroy }
	btnAnnuler.signal_connect("clicked"){ dialog.destroy }

	btnSauvegarder.signal_connect("clicked"){
		fenetreSauvegarde = FenetreSauvegarde.new(picross, timer, appelsAide)
		fenetreSauvegarde.signal_connect("destroy"){parent.destroy}
    }

    dialog.signal_connect("destroy"){dialog.destroy}

    dialog.set_resizable(false)
    dialog.show_all
    dialog.run
  end
end 





	
