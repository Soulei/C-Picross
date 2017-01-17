# encoding: utf-8

##
# Version 0.1
#

######## 	VUEHIGHSCORE.RB 	########

######## 	IMPORTS 	###########


require "gtk2"
require "glib2"
include Gtk

require_relative 'Vue'
require_relative 'ListeElements'
require_relative '../Modele/BaseDonnee'

	# * *Description*:
	#
 	# VueHighScore qui a pour tâche de présenter une interface contenant les meilleurs scores de chaque utilisateur
 	# en fonction de chaque partei sauvegardée pour chaque mode joué.
 	#
 	## * *Exemple ici*:
	#
	#	@window.add(modeScore)
	#
	# * *Retourne*:
	#
	# renvoie la fenêtre dans laquelle est attaché la méthode modeScore contenant la fenetre
	# permettant l'affichage du tableau des scores
class VueHighScore < Vue

	@tailleGrille
	@chemin	#Texte qui est toit "vide" soit l'image soit plein(en cours).
	@btretour
	@vBoxMilieu
	@table
	@texteAfficherScores
	@boutonPrecedent
	@listeScores
	@boutonChargerImage

	@rbCharger

	@ligne

	@boutonValider

	@mode
	@taille
	@type_score

	attr_reader :btretour, :rbVierge, :rbPleine, :boutonPrecedent, :texteAfficherScores, :listeScores, :table, :hBoxMilieu, :mode, :taille, :type_score

    def VueHighScore.creer()
		new()
	end

	# Vue chargée de présenter une interface de choix de grille
	def initialize()

		@chemin = "vierge"
		super("Classement")
		@window.add(modeScore)
		@window.show_all
	end

	# * *Description*:
	#
 	# Méthode qui a pour tâche de présenter une interface contenant les meilleurs scores de chaque utilisateur
 	# en fonction de chaque partie sauvegardée pour chaque mode joué.
 	#
 	# @window.add(modeScore)
	#
	# * *Retourne*:
	#
	# renvoie la verticale box principale dans laquelle il y a tous les elements permettant le choix du mode, de la grille (et de sa taille) pour l'affichage des scores
	#
	def modeScore()
		vBoxPrincipal = Gtk::VBox.new(false,3)
		vBoxPrincipal.pack_start(hBoxHaut 	= HBox.new(false, 70))
		vBoxPrincipal.pack_start(vBoxMilieu	= VBox.new(false, 20))
		vBoxPrincipal.pack_start(hBoxBas 	= HBox.new(false, 25))

		hBoxHaut.pack_start(Frame.new("Mode").add(hBoxTaille = HBox.new(false, 30)))

		@comboMode = Gtk::ComboBox.new

		["Aventure","Detente","Grille éditée"].each do |c|
			@comboMode.append_text(c)
		end
		@comboMode.active = 0

		@comboGrille = Gtk::ComboBox.new

		["5x5","10x10","15x15","20x20"].each do |c|
			@comboGrille.append_text(c)
		end
		@comboGrille.active = 0
    	ligne=1

		@comboAventure = Gtk::ComboBox.new
		@comboEdit = Gtk::ComboBox.new

		hBoxTaille.pack_start(@comboMode)
		hBoxTaille.pack_start(@comboGrille)
		hBoxTaille.pack_start(@comboAventure)
		hBoxTaille.pack_start(@comboEdit)

		hBoxHaut.pack_start(Frame.new("Type").add(hBoxType = HBox.new(false, 25)))

		hBoxType.pack_start(@rbVierge = RadioButton.new("1er test"))
		hBoxType.pack_start(@rbPleine = RadioButton.new(rbVierge, "2eme test"))

		#rbVierge = RadioButton.new("Vierge")

		vBoxMilieu.pack_start(scroll = ScrolledWindow.new())
		scroll.add_with_viewport(table = Table.new(1, 1, false))

      	table.attach(Frame.new("Nom").add(Label.new("Recuperer les noms ")), 0, 1, ligne, ligne+1)
      	table.attach(Frame.new("Score").add(Label.new("Recuperer les temps")), 1, 2, ligne, ligne+1)
      	#table.attach(Frame.new("Rang").add(Label.new("Recuperer le rang")), 2, 3, ligne, ligne+1)

		bd = BaseDonne.new()


		mode = 	@comboMode.append_text(c)
		taille = @comboGrille.append_text(c)


		score_grille = bd.extract_score(mode, taille, type_score)


		scores_grille.each { |score|
      	profil_nom, profil_score = score

      	table.attach(Frame.new.add(Label.new(profil_nom)), 0, 1, ligne, ligne+1)
      	table.attach(Frame.new.add(Label.new(profil_score.to_s)), 1, 2, ligne, ligne+1)

      	ligne += 1
    	}

		#tab_score = bd.extract_score(mode, taille, nom, score, type_score)
		#tab_score.each{|x|
		#	@hBoxMilieu.pack_start(@texteAfficherScores = Gtk::Label.new(x.to_s))
		#}
		#hBoxMilieu.pack_start(@texteAfficherScores = Gtk::Label.new("Classement des joueurs de Picross"))
	#	listeScores = [1, "usine", 3]
		#@listeScores = ListeElements.new(listeScores, true)

		#hBoxMilieu.pack_start(@listeScores.widget(), true, true, 5)


		#hBoxMilieu.pack_start(bd.extract_score(mode, taille, nom, score, type_score))



		#Ajout de la 2eme horizontal box contenant les boutons
		#hBoxBas.pack_start(btretour = Button.new(Stock::CLOSE), true, true)
		hBoxBas.pack_start(@btretour = Gtk::Button.new("Retour"))


		#set_modal(true)



        return vBoxPrincipal
    end

	# * *Description*:
	#
 	# Méthode qui a pour tâche d'actualiser les combo boxs en fonction du choix de l'utilisateur
 	#
 	# @vue.MiseAJourMode (dans ControleurScore.rb)
	#
	# * *Retourne*:
	#
	# renvoie la mise à jour de chacune des listes de modes et/ou de tailles de grilles et de parties disponibles.
	#
  def MiseAJourMode
  	Thread.new{
  	    while (sleep 0.2) do
    			case @comboMode.active
    			when 0 then
    				@comboGrille.sensitive=false
    				@comboEdit.sensitive=false
    				@comboAventure.sensitive=true

    			when 1 then
    				@comboAventure.sensitive=false
    				@comboEdit.sensitive=false
    				@comboGrille.sensitive=true
    			when 2 then
    				@comboAventure.sensitive=false
    				@comboGrille.sensitive=false
    				@comboEdit.sensitive=true
    			end
  	    end
  	}
  end

end
