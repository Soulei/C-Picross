#!/usr/bin/env ruby
# encoding=utf-8

# Auteur YANN GUENVER
# Version 0.1
# Date : Dimanche 24 Janvier 2016
# Description : fichier contenant la classe VueJeu du jeu du Picross


require_relative 'Vue'
require_relative 'CaseVue'
require 'gtk2'
load "./Modele/Timer.rb"

# Vue chargée de présenter une interface de jeu
# * *Variables*	:
#    - +lbTimer+ -> label du timer
#    - +timer+ -> timer de la partie
#    - +lbSolution+ -> label du nombre de solution restante
#    - +nbSolution+ -> nombre de solution restante
#    - +btAide+ -> bouton pour obtenir une aide
#    - +btSolution+ -> bouton pour révéler une case
#    - +btRetour+ -> bouton pour annuler le dernier coup
#    - +btHypothese+ -> bouton pour activer/desactiver le mode hypothèses
#    - +btRetourHypothese+ -> bouton pour annuler les hypothèses
#    - +table+ -> table d'affichage
#    - +mat+ -> matrice à afficher
#    - +grille+ -> grille de picross à résoudre
#    - +matFleche+ -> matrice de fleches
# * *Heritage*	: Vue
#
class VueJeu < Vue

	# label de la vue
	@lbTimer
	@timer
	@lbSolution
	@nbSolution
	@btSauvegarde

	# boutons de la vue
	@btAide
	@btSolution
	@btRetour
	@btHypothese
	@btRetourHypothese
	#@btRetro


	@table # tableau d'affichage de la grille
	@tableM # tableau d'affichage des boutons
	@mat # matrice à afficher
	@grille # grille de picross à résoudre
	@matFleche # matrice de fleche


	attr_reader :table, :btSauvegarde, :btRetour, :grille, :btAide, :btIndice, :btSolution,  :btHypothese, :btRetourHypothese#, :btRetro
	attr_accessor :nbSolution, :timer
	private_class_method :new

	#Constructeur de la classe VueJeu
	#
	# * *Paramètres*:
	#   - +uneGrille+ -> Grille de jeu
	#* *Exemple* :
	#
	def VueJeu.creer(uneGrille)
		new(uneGrille)
	end

	def initialize(uneGrille)

		super("Jeu")
		@grille = uneGrille

		# HBox principale
		hbox = Gtk::HBox.new(false, 10)
		@window.add(hbox)

		hbox.pack_start(creerPlateau)
		hbox.pack_start(creerTableAide)
		hbox.set_border_width(5)

		miseAJour

		@window.show_all
		hideFleche
	end


	# Crée une Table contenant les boutons de l'interface
	#
	# * *Paramètres*:
	#
	# * *Retourne* :
	#   -La table contenant les boutons de l'interface
	#* *Exemple* :
	#
	def creerTableAide

		@tableM = Gtk::Table.new(5, 2, true)

		@nbSolution = 3

		@btAide = Gtk::Button.new("Aide ")
		@btSauvegarde = Gtk::Button.new("Sauvegarder ")
		@btSolution = Gtk::Button.new("Solution")
		@lbSolution = Gtk::Label.new("Solutions disponibles : "+@nbSolution.to_s)
		@btRetour = Gtk::Button.new("Annuler coup")
		@btHypothese = Gtk::Button.new("Hypothese")
		@btRetourHypothese = Gtk::Button.new("Annuler hypothese")

		#@btRetro = Gtk::Button.new("Rétrospective")

		@timer = Timer.new()
		@lbTimer = Gtk::Label.new(@timer.start(0).tick)

		@tableM.attach(@lbTimer, 0, 1, 1, 2)
		@tableM.attach(@btRetour, 1, 2, 1, 2)
		@tableM.attach(@btAide, 0, 1, 2, 3)
		@tableM.attach(@btSauvegarde, 1, 2, 2, 3)
		@tableM.attach(@btSolution, 0, 1, 3, 4)
		@tableM.attach(@lbSolution, 1, 2, 3, 4)
		@tableM.attach(@btHypothese, 0, 1, 4, 5)
		@tableM.attach(@btRetourHypothese, 1, 2, 4, 5)
		#@tableM.attach(@btRetro, 0, 1, 4, 5)


		#boutton image
		@btRetour.set_image(Gtk::Image.new(File.expand_path("./Icons/undo.png", File.dirname(__FILE__))))
		@btRetour.set_image_position(POS_BOTTOM)
		@btAide.set_image(Gtk::Image.new(File.expand_path("./Icons/aide.png", File.dirname(__FILE__))))
		@btAide.set_image_position(POS_BOTTOM)
		@btSauvegarde.set_image(Gtk::Image.new(File.expand_path("./Icons/save.png", File.dirname(__FILE__))))
		@btSauvegarde.set_image_position(POS_BOTTOM)



		return @tableM
	end

	#Met à jour l'affichage des solution
	#
	# * *Paramètres*:
	#
	#* *Exemple* :
	#
	def miseAJourNbSolution
		@timer.penalite(20)
		@nbSolution -= 1
		if @nbSolution != 0 then
			@lbSolution.set_text("Solutions disponibles :  "+@nbSolution.to_s)
		else
			@lbSolution.set_text("Solutions épuisées   ")
			@btSolution.sensitive=false
		end
	end

	#Met à jour l'affichage des boutons Hypotèses
	#
	# * *Paramètres*:
	#
	#* *Exemple* :
	#
	def miseAJourHyp
		if @grille.pile.flag then
			@btHypothese.set_label("Valider hypothese")
			@btRetourHypothese.sensitive=true
		else
			@btHypothese.set_label("Hypothese")
			@btRetourHypothese.sensitive=false
		end
	end

	#Met à jour l'affichage du timer
	#
	# * *Paramètres*:
	#
	#* *Exemple* :
	#
	def miseAJourTimer
		Thread.new{
			while (sleep 0.2)and(!(@grille.estTerminerMultiSoluce?)) do
				@lbTimer.set_label(@timer.tick)
			end
		}
	end

	#Met à jour l'affichage du bouton d'aide
	#
	# * *Paramètres*:
	#
	#* *Exemple* :
	#
	def miseAJourAide
		Thread.new{
			while (sleep 0.2)and(!(@grille.estTerminerMultiSoluce?)) do
				if @grille.suggestion[1] != -1 then
					@btAide.sensitive=true
				else
					@btAide.sensitive=false
				end

			end
		}
	end

	#Cache les flèches des aides
	#
	# * *Paramètres*:
	#
	#* *Exemple* :
	#
	def hideFleche
		0.upto(@grille.largeur-1){|x|
			@matFleche[0][x].hide
			@matFleche[1][x].hide
		}
	end

	#Affiche la flèche d'une aide et le message correspondant
	#
	# * *Paramètres*:
	# - +x+ -> Coordonnée de la flèche
	# - +y+ -> Coordonnée de la flèche
	# - +s+ -> Message à afficher
	#* *Exemple* :
	#
	def showFleche(x,y,s)
		@matFleche[x][y].show
		windowA = Gtk::Window.new()
		windowA.set_window_position(Gtk::Window::POS_CENTER)
		windowA.set_modal(true)

		case s
		when "BlocPlein" then windowA.add(Gtk::Image.new(File.expand_path("./Images/GIF/th1.gif", File.dirname(__FILE__))))
		when "Bord" then windowA.add(Gtk::Image.new(File.expand_path("./Images/GIF/th3.gif", File.dirname(__FILE__))))
		when "GrosBloc" then windowA.add(Gtk::Image.new(File.expand_path("./Images/GIF/th2.gif", File.dirname(__FILE__))))
		when "SuiteBloc" then windowA.add(Gtk::Image.new(File.expand_path("./Images/GIF/th4.gif", File.dirname(__FILE__))))
		end

		windowA.show_all
		windowA.signal_connect('destroy'){windowA.hide}

	end


	#Crée le plateau de jeu à partir de la grille
	#
	# * *Paramètres*:
	#
	# * *Retourne* :
	#  - Une table représentant le plateau de jeu
	# * *Exemple* :
	#
	def creerPlateau

		tailleGrille = @grille.largeur
		espacementCases = 2

		@table = Gtk::Table.new(tailleGrille+2, tailleGrille+2, false) # On rajoute 2 pour insérer les infos et les fleches
		@mat = Array.new(tailleGrille) {Array.new(tailleGrille)}
		@matFleche = Array.new(2) {Array.new(tailleGrille)}

		# Infos des lignes et colonnes
		0.upto(tailleGrille-1){|x|
			if (@grille.horizontal != nil) then
				@table.attach(infoHorizontal(@grille.horizontal[x]), x+2, x+3, 1, 2)
				@table.attach(infoVertical(@grille.vertical[x]), 1, 2, x+2, x+3)
			else
				@table.attach(Gtk::Label.new(""), x+2, x+3, 1, 2)
				@table.attach(Gtk::Label.new(""), 1, 2, x+2, x+3)
			end
		}
		# Fleches pour les suggestions
		0.upto(tailleGrille-1){|x|
			tmp = Gtk::Image.new(Gdk::Pixbuf.new("./Vues/Images/arrow-down.png", 25-tailleGrille, 25-tailleGrille))
			@table.attach(tmp, x+2, x+3, 0, 1)
			@matFleche[1][x] = tmp
			tmp = Gtk::Image.new(Gdk::Pixbuf.new("./Vues/Images/arrow-right.png", 25-tailleGrille, 25-tailleGrille))
			@table.attach(tmp, 0, 1, x+2, x+3)
			@matFleche[0][x] = tmp
		}

		# Création de la grille
		0.upto(tailleGrille-1){|x|
			0.upto(tailleGrille-1){|y|
				caseTemp = CaseVue.new("blanc", tailleGrille, @grille, x, y)
				@table.attach(caseTemp, y+2, y+3, x+2, x+3)
				@mat[x][y] = caseTemp
			}
		}
		# Définition de l'espacement des cases toutes les 5 cases
		6.step(tailleGrille, 5){|i|
			@table.set_row_spacing(i, espacementCases)
			@table.set_column_spacing(i, espacementCases)
		}

		return @table
	end

	#Récupère les indices horizontaux des cases noires
	#
	# * *Paramètres*:
	#  - +ind+ -> Le tableau des indices horizontaux
	# * *Retourne* :
	#  - Une VBox contenant les indices des cases noires
	# * *Exemple* :
	#
	def infoHorizontal(ind)

		vBoxTemp = Gtk::VBox.new()
		unless ind.empty?
			ind.each{|elem|
				labelTemp = Gtk::Label.new()
				labelTemp.set_markup(elem.to_s)
				vBoxTemp.add(labelTemp)
			}
		end

		return vBoxTemp
	end

	#Récupère les indices verticaux des cases noires
	#
	# * *Paramètres*:
	#  - +ind+ -> Le tableau des indices verticaux
	# * *Retourne* :
	#  - Une HBox contenant les indices des cases noires
	# * *Exemple* :
	#
	def infoVertical(ind)

		hBoxTemp = Gtk::HBox.new()
		unless ind.empty?
			ind.each{|elem|
				labelTemp = Gtk::Label.new()
				labelTemp.set_markup(elem.to_s+" ")
				hBoxTemp.add(labelTemp)
			}
		end

		return hBoxTemp
	end


	# Met à jour l'affichage des caseVues
	#
	# * *Paramètres*:
	#  - +x+ -> Abscisse de la case
	#  - +y+ -> Ordonnée de la case
	# * *Retourne* :
	#
	# * *Exemple* :
	#
	def miseAJour

		tailleGrille = @grille.largeur

		# Mise à jour de toutes les cases du plateau
		0.upto(tailleGrille-1){|x|
			0.upto(tailleGrille-1){|y|
				actualiserCase(x,y)
			}
		}

		@window.show_all
		hideFleche
	end

	# Met à jour l'affichage d'une caseVue donnée
	#
	# * *Paramètres*:
	#
	# * *Retourne* :
	#
	# * *Exemple* :
	#
	def actualiserCase(x,y)

		# Doit devenir....

		if @grille.matrice[x][y].etatCourant == 0 and not getCaseVue(x,y).etat.eql?("noir")

			if @grille.pile.flag then
				getCaseVue(x,y).changerEtat("gris")
			else
				getCaseVue(x,y).changerEtat("noir")
			end

		elsif @grille.matrice[x][y].etatCourant == 1 and not getCaseVue(x,y).etat.eql?("blanc")

			getCaseVue(x,y).changerEtat("blanc")

		elsif @grille.matrice[x][y].etatCourant == 2 and not getCaseVue(x,y).etat.eql?("croix")

			if @grille.pile.flag then
				getCaseVue(x,y).changerEtat("croixGrise")
			else
				getCaseVue(x,y).changerEtat("croix")
			end

		end
	end

	#Récupère la caseVue aux coordonées données
	#
	# * *Paramètres*:
	#  - +x+ -> Abscisse de la case
	#  - +y+ -> Ordonnée de la case
	# * *Retourne* :
	#  - La caseVue demandée
	# * *Exemple* :
	#
	def getCaseVue(x,y)

		return @mat[x][y]
	end
end
