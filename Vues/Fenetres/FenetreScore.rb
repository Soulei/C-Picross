#
#Definition de la classe FenetreScore qui permet l'affichage des scores pour une grille particulière.

#################################
# IMPORTS			#
#################################
require "gtk2"
require "glib2"

include Gtk


#################################
# FENETRE SCORE			#
#################################
#
class FenetreScore < Window

  def initialize(parent, scores_grille, nom_grille)
    super("Scores")
    signal_connect("destroy") { destroy }
    scores_grille = [["Pas de meilleur score", "Jouez pour être le premier !"]] if scores_grille == nil
    
    table = Table.new(scores_grille.size,2)
    
        table.attach(Label.new.set_markup("<b>#{nom_grille}</b>"), 0, 2, 0, 1)
    
    #Nb : la ligne 0 est dédiée au nom de la grille, c'est pour cela qu'on commence à la ligne 1.
    ligne=1
	
    #Remplissage de la grille de scores.
    scores_grille.each { |score|
      profil_nom, profil_score = score
      
      table.attach(Frame.new.add(Label.new(profil_nom)), 0, 1, ligne, ligne+1)
      table.attach(Frame.new.add(Label.new(profil_score.to_s)), 1, 2, ligne, ligne+1)

      ligne += 1
    }               
    
    add(Frame.new.add(table))
    set_modal(true)            #Cette fenetre bloque les interractions, 
    set_transient_for(parent)  #avec la fenetre parent.
    set_resizable(false)
    set_default_size(300,40+scores_grille.size*30)
     
    set_window_position :center
    show_all
    
    
  end
  
end
