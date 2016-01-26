##
# Auteur YANN GUENVER
# Version 0.1
# Date : Mardi 26 Janvier 2016
# Description : fichier contenant la classe VueNouveauJeu du jeu du Picross

require_relative 'Vue'

require 'gtk2'

# Classe abstraite définissant les attributs et comportements généraux de nos vues concrètes
class VueNouveauJeu < Vue
    
	@btGrille5
    @btGrille10
    @btGrille15
    @btGrille20
    @btGrille25
    
    @btretour    

    def VueNouveauJeu.creer()
		new()
	end

	# Vue chargée de présenter une interface de choix de grille
	def initialize()
	
		super("Choix")
        
        hBox = Gtk::HBox.new(true,3)
        
        @window.add(hBox)
        
        labelVide = Gtk::Label.new()
        labelVide2 = Gtk::Label.new()
        
        hBox.pack_start(labelVide)
        hBox.pack_start(creerMenu)
        hBox.pack_start(labelVide2)

        @window.show_all
	end
	
	
    # Crée le menu de la page
    def creerMenu()
        vBox = Gtk::VBox.new(true,9)

        labelVide = Gtk::Label.new()
        labelVide2 = Gtk::Label.new()
        labelTitre = Gtk::Label.new("Choisissez une taille :")
        
        vBox.pack_start(labelTitre)
        vBox.pack_start(labelVide)
        vBox.pack_start(@btGrille5 = Gtk::Button.new("Grille 5 x 5"))
        vBox.pack_start(@btGrille10 = Gtk::Button.new("Grille 10 x 10"))
        vBox.pack_start(@btGrille15 = Gtk::Button.new("Grille 15 x 15"))
        vBox.pack_start(@btGrille20 = Gtk::Button.new("Grille 20 x 20"))
        vBox.pack_start(@btGrille15 = Gtk::Button.new("Grille 25 x 25"))
        vBox.pack_start(labelVide2)
        vBox.pack_start(@btretour = Gtk::Button.new("Retour"))

        return vBox
    end
end
