#!/usr/bin/env ruby
# encoding=utf-8 

# Auteur YANN GUENVER
# Version 0.1
# Date : Mardi 26 Janvier 2016
# Description : fichier contenant la classe VueJouer du jeu du Picross
# encoding: utf-8

require_relative 'Vue'
require 'gtk2'

# Vue chargée de présenter une interface
# * *Variables*	:
#    - +flagAventure+ -> flag pour les Aventures disponibles
#    - +flagEdit+ -> flag pour les grilles éditées disponibles
#    - +btCreer+ -> bouton pour lancer une nouvelle partie
#    - +btCharger+ -> bouton pour charger une partie
#    - +btRetour+ -> bouton pour retourner un menu principal
#    - +comboChargerA+ -> ComboBox listant les grilles Aventures sauvegardées
#    - +comboChargerD+ -> ComboBox listant les grilles Détentes sauvegardées
#    - +comboChargerE+ -> ComboBox listant les grilles Editées sauvegardées
#    - +comboMode+ -> ComboBox listant les 3 mode de jeu
#    - +comboGrille+ -> ComboBox listant les tailles de grille classique
#    - +comboAventure+ -> ComboBox listant les Aventures
#    - +comboEdit+ -> ComboBox listant les grilles Editées
#    - +table+ -> matrice des boutons et comboBox
# * *Heritage*	: Vue
#
class VueJouer < Vue

    @flagAventure = false
    @flagEdit = false

    @btCreer
    @btCharger
    @btRetour

    @comboChargerA
	@comboChargerD
	@comboChargerE
    @comboMode
    @comboGrille
    @comboAventure
    @comboEdit

    @table

    attr_reader :btCreer, :btCharger, :comboChargerA, :comboChargerD, :comboChargerE, :comboMode, :comboGrille, :comboAventure, :btRetour, :comboEdit
    attr_accessor :flagAventure, :flagEdit

    def VueJouer.creer()
	new()
    end

    # Vue chargée de présenter une interface de choix de grille
    def initialize()
		super("Jouer")
        @window.add(creerMenu)
        @window.show_all
    end

	# Crée le menu pour l'interface
	#
	# * *Paramètres*:
	#
	# * *Retourne* :
	#   - La vBox contenant les boutons de l'interface
	#* *Exemple* :
	#
	def creerMenu
		vBox = Gtk::VBox.new(false,5)
		hBox = Gtk::HBox.new(true,20)
		
		labelVide = Gtk::Label.new()
		
		@comboMode = Gtk::ComboBox.new
		["Aventure","Detente","Grille éditée"].each do |c|
			@comboMode.append_text(c)
		end
		
		hBox.add(Gtk::Label.new("Mode de jeu : "))
		hBox.add(@comboMode)
		
		vBox.pack_start(Gtk::Label.new("Commencer une partie"))
        vBox.pack_start(hBox)
        vBox.pack_start(creerSousMenu)
        vBox.pack_start(labelVide)
        vBox.pack_start(@btRetour = Gtk::Button.new("Retour"))
		
		@btRetour.set_image(Gtk::Image.new(File.expand_path("./Icons/return.png", File.dirname(__FILE__))))

		return vBox
	end

	# Crée le sous-menu pour l'interface
	#
	# * *Paramètres*:
	#
	# * *Retourne* :
	#   - La table contenant les boutons de l'interface
	#* *Exemple* :
	#
    def creerSousMenu()
		@table = Gtk::Table.new(3,2,true)

		@comboChargerA = Gtk::ComboBox.new
		@comboChargerD = Gtk::ComboBox.new
		@comboChargerE = Gtk::ComboBox.new

		
		@comboMode.active = 0
		@comboGrille = Gtk::ComboBox.new
		["5x5","10x10","15x15","20x20"].each do |c|
			@comboGrille.append_text(c)
		end
		@comboGrille.active = 0
		@comboAventure = Gtk::ComboBox.new
		@comboEdit = Gtk::ComboBox.new

		
		@table.attach(Gtk::Label.new("Nouvelle partie :"), 0, 1, 0, 1)
		@table.attach(@comboGrille, 0, 1, 1, 2)
		@table.attach(@comboAventure, 0, 1, 1, 2)
		@table.attach(@comboEdit, 0, 1, 1, 2)
		@table.attach(@btCreer = Gtk::Button.new("Valider"), 0, 1, 2, 3)
		@table.attach(Gtk::Label.new("Charger partie :"), 1, 2, 0, 1)
		@table.attach(@comboChargerA, 1, 2, 1, 2)
		@table.attach(@comboChargerD, 1, 2, 1, 2)
		@table.attach(@comboChargerE, 1, 2, 1, 2)
		@table.attach(@btCharger = Gtk::Button.new("Charger"), 1, 2, 2, 3)


		#image boutton
		@btCreer.set_image(Gtk::Image.new(File.expand_path("./Icons/ok.png", File.dirname(__FILE__))))
		@btCreer.set_alignment(0.3,0)
		@btCharger.set_image(Gtk::Image.new(File.expand_path("./Icons/load.png", File.dirname(__FILE__))))
		@btCharger.set_alignment(0.3,0)
		

	return @table
    end

	# Met à jour l'interface en fonction du mode sélectionné
	#
	# * *Paramètres*:
	#
	# * *Retourne* :
	#
	#* *Exemple* :
	#
    def MiseAJourMode
	Thread.new{
	    while (sleep 0.2) do
			case @comboMode.active
			when 0 then
				@comboChargerA.show
				@comboChargerD.hide
				@comboChargerE.hide

				@comboGrille.hide
				@comboEdit.hide
				@comboAventure.show
				@btCreer.sensitive=true
				if !flagAventure then @btCreer.sensitive=false end
			when 1 then
				@comboChargerA.hide
				@comboChargerD.show
				@comboChargerE.hide

				@comboAventure.hide
				@comboEdit.hide
				@comboGrille.show
				@btCreer.sensitive=true
			when 2 then
				@comboChargerA.hide
				@comboChargerD.hide
				@comboChargerE.show

				@comboAventure.hide
				@comboGrille.hide
				@comboEdit.show
				@btCreer.sensitive=true
				if !flagEdit then @btCreer.sensitive=false end
			end
	    end
	}
    end
end
