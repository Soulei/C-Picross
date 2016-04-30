# encoding: utf-8

##
# Auteur YOUSSEF LAMNIY
# Version 0.1

##### CONTROLEURNOMGRILLE.RB #####


####### IMPORTS #########

require "gtk2"
require "glib2"
require "date"
include Gtk


load "./Vues/VueNomGrille.rb"
load "./Modele/Jeu.rb"
load "./Vues/VueJeu.rb"


require_relative 'Controleur'
require_relative 'ControleurJeu'


class ControleurNomGrille < Controleur

    def ControleurNomGrille.creer(unJeu,unJoueur, matrice, largeur)
		new(unJeu,unJoueur, matrice, largeur)
	end

    def initialize(unJeu,unJoueur, matrice, largeur)

		super(unJeu,unJoueur)

		@vue = VueNomGrille.creer()


		@vue.bouton_annuler.signal_connect('clicked') {
			changerControleur(ControleurMenu.creer(@jeu,@joueur))
		}

		@vue.entry_nom.signal_connect("insert_text") { |last|
   	  	 self.maj_button
    	}


		@vue.bouton_valider.signal_connect("clicked") {
     	 	#nom_profil = @combo_profils.active_text
      		nom_savgrd = @vue.entry_nom.text
      		validation = true
      		@jeu.bd.save_grillePersonnalisee(@joueur, matrice, largeur, nom_savgrd)

      		#sauvegarder(nom_savgrd)
			#@jeu.bd.save_partie(@joueur, nom_savgrd , @vue.timer.accumulated , @vue.grille.pile , @vue.grille, @vue.nbSolution, "ma_grille", 0)
      		self.confirmerSauvegarde(nom_savgrd)
		}

		@vue.window.signal_connect('delete_event') {
			quitterJeu
		}

	end



  ##
  # Met à jour les boutons de la fenêtre.
  def maj_button
    if @vue.combo_profils.active_text != nil and not @vue.entry_nom.text.empty? then
        @vue.bouton_valider.sensitive = true
      else
        @vue.bouton_valider.sensitive = false
    end
  end


	def sauvegarder(nom_sauvegarde)
		puts "pile_cooups"
		@vue.grille.pile.pile.each{ |x| print("\n",x.case.abscisse,"---",x.case.ordonne)}
		@jeu.bd.save_partie(@joueur, nom_sauvegarde , @vue.timer.accumulated , @vue.grille.pile , @vue.grille, @vue.nbSolution, "ma_grille", 0)
	end


  ##
  # Confirme à l'utilisateur que la sauvegarde à été effectuée
  def confirmerSauvegarde(nom_sauvegarde)
    dialog = MessageDialog.new(
      nil,
      Dialog::DESTROY_WITH_PARENT | Dialog::MODAL,
      MessageDialog::INFO,
      MessageDialog::BUTTONS_CLOSE,
      "Sauvegarde \n\""+nom_sauvegarde+"\"\neffectuée !"
    )

    dialog.run
    dialog.destroy
  end


end
