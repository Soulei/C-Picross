# encoding: utf-8
##
# Auteur YOUSSEF LAMNIY
# Version 0.1

###### VUESAUVEGARDE.RB #######



 ############ IMPORTS ##########

require_relative 'Vue'

require "gtk2"
require "glib2"
require "date"
include Gtk

	# * *Description*:
	# 
 	# Vue qui a pour tâche de présenter une interface de choix de grille
 	#
 	## * *Exemple ici*:
	#	
	#	@window.add(profil)	
	#		
	# * *Retourne*:
	#
	# renvoie la fenêtre dans laquelle est attaché la méthode profil contenant la fenetre permettant la saisie du nom de sauvegarde de la partie
class VueSauvegarde < Vue


  @combo_profils
  @entry_nom
  @bouton_valider
  @bouton_annuler

  @btretour
	
	
  @picross


  attr_reader :btretour, :bouton_annuler, :entry_nom, :entry_nom, :bouton_valider, :combo_profils


    def VueSauvegarde.creer()
		new()
	end

	# Vue chargée de présenter une interface de choix de grille
	def initialize()

 		super("Sauvegarder la partie en cours")

         @window.add(profil)
    	 #@window.add(grille)

        @window.show_all
	end

# * *Description*:
	# 
	# méthode permettant de renvoyer la fenêtre de sauvegarde dans laquelle l'utilisateur devra inscrire le nom qu'il a choisit pour sauvegarder la partie
	#
	# * *Exemple*:
	#
	# @window.add(profil)
	#
	# * *Retourne*:
	#
	# renvoie la box contenant le champ et les boutons qui permettent à l'utilisateur d'entrer le titre de sa sauvegarde
	#
    def profil()

        hBox = Gtk::HBox.new(false,3)

  		# ComboBox des profils: création et insertion de chacun des profils existants
  	  	@combo_profils = ComboBoxEntry.new(true) # text only
  	  	@entry_nom = Entry.new

     	# Layout du profil
    	#hBox.pack_start(Label.new("Profil: "))
    	#hBox.pack_start(@combo_profils)


		hBoxG = Gtk::HBox.new(false, 3)
    	hBoxG.pack_start(Label.new("Nom de sauvegarde: "))
    	hBoxG.pack_start(@entry_nom)


    	# Layout des boutons
    	box_bouton = HBox.new
		@bouton_valider = Button.new(Stock::OK)
		@bouton_annuler = Button.new(Stock::CLOSE)
    	box_bouton.pack_start(@bouton_valider, true, true)
    	box_bouton.pack_start(@bouton_annuler, true, true)
    	@bouton_valider.sensitive = false



    	# Layout de la fenêtre
    	box_window = Gtk::VBox.new(false,3)
    	box_window.pack_start(hBox, true, true)
    	box_window.pack_start(hBoxG, true, true)
   	 	box_window.pack_start(box_bouton, true, true)

 		# connects
    	#@combo_profils.signal_connect("changed") { |last|
      	#	self.maj_entry_nom if last != @combo_profils.active_text
    	#}



    	#hBox.pack_start(@btretour = Gtk::Button.new("Retour"))
    	#@bouton_annuler.signal_connect("clicked") { self.destroy }


  		return box_window

    end



  ##
  # Met à jour le nom de la sauvegarde en fonction des paramètres entrés
  #def maj_entry_nom
    #unless @combo_profils.active_text == nil
      # proposer un nom par défaut
      #@entry_nom.set_text("_" + @combo_profils.active_text)
    #end
    #self.maj_button
  #end



end
