# Auteur : LAMNIY Youssef
#
# Definition de la classe FenetreSauvegarde, permettant la sauvegarde d'une partie en cours de jeu.
#

			
#################################
# IMPORTS			#
#################################
load "ConfirmerNouveauProfil.rb"

require "gtk2"
require "glib2"
require "date"
include Gtk



#################################
# FENETRE SAUVEGARDE            #
#################################

class FenetreSauvegarde < Window
  @picross
  @combo_profils
  @entry_nom
  @bouton_valider
  @bouton_annuler	

  ## 
  #Prend une instance de class Picross en paramètre.
  def initialize(picross, temps_ecoule, nbAppelAide)
    super("Sauvegarder la partie en cours")
    signal_connect("destroy") { destroy }
    set_default_size(100,300)
    set_modal(true)
    set_resizable(false)
    @picross = picross
  
    #ComboBox des profils : création et insertion de chacun des profils existants.
    @combo_profils = ComboBoxEntry.new(true) #Texte seulement
    picross.profils.each { |nom| @combo_profils.append_text(nom) }
  
    #Layout du profil.
    box_profil = HBox.new
    box_profil.pack_start(Label.new("Profil : "))
    box_profil.pack_start(@combo_profils)

    #Layout de la grille.
    box_grille = HBox.new
    @entry_nom = Entry.new
    box_grille.pack_start(Label.new("Nom de sauvegarde : "))
    box_grille.pack_start(@entry_nom)


    #Layout des boutons.
    box_bouton = HBox.new
	@bouton_valider = Button.new(Stock::OK)
	@bouton_annuler = Button.new(Stock::CLOSE)
    box_bouton.pack_start(@bouton_valider, true, true)
    box_bouton.pack_start(@bouton_annuler, true, true)
    @bouton_valider.sensitive = false

    #Layout de la fenêtre.
    box_window = VBox.new
    box_window.pack_start(box_profil, true, true)
    box_window.pack_start(box_grille, true, true)
    box_window.pack_start(box_bouton, true, true)
    self.add(box_window)
    self.set_window_position :center
    self.show_all

    #Connects.
    @combo_profils.signal_connect("changed") { |last|
      self.maj_entry_nom if last != @combo_profils.active_text 
    }
    @entry_nom.signal_connect("insert_text") { |last|
      self.maj_button
    }
    @bouton_valider.signal_connect("clicked") {
      nom_profil = @combo_profils.active_text
      nom_savgrd = @entry_nom.text
      validation = true

      #Vérification de création de profil.
      if not @picross.profils.include?(nom_profil) then
        validation = ConfirmerNouveauProfil.show(self, nom_profil)
      end

      #Sauvegarde.
      if validation and not nom_savgrd.empty? then
        picross.ajouterProfil(nom_profil)
        if picross.sauverGrilleJouable(nom_savgrd, temps_ecoule, nbAppelAide) then
          self.confirmerSauvegarde(nom_savgrd)
          self.destroy
        else 
          if self.ecraserSauvegarde?(nom_savgrd) then
            picross.sauverGrilleJouable(nom_savgrd, temps_ecoule, nbAppelAide, true)
            self.confirmerSauvegarde(nom_savgrd)
            self.destroy
          end
        end
      end
    }
    @bouton_annuler.signal_connect("clicked") { self.destroy }

  end
  
  
  ##
  #Mise à jour du nom de la sauvegarde en fonction des paramètres entrés.
  def maj_entry_nom
    unless @combo_profils.active_text == nil
      #Proposer un nom par défaut.
      @entry_nom.set_text(@picross.grille.nom + "_" + @combo_profils.active_text)
    end
    self.maj_button
  end
  
  
  ##
  #Mise à jour des boutons de la fenêtre.
  def maj_button
    if @combo_profils.active_text != nil and not @entry_nom.text.empty? then
        @bouton_valider.sensitive = true
      else
        @bouton_valider.sensitive = false
    end
  end
  
  
  ##
  #Confirme à l'utilisateur que la sauvegarde a été effectuée.
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
  
  
  ##
  #La sauvegarde n'a pas été effectuée. 
  #L'utilisateur en est informé.
  #Il peut choisir de sauvegarder par dessus la sauvegarde déjà existante, ou revenir en arrière.
  #La méthode renvoie vrai si l'utilisateur veut écraser la sauvegarde, faux sinon.
  def ecraserSauvegarde?(nom_sauvegarde)
    dialog = Dialog.new(
      "La sauvegarde existe déjà !", 
      parent,
      Dialog::DESTROY_WITH_PARENT | Dialog::MODAL,
      ["Écraser", 1], 
      ["Revenir en arrière", 2]
    )
    operation_choisie = 1
    dialog.vbox.add(Label.new("Écraser la sauvegarde " + nom_sauvegarde + " ?"))
    dialog.signal_connect("response") { |fenetre, id_rep| operation_choisie = id_rep }
    dialog.show_all
    dialog.run
    dialog.destroy

    return operation_choisie == 1
  end

end